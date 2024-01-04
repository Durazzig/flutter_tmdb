import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/movies_response.dart';

class MovieImage extends StatelessWidget {
  const MovieImage({
    super.key,
    required this.movie,
    required this.height,
    required this.heightDiskCache,
    this.isPosterImage = true,
  });

  final Movie movie;
  final double height;
  final int heightDiskCache;
  final bool isPosterImage;

  @override
  Widget build(BuildContext context) {
    final path = isPosterImage ? movie.posterPath : movie.backdropPath;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        imageUrl: 'https://image.tmdb.org/t/p/w500/$path',
        height: height,
        maxHeightDiskCache: heightDiskCache,
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) {
          return Image.asset("assets/movie-background-collage.jpg");
        },
      ),
    );
  }
}
