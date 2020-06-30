import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedbflutterapp/models/models.dart';
import 'package:moviedbflutterapp/widgets/movie_detail.dart';

class MovieCell extends StatelessWidget {
  final GenreMovie movie;

  const MovieCell({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => MovieDetail(movie: movie),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: Image.network(
                movie.posterImage,
                fit: BoxFit.fill,
                width: 70,
                height: 100,
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${movie.title}',
                    //"test title",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Divider(
                    height: 6,
                    color: Colors.white,
                  ),
                  Text(
                    '${movie.description}',
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
