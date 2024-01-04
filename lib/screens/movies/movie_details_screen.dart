import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/movies_response.dart';
import 'package:tmdb/utils/utils.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        top: true,
        left: false,
        right: false,
        bottom: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: size.width,
                height: 320,
                // alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    Hero(
                      tag: Key(movie.backdropPath.toString()),
                      child: Container(
                        width: size.width,
                        height: 250,
                        color: Colors.white,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 0,
                      child: Container(
                        width: 130,
                        height: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Hero(
                          tag: Key(movie.posterPath.toString()),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://image.tmdb.org/t/p/original/${movie.posterPath}",
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Container(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            movie.title != null ? movie.title! : movie.name!,
                            style: const TextStyle(fontSize: 26),
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
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${movie.releaseDate != null ? movie.releaseDate?.year : movie.firstAirDate?.year}",
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.movie,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: 20,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: movie.genreIds.length,
                              itemBuilder: (context, index) => Text(
                                Utils.getGenre(
                                  movie.genreIds[index],
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const Text(", "),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: size.width,
                      child: Text(
                        "About",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      movie.overview,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      actions: [
        TextButton(
          onPressed: () {},
          child: const Row(
            children: [
              Text(
                "Add to list",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.add_box,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
      backgroundColor: const Color(0xFF242A32),
      elevation: 0,
    );
  }
}
