import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/business_logic/cubit/movie_trailers/movie_trailer_cubit.dart';
import 'package:movieapi/business_logic/cubit/similar_movies/similar_movies_cubit.dart';
import 'package:movieapi/constants/colors.dart';
import 'package:movieapi/constants/strings.dart';
import 'package:movieapi/data/models/movie_model.dart';
import 'package:movieapi/data/models/movie_trailer_model.dart';
import 'package:movieapi/data/repository/movie_repository.dart';
import 'package:movieapi/data/web_services/movies_web_service.dart';
import 'package:movieapi/presentation/widgets/blinkingPlayButton.dart';
import 'package:movieapi/presentation/widgets/movie_card.dart';
import 'package:readmore/readmore.dart';

class MovieDetailsScreen extends StatefulWidget {

  final MovieModel movie;

  const MovieDetailsScreen({Key? key,required this.movie}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {

  late List<MovieModel> _similarMovies;
  late List<MovieTrailerModel> _movieTrailers;

  late SimilarMoviesCubit _similarMoviesCubit;
  late MovieTrailersCubit _movieTrailersCubit;

  late MovieRepository _movieRepository;

  @override
  void initState() {
    super.initState();
    _similarMovies = [];
    _movieTrailers = [];
    _movieRepository = MovieRepository(movieWebService: MovieWebService());
    _similarMoviesCubit = SimilarMoviesCubit(_movieRepository);
    _movieTrailersCubit = MovieTrailersCubit(_movieRepository);
    _similarMoviesCubit.getSimilarMovies(widget.movie.id.toString());
    _movieTrailersCubit.getMovieTrailers(widget.movie.id.toString());
  }

  @override
  void dispose(){
    super.dispose();
    _similarMoviesCubit.close();
    _movieTrailersCubit.close();
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
                    errorWidget: (context, url, error) => Center(child:Icon(Icons.error)),
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
                MovieTrailerBlocWidget(),
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
            onPressed: ()=>Navigator.pushNamed(context, MovieTrailersPage,arguments: _movieTrailers[0]),
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
                      fontWeight: FontWeight.w400,
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
                      fontWeight: FontWeight.w400,
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

  Widget SimilarMoviesHeader(){
    return Container(
      margin: EdgeInsets.only(top: 35,bottom: 15,left: 30),
      alignment: Alignment.centerLeft,
      child: Text("Similar Movies",
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 23,
            color: Colors.white
        ),),
    );
  }

  Widget OverviewHeader(){
    return Container(
      margin: EdgeInsets.only(top: 35,bottom: 15,left: 30),
      alignment: Alignment.centerLeft,
      child: Text("Overview",
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 23,
            color: Colors.white
        ),),
    );
  }

  Widget OverviewParagraph(){
    return Container(
      margin: EdgeInsets.only(bottom: 30,left: 20,right: 20),
      alignment: Alignment.centerLeft,
      child: ReadMoreText(
        '${widget.movie.overview}',
        trimLines: 4,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'Show more',
        trimExpandedText: 'Show less',
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: MyColors.grey
        ),
        lessStyle:  TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.redAccent
        ),
        moreStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.redAccent
        ),
      ),
    );
  }

  Widget MovieTrailerBlocWidget(){
    return BlocBuilder<MovieTrailersCubit,MovieTrailersState>(
      builder: (BuildContext context, state) {
        if(state is MovieTrailersLoaded){
          _movieTrailers = (state).trailers;
          if(_movieTrailers.isEmpty)
            return Align(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color:MyColors.red,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text("Coming Soon",style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),
                ),
              ),
            );
          else
          return PlayButton();
        }
        else {
          return BlinkingPlayButton();
        }
      },
    );
  }

  Widget SimilarMoviesBlocWidget(){
    return BlocBuilder<SimilarMoviesCubit,SimilarMoviesState>(
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
    return MultiBlocProvider(
        providers: [
          BlocProvider<SimilarMoviesCubit>(
            create: (BuildContext context) => _similarMoviesCubit,
          ),
          BlocProvider<MovieTrailersCubit>(
            create: (BuildContext context) => _movieTrailersCubit,
          ),
        ],
        child:Scaffold(
      backgroundColor: Colors.black,
        body:CustomScrollView(
          slivers: [
        ScreenBar(),
            SliverList(delegate: SliverChildListDelegate(
              [
              RatesRow(),
                OverviewHeader(),
                OverviewParagraph(),
                SimilarMoviesHeader(),
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
