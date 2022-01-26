import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapi/constants/colors.dart';
import 'package:movieapi/data/models/movie_model.dart';

class MovieDetailsScreen extends StatefulWidget {

  final MovieModel movie;

  const MovieDetailsScreen({Key? key,required this.movie}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {

  Widget ScreenBar(){
    return SliverAppBar(
      backgroundColor: Color(0x282828),
      expandedHeight: 300,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text('${widget.movie.title}',textAlign: TextAlign.center,),
            background: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: "https://image.tmdb.org/t/p/original/${widget.movie.backdrop_path}",
                placeholder: (context, url) => Center(child: CircularProgressIndicator(color: MyColors.red,)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        ScreenBar(),
      ],
    );
  }
}
