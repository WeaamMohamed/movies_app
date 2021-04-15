import 'package:movie_app/models/tv_shows_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/constants.dart';

class TvShowsApi {
  Future<List<TvShowsResults>> getTopRatedTvShows() async {
    var url = Uri.parse(topRatedTvShowsUrl);
    // Await the http get response, then decode the json-formatted response.
    http.Response response = await http.get(url);
    // If the server did return a 200 OK response,
    // then parse the JSON.
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return TvShowsModel.fromJson(jsonData).results;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load Top Rated Tv Shows');
    }
  }

  Future<List<TvShowsResults>> getPopularTvShows() async {
    var url = Uri.parse(popularTvShowsUrl);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      return TvShowsModel.fromJson(jsonData).results;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load Popular Tv Shows');
    }
  }
}
