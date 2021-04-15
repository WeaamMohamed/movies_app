import 'package:flutter/material.dart';
import 'package:movie_app/helper/movie_api.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/view/Detail_movie_view.dart';

import '../constants.dart';

class SearchResultView extends StatefulWidget {
  @override
  _SearchResultViewState createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<SearchResultView> {
  MovieModel movieSearchModel;
  int heroTag = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 80,

        title: TextField(
          onSubmitted: (String movieName) async {
            setState(() {
              loading = true;
            });

            await getMovieSearch(movieName);
          },
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(width: 1.2, color: Colors.grey[200]),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
            hintText: 'Search for movie..',
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white70,
            ),
          ),
        ),
        // onSubmitted: (_) {},
      ),
      body: movieSearchModel == null
          ? Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.32),
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                      ),
                    )
                  : null,
            )
          : ListView.builder(
              itemCount: movieSearchModel.results.length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.black.withOpacity(0.32),
                  height: 200,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: _buildMovieImageItem(
                              movieSearchModel.results[index]),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                movieSearchModel.results[index].title,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                movieSearchModel.results[index].overview,
                                maxLines: 5,
                                style: TextStyle(
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  getMovieSearch(String movieName) async {
    movieSearchModel = await MovieApi().searchMovieByTitle(movieName);
    setState(() {
      loading = false;
    });
  }

  Widget _buildMovieImageItem(Results movieItem) {
    heroTag += 1;
    movieItem.heroTag = heroTag;
    return Material(
        elevation: 15.0,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(seconds: 1),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        DetailMovieView(
                          movieResult: movieItem,
                          // heroTag: heroTag,
                        )));
          },
          child: Hero(
            tag: heroTag,
            child: Container(
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading2.gif',
                placeholderCacheHeight: 220,
                image: '${BASE_IMAGE_URL}w342${movieItem.posterPath}',
                fit: BoxFit.cover,
                height: 220,
                width: 150,
              ),
            ),
          ),
        ));
  }
}
