
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/business_logic/cubit/discover_movies/discover_movies_cubit.dart';
import 'package:movieapi/business_logic/cubit/movie_details/movie_details_cubit.dart';
import 'package:movieapi/business_logic/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movieapi/business_logic/cubit/popular_movies/popular_movies_cubit.dart';
import 'package:movieapi/business_logic/cubit/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movieapi/business_logic/cubit/upcoming_movies/upcoming_movies_cubit.dart';
import 'package:movieapi/constants/strings.dart';
import 'package:movieapi/data/models/movie_model.dart';
import 'package:movieapi/data/repository/movie_repository.dart';
import 'package:movieapi/data/repository/movies_categories_repository.dart';
import 'package:movieapi/data/web_services/movies_web_service.dart';
import 'package:movieapi/presentation/screens/home_screen.dart';
import 'package:movieapi/presentation/screens/movie_details_screen.dart';

class AppRouter{
  late MoviesCategoryRepository moviesRepository;

  late DiscoverMoviesCubit discoverMoviesCubit;
  late NowPlayingMoviesCubit nowPlayingMoviesCubit;
  late PopularMoviesCubit popularMoviesCubit;
  late TopRatedMoviesCubit topRatedMoviesCubit;
  late UpcomingMoviesCubit upcomingMoviesCubit;

  late MovieDetailsCubit movieDetailsCubit;
  late MovieRepository movieDetailsRepository;



  AppRouter(){
    moviesRepository = MoviesCategoryRepository(MovieWebService());
    movieDetailsRepository = MovieRepository(movieWebService: MovieWebService());

    discoverMoviesCubit = DiscoverMoviesCubit(moviesRepository);
    nowPlayingMoviesCubit = NowPlayingMoviesCubit(moviesRepository);
    popularMoviesCubit = PopularMoviesCubit(moviesRepository);
    topRatedMoviesCubit = TopRatedMoviesCubit(moviesRepository);
    upcomingMoviesCubit = UpcomingMoviesCubit(moviesRepository);
    movieDetailsCubit = MovieDetailsCubit(movieDetailsRepository);

  }

  Route? generateRoute(RouteSettings settings){
    switch (settings.name){
      case MoviesPage:
        return MaterialPageRoute(
          builder:(_)=>MultiBlocProvider(
            providers: [
              BlocProvider<DiscoverMoviesCubit>(
                create: (BuildContext context) => discoverMoviesCubit,
              ),
              BlocProvider<NowPlayingMoviesCubit>(
                create: (BuildContext context) => nowPlayingMoviesCubit,
              ),
              BlocProvider<PopularMoviesCubit>(
                create: (BuildContext context) => popularMoviesCubit,
              ),
              BlocProvider<TopRatedMoviesCubit>(
                create: (BuildContext context) => topRatedMoviesCubit,
              ),
              BlocProvider<UpcomingMoviesCubit>(
                create: (BuildContext context) => upcomingMoviesCubit,
              ),
            ],
            child: MoviesScreen(),
          ),
      );

      case MovieDetailsPage:
        final movie = settings.arguments as MovieModel;
        return  MaterialPageRoute(
          builder:(_)=>MovieDetailsScreen(movie:movie)
        );
    }
  }
}
