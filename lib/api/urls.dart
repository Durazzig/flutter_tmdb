abstract class Urls {
  // Place here your TMDB api key
  // ignore: non_constant_identifier_names
  static String apiKey = "";
  static String baseUrl = "https://api.themoviedb.org/3/";

  //Movies
  static String nowPlayingMovies =
      "${baseUrl}movie/now_playing?api_key=$apiKey";
  static String topRatedMovies = "${baseUrl}movie/top_rated?api_key=$apiKey";
  static String upcomingMovies = "${baseUrl}movie/upcoming?api_key=$apiKey";
  static String popularMovies = "${baseUrl}movie/popular?api_key=$apiKey";
  static String search(String searchQuery) {
    return '${baseUrl}search/multi?query=$searchQuery&api_key=$apiKey';
  }

  //Tv
  static String latestTvShows = "${baseUrl}tv/on_the_air?api_key=$apiKey";
  static String topRatedTvShows = "${baseUrl}tv/top_rated?api_key=$apiKey";
  static String popularTvShows = "${baseUrl}tv/popular?api_key=$apiKey";

  //Auth
  static String getSessionId =
      "${baseUrl}authentication/session/new?api_key=$apiKey";
  static String getRequestToken =
      "${baseUrl}authentication/token/new?api_key=$apiKey";
  static String getProfileInformationUrl(String sessionId) {
    return '${baseUrl}account?session_id=$sessionId&api_key=$apiKey';
  }

  //Watch Lists
  static String getWatchListsUrl(String sessionId, int profileId) {
    return '${baseUrl}account/$profileId/lists?session_id=$sessionId&api_key=$apiKey';
  }

  static String getWatchListsDetailsUrl(int listId) {
    return '${baseUrl}list/$listId/lists?api_key=$apiKey';
  }
}
