import 'package:flutter/material.dart';
import 'package:movie_app/helper/tv_shows_api.dart';
import 'package:movie_app/models/tv_shows_model.dart';

import '../constants.dart';

class TvShowsView extends StatefulWidget {
  @override
  _TvShowsViewState createState() => _TvShowsViewState();
}

class _TvShowsViewState extends State<TvShowsView> {
  List<TvShowsResults> popularList = [];
  List<TvShowsResults> topRatedList = [];

  Future<void> getTvShows() async {
    TvShowsApi movieApi = TvShowsApi();
    popularList = await movieApi.getPopularTvShows();
    topRatedList = await movieApi.getTopRatedTvShows();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Top Rated Text
              Container(
                margin: EdgeInsets.only(left: 8, top: 20),
                child: Text(
                  'Top Rated',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Top Rated ListView
              _buildTopRatedTvShowsCard(),
              //Popular Text
              Container(
                margin: EdgeInsets.only(left: 8, bottom: 10),
                child: Text(
                  'Popular',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //Popular ListView
              _buildPopularTvShowsCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularTvShowsCard() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      height: MediaQuery.of(context).size.height - 220,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: popularList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.32),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/loading2.gif',
                        placeholderCacheHeight: 220,
                        image:
                            '${BASE_IMAGE_URL}w342${popularList[index].posterPath}',
                        fit: BoxFit.cover,
                        height: 230,
                        width: 150,
                      ),
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
                            popularList[index].name,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            popularList[index].overview,
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

  Widget _buildTopRatedTvShowsCard() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: topRatedList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(0.32),
              ),
              height: 160,
              width: 140,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/loading2.gif',
                        placeholderCacheHeight: 140,
                        image:
                            '${BASE_IMAGE_URL}w342${topRatedList[index].posterPath}',
                        fit: BoxFit.cover,
                        height: 135,
                        width: 120,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      topRatedList[index].name,
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
