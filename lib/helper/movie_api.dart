import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movie_cast_and_crew_model.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/trailer_model.dart';

class MovieApi {
  Future<List<Results>> getNowPlayingMovies() async {
    var url = Uri.parse(nowPlayingMovieUrl);
    // Await the http get response, then decode the json-formatted response.
    http.Response response = await http.get(url);
    MovieModel nowPlayingModel;
    //successful
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = jsonDecode(response.body);
      nowPlayingModel = MovieModel.fromJson(jsonData);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load now playing movies');
    }
    return nowPlayingModel.results;
  }

  Future<List<Results>> getUpComingMovies() async {
    var url = Uri.parse(upcomingMovieUrl);
    http.Response response = await http.get(url);
    MovieModel upComingModel;
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      upComingModel = MovieModel.fromJson(jsonData);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load upComing Movies');
    }
    return upComingModel.results;
  }

  Future<List<Results>> getPopularMovies() async {
    var url = Uri.parse(popularMovieUrl);
    http.Response response = await http.get(url);
    MovieModel popularModel;
    //successful
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      popularModel = MovieModel.fromJson(jsonData);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load popular movies');
    }
    return popularModel.results;
  }

  Future<List<Results>> getTopRatedMovies() async {
    var url = Uri.parse(topRatedMovieUrl);
    http.Response response = await http.get(url);
    //successful
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return MovieModel.fromJson(jsonData).results;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load Top Rated movies');
    }
  }

  Future<MovieDetailModel> getDetailsMovie(String detailURL) async {
    var url = Uri.parse(detailURL);
    http.Response response = await http.get(url);

    MovieDetailModel detailModel;
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return MovieDetailModel.fromJson(jsonData);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load movie details');
    }
  }

  Future<MovieCastAndCrewModel> getCastAndCrewMovie(String castURL) async {
    var url = Uri.parse(castURL);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      return MovieCastAndCrewModel.fromJson(jsonData);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load Cast and Crew');
    }
  }

  Future<MovieModel> searchMovieByTitle(String movieTitle) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&query=${movieTitle.replaceAll(' ', '+')}');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      return MovieModel.fromJson(jsonData);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load Cast and Crew');
    }
  }

  Future<List<VideoModel>> getMovieTrailers(int movieId) async {
    var url = Uri.parse('$BASE_MOVIE_URL/$movieId/videos?api_key=$API_KEY');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return TrailerModel.fromJson(jsonData).videos;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load Cast and Crew');
    }
  }
}
