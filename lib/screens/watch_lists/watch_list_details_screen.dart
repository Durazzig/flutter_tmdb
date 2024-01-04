import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/screens/movies/movie_details_screen.dart';
import 'package:tmdb/screens/watch_lists/watch_lists_notifier.dart';
import 'package:tmdb/utils/utils.dart';

class WatchListDetailsScreen extends StatelessWidget {
  const WatchListDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<WatchListsNotifier>();
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Watch List Details",
          ),
        ),
        backgroundColor: const Color(0xFF242A32),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
          future: notifier.getWatchListDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final watchListDetails = snapshot.data!;
                if (watchListDetails.itemCount < 1) {
                  return const Center(
                    child: Text("You dont have any movies in your watch list"),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      // setState(() {
                      //   watchListsNotifier.init();
                      // });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "List Author: ${watchListDetails.createdBy}",
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final movie = snapshot.data!.movies[index];
                              return GestureDetector(
                                onTap: () {
                                  // final List<Genre> movieGenres = searchNotifier
                                  //     .getGenresNames(movie.genreIds);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailsScreen(
                                        movie: movie,
                                        // genres: [Genre(id: 1, name: "Actions")],
                                      ),
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
                                        child: Container(
                                          height: 250,
                                          width: 170,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://image.tmdb.org/t/p/original/${movie.posterPath}",
                                              fit: BoxFit.fill,
                                              height: 50,
                                              placeholder: (context, url) {
                                                return const FadeShimmer(
                                                  width: 170,
                                                  height: 250,
                                                  highlightColor:
                                                      Color(0xff22272f),
                                                  baseColor: Color(0xff20252d),
                                                );
                                              },
                                              errorWidget: (context, error,
                                                      stackTrace) =>
                                                  Container(
                                                width: 170,
                                                height: 250,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    movie.title ?? movie.name!,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
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
                                            const SizedBox(
                                              height: 20,
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
                                                    Utils.getGenresString(
                                                        movie),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
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
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount: watchListDetails.itemCount,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return const Center(
                  child: Text(
                    "There was a problem fetching your watch list details, please try again later",
                    textAlign: TextAlign.center,
                  ),
                );
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}
