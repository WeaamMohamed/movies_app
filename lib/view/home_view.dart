import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/helper/movie_api.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/view/Detail_movie_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Results> nowPlayingList = [];
  List<Results> upcomingList = [];
  List<Results> popularList = [];
  List<Results> topRatedList = [];

  int heroTag = 0;
  int heroTag2 = 999;
  MovieModel movieSearchModel;
  Color cardColor = Colors.black.withOpacity(0.3);

  Future<void> getMovies() async {
    MovieApi movieApi = MovieApi();
    nowPlayingList = await movieApi.getNowPlayingMovies();
    popularList = await movieApi.getPopularMovies();
    topRatedList = await movieApi.getTopRatedMovies();
    upcomingList = await movieApi.getUpComingMovies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Movie'),
          Text('App', style: TextStyle(color: mainColor))
        ]),
      ),
      body: NestedScrollView(
        body: ListView(
          children: [
            _buildMovieListView(topRatedList, 'Top Rated'),
            _buildMovieListView(popularList, 'Popular'),
            _buildMovieListView(upcomingList, 'Coming Soon'),
          ],
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Now Playing',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              expandedHeight: 320,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      child: Image.network(
                        '${BASE_IMAGE_URL}w500/2W4ZvACURDyhiNnSIaFPHfNbny3.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        colorBlendMode: BlendMode.dstATop,
                        color: Colors.black54.withOpacity(0.2),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 35),
                      child: nowPlayingList.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(mainColor),
                              ),
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: _buildCarouselSlider(),
                                ),
                              ],
                            ),
                    )
                  ],
                ),
              ),
            ),
          ];
        },
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider(
      items: nowPlayingList
          .map(
            (movieItem) => InkWell(
              onTap: () {
                setState(() {
                  movieItem.heroTag = heroTag2 + 1;
                });

                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 1),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        DetailMovieView(
                      movieResult: movieItem,
                      // heroTag: heroTag,
                    ),
                  ),
                );
              },
              child: Hero(
                  tag: heroTag2++,
                  child: Image.network(
                      '${BASE_IMAGE_URL}w342${movieItem.posterPath}')),
            ),
          )
          .toList(),
      options: CarouselOptions(
        autoPlay: false,
        height: 280,
        viewportFraction: 0.45,
        enlargeCenterPage: true,
        //aspectRatio: 5.0,
      ),

      //    options: options
    );
  }

  Widget _buildMovieListView(List<Results> movieList, String movieListTitle) {
    return Container(
      height: 263,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(15),
        color: Colors.black.withOpacity(0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movieListTitle,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Flexible(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: movieList
                  .map((movieItem) => Padding(
                        padding: const EdgeInsets.only(left: 6, right: 2),
                        child: Container(child: _buildMovieListItem(movieItem)),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMovieListItem(Results movieItem) {
    return Container(
      height: 133,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black54.withOpacity(0.5),
      ),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
            child: _buildMovieImageItem(movieItem),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6, top: 2),
            child: Container(
              width: 100,
              child: Text(
                movieItem.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6, top: 2, bottom: 3),
            child: Text(
              DateFormat('yyyy').format(DateTime.parse(movieItem.releaseDate)),
              style: TextStyle(fontSize: 10.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieImageItem(Results movieItem) {
    return Material(
        elevation: 15.0,
        child: InkWell(
          onTap: () {
            setState(() {
              // heroTag++;
              movieItem.heroTag = heroTag + 1;
            });

            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(seconds: 2),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        DetailMovieView(
                          movieResult: movieItem,
                          // heroTag: heroTag,
                        )));
          },
          child: Hero(
            tag: heroTag++,
            child: Container(
              width: 120,
              color: Colors.black.withOpacity(0.8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  key: ValueKey('${BASE_IMAGE_URL}w342${movieItem.posterPath}'),
                  placeholder: 'assets/images/loading2.gif',
                  placeholderCacheHeight: 160,
                  image: '${BASE_IMAGE_URL}w342${movieItem.posterPath}',
                  fit: BoxFit.cover,
                  height: 160,
                ),
              ),
            ),
          ),
        ));
  }

  getMovieSearch(String movieName) async {
    movieSearchModel = await MovieApi().searchMovieByTitle(movieName);
    setState(() {});
  }
}
