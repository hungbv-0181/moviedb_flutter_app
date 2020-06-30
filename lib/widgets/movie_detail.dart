import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedbflutterapp/models/models.dart';
import 'package:moviedbflutterapp/widgets/poster_triangle_banner.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MovieDetail extends StatelessWidget {
  final GenreMovie movie;

  const MovieDetail({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie detail'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Image.network(
                        movie.backdropImage,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 2,
                      ),
                      Container(
                        child: CustomPaint(
                          size: Size(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.width / 2),
                          painter: PosterTriangleBanner(),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Material(
                          elevation: 10,
                          child: Image.network(
                            movie.posterImage,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width /
                                3 *
                                (7 / 10),
                            height: MediaQuery.of(context).size.width / 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(18, 8, 0, 8),
                          child: Text(
                            movie.title,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 8, 18, 8),
                        child: CircularPercentIndicator(
                          percent: movie.rating / 10,
                          radius: 34,
                          lineWidth: 4,
                          progressColor: Colors.black,
                          backgroundColor: Colors.grey,
                          center: Text(
                            '${movie.rating}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 4),
                              child: Image(
                                image: AssetImage('assets/reviews.png'),
                                width: 30,
                                height: 30,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: Text(
                                'Reviews',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        VerticalDivider(),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 4),
                              child: Image(
                                image: AssetImage('assets/play.png'),
                                width: 30,
                                height: 30,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: Text(
                                'Trailers',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: Text(
                                'Genre',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                              child: Text(
                                movie.toGenresString(),
                                overflow: TextOverflow.clip,
                                style: TextStyle(fontSize: 16),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: Text(
                                'Release',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: Text(
                                '${movie.releaseDate}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 2,
                    color: Colors.grey,
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Text(
                        movie.description,
                        maxLines: 10,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
