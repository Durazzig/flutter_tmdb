import 'package:tmdb/models/movies_response.dart';

class Utils {
  static String getGenre(int genreId) {
    switch (genreId) {
      case 12:
        return 'Adventure';
      case 10759:
        return 'Action & Adventure';
      case 28:
        return 'Action';
      case 16:
        return 'Animation';
      case 35:
        return 'Comedy';
      case 80:
        return 'Crime';
      case 99:
        return 'Documentary';
      case 18:
        return 'Drama';
      case 10751:
        return 'Family';
      case 14:
        return 'Fantasy';
      case 36:
        return 'History';
      case 27:
        return 'Horror';
      case 10762:
        return 'Kids';
      case 10763:
        return 'News';
      case 9648:
        return 'Mystery';
      case 10764:
        return 'Reality';
      case 10749:
        return 'Romance';
      case 878:
        return 'Science Fiction';
      case 10765:
        return 'Sci-Fi & Fantasy';
      case 10766:
        return 'Soap';
      case 10767:
        return 'Talk';
      case 53:
        return 'Thriller';
      case 10770:
        return 'TV Movie';
      case 10768:
        return 'War & Politics';
      case 10752:
        return 'War';
      case 37:
        return 'Western';
      case 10402:
        return 'Music';
      default:
        return 'Unknown Genre';
    }
  }

  static String getGenresString(Movie movie) {
    String genres = "";
    int index = 0;
    for (var genreId in movie.genreIds) {
      final genre = getGenre(genreId);
      if (index == movie.genreIds.length - 1) {
        genres = "$genres$genre";
      } else {
        genres = "$genres$genre, ";
      }
      index++;
    }
    return genres;
  }

  static String getMediaType(Movie movie) {
    if (movie.mediaType != null) {
      return movie.mediaType == "movie" ? "Movie" : "Tv Show";
    }
    return "";
  }
}
