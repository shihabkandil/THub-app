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
        width: 440/MediaQuery.of(context).devicePixelRatio,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: ()=>Navigator.pushNamed(context,MovieDetailsPage,arguments: movie),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          // child: CachedNetworkImage(
          //   fit: (movie.posterPath != '')? BoxFit.fill : BoxFit.fitWidth,
          //   imageUrl:(movie.posterPath != '')?"https://image.tmdb.org/t/p/original/${movie.posterPath}"
          //       :"https://www.seekpng.com/png/full/5-50378_product-categories-more-coming-soon-png.png",
          //   placeholder: (context, url) => Center(child: CircularProgressIndicator(color: MyColors.red,)),
          //   errorWidget: (context, url, error) => Icon(Icons.error),
          //   )
        ),
      )
    );
  }
}
