import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapi/data/models/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return  GridTile(
        child: Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.redAccent,
          ),
          margin: EdgeInsets.all(8),
          child: movie.posterPath.isNotEmpty?ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
                placeholder: "assets/images/loading.gif",fit:BoxFit.fitHeight , image: "https://image.tmdb.org/t/p/original/${movie.posterPath}"),
          ):Image.asset("assets/images/no-image.png"),
        ),
        footer: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black54,
          ),

          alignment: Alignment.bottomCenter,
          child: Text('${movie.title}',
          style: TextStyle(
            height: 1.3,
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      );
  }
}
