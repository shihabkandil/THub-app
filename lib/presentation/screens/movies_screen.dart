import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/business_logic/cubit/discover_movies/discover_movies_cubit.dart';
import 'package:movieapi/business_logic/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movieapi/business_logic/cubit/popular_movies/popular_movies_cubit.dart';
import 'package:movieapi/business_logic/cubit/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movieapi/business_logic/cubit/upcoming_movies/upcoming_movies_cubit.dart';
import 'package:movieapi/constants/colors.dart';
import 'package:movieapi/data/models/movie.dart';
import 'package:movieapi/presentation/widgets/movie_card.dart';


class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> with TickerProviderStateMixin{

  late List<Movie> popularMovies;
  late List<Movie> discoverMovies;
  late List<Movie> topRatedMovies;
  late List<Movie> upcomingMovies;
  late List<Movie> nowPlayingMovies;


  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4,vsync: this);
    BlocProvider.of<DiscoverMoviesCubit>(context).getAllDiscoverMovies();
    BlocProvider.of<TopRatedMoviesCubit>(context).getAllTopRatedMovies();
    BlocProvider.of<NowPlayingMoviesCubit>(context).getAllNowPlayingMovies();
    BlocProvider.of<UpcomingMoviesCubit>(context).getAllUpcomingMovies();
    BlocProvider.of<PopularMoviesCubit>(context).getAllPopularMovies();
  }

  Widget AppTitle() {
    return Container(
      margin:EdgeInsets.only(top: 45,left: 35,bottom: 20),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      child: Column(
      children: [
        Text("Trailers Hub",style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
        fontSize: 30,
        color: Colors.white
      ),
  ),
        Text("Check latest movies.",style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.grey,
      ),
  ),
        ],
      ),
      );
  }

  Widget MoviesBar({required TabController controller}){
    return Container(
      padding: EdgeInsets.only(left: 10,right: 10),
      height: 80,
      child: ButtonsTabBar(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColors.red
        ),
        unselectedDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: MyColors.grey,
        ),
        labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500
        ),
        unselectedLabelStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500
        ),
        buttonMargin: EdgeInsets.only(top: 18,bottom:17,left: 20),
        contentPadding: EdgeInsets.all(13),
        controller:controller,
        tabs: const <Widget>[
          Tab(text: "Discover",),
          Tab(text: "Popular",),
          Tab(text: "Top-rated",),
          Tab(text: "Upcoming",),
        ],
      ),
    );
  }

  Widget MoviesTabView() {
    return Container(
      height: MediaQuery.of(context).size.height/3.5,
      child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            DiscoverMoviesBlocWidget(),
            PopularMoviesBlocWidget(),
            TopRatedMoviesBlocWidget(),
            UpcomingMoviesBlocWidget()
          ]
      ),
    );
  }

  Widget PopularMoviesBlocWidget(){
    return BlocBuilder<PopularMoviesCubit,PopularMoviesState>(
        builder: (context,state){
          if(state is PopularMoviesLoaded && (state).popularMovies.length>=5){
            popularMovies = (state).popularMovies;
            return PopularMoviesTab();
          }
          else{
            return showLoadingIndicator();
          }
        }
    );
  }

  Widget NowPlayingMoviesBlocWidget(){
    return BlocBuilder<NowPlayingMoviesCubit,NowPlayingMoviesState>(
        builder: (context,state){
          if(state is NowPlayingMoviesLoaded && (state).nowPlayingMovies.length>=5){
            nowPlayingMovies = (state).nowPlayingMovies;
            return NowplayingCaroussel();
          }
          else{
            return showLoadingIndicator();
          }
        }
    );
  }

  Widget TopRatedMoviesBlocWidget(){
    return BlocBuilder<TopRatedMoviesCubit,TopRatedMoviesState>(
        builder: (context,state){
          if(state is TopRatedMoviesLoaded && (state).topRatedMovies.length>=5){
            topRatedMovies = (state).topRatedMovies;
            return TopRatingMoviesTab();
          }
          else{
            return showLoadingIndicator();
          }
        }
    );
  }

  Widget DiscoverMoviesBlocWidget(){
    return BlocBuilder<DiscoverMoviesCubit,DiscoverMoviesState>(
        builder: (context,state){
          if(state is DiscoverMoviesLoaded && (state).discoverMovies.length>=5){
            discoverMovies = (state).discoverMovies;
            return DiscoverMoviesTab();
          }
          else{
            return showLoadingIndicator();
          }
        }
    );
  }

  Widget UpcomingMoviesBlocWidget(){
    return BlocBuilder<UpcomingMoviesCubit,UpcomingMoviesState>(
        builder: (context,state){
          if(state is UpcomingMoviesLoaded && (state).upcomingMovies.length>=5){
            upcomingMovies = (state).upcomingMovies;
            return UpcomingMoviesTab();
          }
          else{
            return showLoadingIndicator();
          }
        }
    );
  }


  Widget showLoadingIndicator(){
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.red,
      ),
    );
  }

  Widget PopularMoviesTab(){
      return Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context,index){
              return MovieCard(movie: popularMovies[index],);
            }
        ),
      );
  }

  Widget DiscoverMoviesTab(){
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 8,
          itemBuilder: (context,index){
            return MovieCard(movie: discoverMovies[index],);
          }
      ),
    );
  }

  Widget TopRatingMoviesTab(){
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 8,
          itemBuilder: (context,index){
            return MovieCard(movie: topRatedMovies[index],);
          }
      ),
    );
  }

  Widget UpcomingMoviesTab(){
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 8,
          itemBuilder: (context,index){
            return MovieCard(movie: upcomingMovies[index],);
          }
      ),
    );
  }

  Widget NowplayingTitle(){
    return Container(
      margin: EdgeInsets.only(top: 35,bottom: 15,left: 35),
      alignment: Alignment.centerLeft,
      child: Text("Now Playing",
      style: TextStyle(
        fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 24,
          color: Colors.white
      ),),
    );
  }

  Widget NowplayingCaroussel() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: CarouselSlider.builder(
        itemCount: 9,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
             MovieCard(movie: nowPlayingMovies[itemIndex],),
        options: CarouselOptions(height: 370,
        autoPlay: true,
        autoPlayCurve: Curves.decelerate,
        disableCenter: true,
        enlargeCenterPage: true,
        viewportFraction: 0.7,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.darkBlue,
        body:SingleChildScrollView(
        child: Column(
          children: [
            AppTitle(),
            MoviesBar(controller:_tabController),
            MoviesTabView(),
            NowplayingTitle(),
            NowPlayingMoviesBlocWidget(),
          ],
        )
        ),
    );
  }
}
