import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/models/movies_response.dart';
import 'package:tmdb/screens/movies/movie_details_screen.dart';
import 'package:tmdb/screens/movies/movies_notifier.dart';
import 'package:tmdb/screens/tv/tv_notifier.dart';
import 'package:tmdb/utils/router.dart';
import 'package:tmdb/widgets/movies_grid_list.dart';
import 'package:tmdb/widgets/movies_image.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key, required this.displayMovies});

  final bool displayMovies;

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late MoviesNotifier moviesNotifier;
  late TvNotifier tvNotifier;

  @override
  void initState() {
    moviesNotifier = context.read<MoviesNotifier>();
    moviesNotifier.init();
    tvNotifier = context.read<TvNotifier>();
    tvNotifier.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.of(context);
    return DefaultTabController(
      length: widget.displayMovies ? 3 : 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Now Playing",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: widget.displayMovies
                  ? moviesNotifier.nowPlayingMoviesFuture
                  : tvNotifier.latestTvShowsFuture,
              builder: (context, AsyncSnapshot<List<Movie>?> snapshot) {
                if (snapshot.hasData) {
                  final movies = snapshot.data!;
                  return SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ListView.separated(
                      itemCount: movies.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            // final List<Genre> movieGenres =
                            //     moviesNotifier.getGenresNames(movie.genreIds);
                            router.goToScreen(
                              MovieDetailsScreen(
                                movie: movie,
                                // genres: [Genre(id: 1, name: "Actions")],
                              ),
                            );
                          },
                          child: Hero(
                            tag: Key(movie.backdropPath.toString()),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: MovieImage(
                                movie: movie,
                                height: 50,
                                heightDiskCache: 300,
                                isPosterImage: false,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 20,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(
                    width: double.infinity,
                    height: 320,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TabBar(
              indicatorWeight: 4,
              indicatorColor: Colors.blue,
              tabs:
                  widget.displayMovies ? moviesTabs(context) : tvTabs(context),
            ),
            Expanded(
              child: SizedBox(
                child: TabBarView(
                  children:
                      widget.displayMovies ? moviesTabBarViews : tvTabBarViews,
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

  List<Widget> get moviesTabBarViews {
    return [
      MoviesGridList(
        future: widget.displayMovies
            ? moviesNotifier.getTopRatedMovies()
            : tvNotifier.getTopRatedTvShows(),
        // genres: moviesNotifier.genres,
      ),
      MoviesGridList(
        future: moviesNotifier.getUpcomingMovies(),
        // genres: moviesNotifier.genres,
      ),
      MoviesGridList(
        future: widget.displayMovies
            ? moviesNotifier.getPopularMovies()
            : tvNotifier.getPopularTvShows(),
        // genres: moviesNotifier.genres,
      ),
    ];
  }

  List<Widget> get tvTabBarViews {
    return [
      MoviesGridList(
        future: widget.displayMovies
            ? moviesNotifier.getTopRatedMovies()
            : tvNotifier.getTopRatedTvShows(),
        // genres: moviesNotifier.genres,
      ),
      MoviesGridList(
        future: widget.displayMovies
            ? moviesNotifier.getPopularMovies()
            : tvNotifier.getPopularTvShows(),
        // genres: moviesNotifier.genres,
      ),
    ];
  }

  List<Widget> moviesTabs(BuildContext context) {
    return [
      Tab(
        child: Text(
          "Top Rated",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      Tab(
        child: Text(
          "Upcoming",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      Tab(
        child: Text(
          "Popular",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    ];
  }

  List<Widget> tvTabs(BuildContext context) {
    return [
      Tab(
        child: Text(
          "Top Rated",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      Tab(
        child: Text(
          "Popular",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    ];
  }
}
