import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/screens/movies/movie_details_screen.dart';
import 'package:tmdb/screens/search/search_notifier.dart';
import 'package:tmdb/utils/debounce.dart';
import 'package:tmdb/utils/router.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:tmdb/widgets/movies_image.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchNotifier = context.read<SearchNotifier>();
    final router = AppRouter.of(context);
    final Debounce debounce = Debounce(const Duration(milliseconds: 1200));

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Search your movie or tv series"),
            const SizedBox(
              height: 10,
            ),
            Consumer<SearchNotifier>(builder: (context, notifier, child) {
              return TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF3A3F47),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: notifier.loadingState == LoadingState.loading
                      ? const CupertinoActivityIndicator(
                          color: Colors.white,
                        )
                      : const Icon(Icons.search),
                ),
                onChanged: (query) {
                  if (query.length >= 3) {
                    debounce(() {
                      searchNotifier.searchMovie(query);
                    });
                  }
                },
              );
            }),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Consumer<SearchNotifier>(
                  builder: (context, notifier, child) {
                    if (notifier.loadingState == LoadingState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (notifier.loadingState == LoadingState.error) {
                      return const Center(
                        child: Text(
                          "There was a problem requesting the information you wanted, please try again later.",
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    if (notifier.loadingState == LoadingState.done &&
                            notifier.searchResults!.isEmpty ||
                        notifier.loadingState == LoadingState.none) {
                      return Container();
                    } else {
                      return ListView.separated(
                        itemCount: notifier.searchResults!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final movie = notifier.searchResults![index];

                          return GestureDetector(
                            onTap: () {
                              // final List<Genre> movieGenres = searchNotifier
                              //     .getGenresNames(movie.genreIds);
                              router.goToScreen(
                                MovieDetailsScreen(
                                  movie: movie,
                                  // genres: [Genre(id: 1, name: "Actions")],
                                ),
                              );
                            },
                            child: SizedBox(
                              width: double.infinity,
                              height: 250,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: Key(movie.posterPath.toString()),
                                    child: MovieImage(
                                      movie: movie,
                                      height: 250,
                                      heightDiskCache: 250,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                movie.title ?? movie.name!,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              movie.voteAverage
                                                  .toStringAsFixed(2),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.movie,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                Utils.getGenresString(movie),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                Utils.getMediaType(movie),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
