import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapi/constants/colors.dart';
import 'package:movieapi/constants/strings.dart';
import 'package:movieapi/data/models/movie_model.dart';
class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: MediaQuery.of(context).size.width/2.2,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: ()=>Navigator.pushNamed(context,MovieDetailsPage,arguments: movie),
        child: Hero(
          tag: movie.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(
              fit: BoxFit.fitWidth,
              imageUrl: "https://image.tmdb.org/t/p/original/${movie.posterPath}",
              placeholder: (context, url) => Center(child: CircularProgressIndicator(color: MyColors.red,)),
              errorWidget: (context, url, error) => Icon(Icons.error),
              )
          ),
        ),
      )
    );
  }
}
