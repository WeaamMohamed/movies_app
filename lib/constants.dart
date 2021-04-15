import 'package:flutter/material.dart';

const API_KEY = "b938c03ef87ff499be4f26ddfbf181e1";
const BASE_MOVIE_URL = "https://api.themoviedb.org/3/movie/";
const baseTVShowsUrl = "https://api.themoviedb.org/3/tv/";
const topRatedTvShowsUrl = '${baseTVShowsUrl}top_rated?api_key=$API_KEY';
const popularTvShowsUrl = '${baseTVShowsUrl}popular?api_key=$API_KEY';
const BASE_IMAGE_URL = "https://image.tmdb.org/t/p/";
const nowPlayingMovieUrl = '${BASE_MOVIE_URL}now_playing?api_key=$API_KEY';
const upcomingMovieUrl = '${BASE_MOVIE_URL}upcoming?api_key=$API_KEY';
const popularMovieUrl = '${BASE_MOVIE_URL}popular?api_key=$API_KEY';
const topRatedMovieUrl = '${BASE_MOVIE_URL}top_rated?api_key=$API_KEY';
Color mainColor = Colors.amber[600];
