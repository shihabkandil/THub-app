import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/business_logic/cubit/movie_details/movie_details_cubit.dart';
import 'package:movieapi/constants/colors.dart';
import 'package:movieapi/data/models/movie_model.dart';
import 'package:movieapi/data/repository/movie_repository.dart';
import 'package:movieapi/data/web_services/movies_web_service.dart';
import 'package:movieapi/presentation/widgets/movie_card.dart';

class MovieDetailsScreen extends StatefulWidget {

  final MovieModel movie;

  const MovieDetailsScreen({Key? key,required this.movie}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {

  late List<MovieModel> _similarMovies;
  late MovieDetailsCubit _movieDetailsCubit;
  late MovieRepository _movieRepository;

  @override
  void initState() {
    super.initState();
      _movieRepository = MovieRepository(movieWebService: MovieWebService());
      _movieDetailsCubit = MovieDetailsCubit(_movieRepository);
      _movieDetailsCubit.getSimilarMovies(widget.movie.id.toString());
  }

  @override
  void dispose(){
    super.dispose();
    _movieDetailsCubit.close();
  }

  Widget ScreenBar(){
    return SliverAppBar(
      backgroundColor: Color(0x282828),
      expandedHeight: 300,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.all(15),
            child: Text('${widget.movie.title}',
              textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 18
            ),),
          ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: "https://image.tmdb.org/t/p/original/${widget.movie.backdrop_path}",
                    placeholder: (context, url) => Center(child: CircularProgressIndicator(color: MyColors.red,)),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                Container(
                width: double.infinity,
                decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  tileMode: TileMode.clamp,
                  begin: const Alignment(0.0, 1),
                end: const Alignment(0.0,0),
                colors: <Color>[
                  const Color(0xFF000000),
                Colors.black12.withOpacity(0.0)
                ],
                ),
                )
                ),
                PlayButton()
              ],
            )
            ),
      leading: BackIconButton(),
      leadingWidth: 90,
    );
  }
  Widget PlayButton(){
      return Positioned(
          child: UnconstrainedBox (
            alignment: Alignment.center,
            child: Container(
              width: 165/MediaQuery.of(context).devicePixelRatio,
              height: 165/MediaQuery.of(context).devicePixelRatio,
            decoration: BoxDecoration(
            color: MyColors.red,
            borderRadius: BorderRadius.circular(50)
            ),
            child: IconButton(
            alignment: Alignment.center,
            icon: Icon(Icons.play_arrow,size: 40,),
            color: Colors.white,
            onPressed: ()=>Navigator.pop(context),
            ),
            ),
          ),
          );
}

  Widget BackIconButton(){
    return Container(
      margin: EdgeInsets.all(6),
      child: Ink(
        decoration: ShapeDecoration(
            color: MyColors.red,
            shape: CircleBorder()
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_rounded,),
            color: Colors.white,
            onPressed: ()=>Navigator.pop(context),
          ),
        ),
    );
  }

  Widget RatesRow(){
    return Container(
      padding: EdgeInsets.only(left: 10,right: 10,),
      margin: EdgeInsets.only(bottom: 120/MediaQuery.of(context).devicePixelRatio),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Expanded(
            child: Padding(
              padding:  EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text('${widget.movie.popularity}',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.orangeAccent,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Text('Popularity',style: TextStyle(
                    fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                  ),)
                ],
              ),
            ),
          ),
          Column(
            children: [
              Icon(Icons.star,size: 55,color: MyColors.red,),
              Text('${widget.movie.vote_average.toString()}/10',
                style: TextStyle(
                fontSize: 28,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.white
              ),),


          ],
          ),
            Expanded(
              child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text('${widget.movie.votes_count.toString()}',
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.orangeAccent,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Text('Votes',style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                  ),
                  )
                ],
              ),
          ),
            )
        ],
      ),
    );
  }

  Widget SimilarMoviesTitle(){
    return Container(
      margin: EdgeInsets.only(top: 35,bottom: 15,left: 30),
      alignment: Alignment.centerLeft,
      child: Text("Similar Movies",
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 23,
            color: Colors.white
        ),),
    );
  }

  Widget SimilarMoviesBlocWidget(){
    return BlocBuilder<MovieDetailsCubit,MovieDetailsState>(
      builder: (BuildContext context, state) {
        if(state is SimilarMoviesLoaded){
          _similarMovies = (state).similarMovies;
          return SimilarMoviesCaroussel();
        }
        else {
          return ShowLoadingIndicator();
        }
      },
    );
  }

  Widget ShowLoadingIndicator(){
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.red,
      ),
    );
  }

  Widget SimilarMoviesCaroussel() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: CarouselSlider.builder(
        itemCount: 9,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            MovieCard(movie: _similarMovies[itemIndex],),
        options: CarouselOptions(
          height: 550/MediaQuery.of(context).devicePixelRatio,
          autoPlay: true,
          autoPlayCurve: Curves.decelerate,
          viewportFraction: 0.4
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(BuildContext context)=> _movieDetailsCubit,
    child:Scaffold(
      backgroundColor: Colors.black,
        body:CustomScrollView(
          slivers: [
        ScreenBar(),
            SliverList(delegate: SliverChildListDelegate(
              [
              RatesRow(),
                SimilarMoviesTitle(),
                SimilarMoviesBlocWidget(),
              ]
            ),
            ),
      ],
    ),
    )
    );
  }
}
