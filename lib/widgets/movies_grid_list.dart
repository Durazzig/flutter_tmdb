import 'package:flutter/material.dart';
import 'package:tmdb/models/movies_response.dart';
import 'package:tmdb/screens/movies/movie_details_screen.dart';
import 'package:tmdb/utils/router.dart';
import 'package:tmdb/widgets/movies_image.dart';

class MoviesGridList extends StatelessWidget {
  const MoviesGridList({
    required this.future,
    // required this.genres,
    Key? key,
  }) : super(key: key);
  final Future<List<Movie>?> future;
  // final List<Genre> genres;
  @override
  Widget build(BuildContext context) {
    final router = AppRouter.of(context);
    return Container(
      padding: const EdgeInsets.only(
        top: 10.0,
      ),
      child: FutureBuilder<List<Movie>?>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              physics: const ScrollPhysics(),
              // physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.6,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    // final List<Genre> movieGenres =
                    //     notifier.getGenresNames(movie.genreIds);
                    router.goToScreen(
                      MovieDetailsScreen(
                        movie: movie,
                        // genres: [Genre(id: 1, name: "Actions")],
                      ),
                    );
                  },
                  child: Hero(
                    tag: Key(movie.posterPath.toString()),
                    child: MovieImage(
                      movie: movie,
                      height: 300,
                      heightDiskCache: 300,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
