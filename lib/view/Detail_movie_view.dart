import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/helper/movie_api.dart';
import 'package:movie_app/models/movie_cast_and_crew_model.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/trailer_model.dart';
import 'package:movie_app/view/trailer_view.dart';

import '../constants.dart';

class DetailMovieView extends StatefulWidget {
  final Results movieResult;
  DetailMovieView({
    this.movieResult,
  });

  @override
  _DetailMovieViewState createState() => _DetailMovieViewState();
}

class _DetailMovieViewState extends State<DetailMovieView> {
  @override
  MovieDetailModel movieDetailModel;
  MovieCastAndCrewModel castAndCrewModel;
  int runtime;
  List<VideoModel> _trailersList = [];
  bool _isVisible = false;

  Future<void> getMovieDetail(String detailUrl) async {
    MovieApi movieApi = MovieApi();

    movieDetailModel = await movieApi.getDetailsMovie(detailUrl);
    setState(() {
      runtime = movieDetailModel.runtime;
    });
  }

  Future<void> getCastAndCrew(String castUrl) async {
    MovieApi movieApi = MovieApi();

    castAndCrewModel = await movieApi.getCastAndCrewMovie(castUrl);
    setState(() {});
  }

  Future<void> getTrailers(int movieId) async {
    MovieApi movieApi = MovieApi();

    _trailersList = await movieApi.getMovieTrailers(movieId);
    setState(() {
      _trailersList;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    String detailMovieURL =
        '$BASE_MOVIE_URL${widget.movieResult.id}?api_key=$API_KEY';

    String castAndCrewUrl =
        '$BASE_MOVIE_URL${widget.movieResult.id}/credits?api_key=$API_KEY';

    getMovieDetail(detailMovieURL);

    setState(() {
      getCastAndCrew(castAndCrewUrl);
    });
    getTrailers(widget.movieResult.id);

    Future.delayed(const Duration(seconds: 1), () {
      //asynchronous delay
      if (this.mounted) {
        //checks if widget is still active and not disposed
        setState(() {
          //tells the widget builder to rebuild again because ui has updated
          _isVisible =
              true; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final moviePoster = Container(
      height: 350,
      padding: EdgeInsets.only(top: 20, bottom: 10),
      child: Center(
        child: Stack(
          children: [
            Hero(
              tag: widget.movieResult.heroTag,
              child: Image.network(
                '${BASE_IMAGE_URL}w342${widget.movieResult.posterPath}',
                width: 230,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 130,
              left: 80,
              child: Visibility(
                visible: _isVisible,
                child: IconButton(
                    icon: Icon(
                      Icons.play_circle_outline,
                      size: 60,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrailerView(
                            movieKey: _trailersList[0].key,
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
    final movieTitle = Center(
      child: Container(
        width: 220,
        child: Text(
          widget.movieResult.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
    Widget movieDetails = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Text(
            '${movieDetailModel == null ? '' : _getMovieDuration(runtime: runtime)}', // movieDetailModel == null
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Container(
          height: 20,
          width: 1,
          color: Colors.white70,
        ),
        Text(
          'Release Date: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.movieResult.releaseDate))}',
          style: TextStyle(fontSize: 14),
        ),
        Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 23,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              '8.4',
              //widget.movieResult.voteAverage.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey[200]),
            )
          ],
        )
      ],
    );
    final genresList = Container(
      height: 42,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: movieDetailModel == null
            ? []
            : movieDetailModel.genres
                .map(
                  (g) => Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 10),
                    child: FilterChip(
                      onSelected: (_) {},
                      label: Text(g.name),
                      backgroundColor: Colors.grey[700],
                    ),
                  ),
                )
                .toList(),
      ),
    );
    final middleContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'synopsis',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.grey[300],
          ),
        ),
        Divider(
          height: 20,
        ),
        Text(
          widget.movieResult.overview,
          style: TextStyle(
            color: Colors.grey[300],
          ),
        )
      ],
    );
    final castContent = Container(
      padding: EdgeInsets.only(top: 15, bottom: 10),
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ('Actors'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: castAndCrewModel == null
                  ? []
                  : castAndCrewModel.cast
                      .map((actor) => Container(
                            margin: EdgeInsets.only(left: 3),
                            width: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                actor.profilePath == null
                                    ? CircleAvatar(
                                        radius: 35.0,
                                        //backgroundColor: Colors.grey,
                                        // child: Icon(
                                        //   Icons.person_rounded,
                                        //   color: Colors.white70,
                                        //   size: 40,
                                        // ),
                                        backgroundImage: AssetImage(
                                          'assets/images/profile3.jpg',
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 35.0,
                                        backgroundImage: NetworkImage(
                                          '${BASE_IMAGE_URL}w154${actor.profilePath}',
                                        ),
                                      ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  actor.name,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  actor.character,
                                  style: TextStyle(fontSize: 9),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ))
                      .toList(),
            ),
          )
        ],
      ),
    );
    final crewContent = Container(
      padding: EdgeInsets.only(top: 5, bottom: 10),
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ('Crew'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: castAndCrewModel == null
                  ? []
                  : castAndCrewModel.crew
                      .map((actor) => Container(
                            margin: EdgeInsets.only(left: 3),
                            width: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                actor.profilePath == null
                                    ? CircleAvatar(
                                        radius: 35.0,
                                        // backgroundColor: Colors.grey,
                                        // child: Icon(
                                        //   Icons.person_rounded,
                                        //   color: Colors.white70,
                                        //   size: 40,
                                        // ),
                                        backgroundImage: AssetImage(
                                          'assets/images/profile3.jpg',
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 35.0,
                                        backgroundImage: NetworkImage(
                                          '${BASE_IMAGE_URL}w154${actor.profilePath}',
                                        ),
                                      ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  actor.name,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  actor.job,
                                  style: TextStyle(fontSize: 9),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ))
                      .toList(),
            ),
          )
        ],
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            child: ListView(
              children: [
                moviePoster,
                movieTitle,
                SizedBox(
                  height: 20,
                ),
                movieDetails,
                Divider(),
                genresList,
                middleContent,
                castContent,
                crewContent,
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getMovieDuration({int runtime}) {
    if (runtime == null) return 'No Data';
    double movieHours;
    int movieMinutes;
    setState(() {
      movieHours = runtime / 60;
      movieMinutes = ((movieHours - movieHours.floor()) * 60).round();
    });

    return '${movieHours.floor()} h $movieMinutes min';
  }
}
