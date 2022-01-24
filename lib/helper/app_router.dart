
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/business_logic/cubit/movies_cubit.dart';
import 'package:movieapi/constants/strings.dart';
import 'package:movieapi/data/repository/movies_repository.dart';
import 'package:movieapi/data/web_services/movies_web_service.dart';
import 'package:movieapi/presentation/screens/movies_screen.dart';

class AppRouter{
  late MoviesRepository moviesRepository;
  late MoviesCubit moviesCubit;

  AppRouter(){
    moviesRepository = MoviesRepository(MovieWebService());
    moviesCubit = MoviesCubit(moviesRepository);
  }

  Route? generateRoute(RouteSettings settings){
    switch (settings.name){
      case MoviesPage: return MaterialPageRoute(
          builder:(_)=>BlocProvider(
              create:(BuildContext context)=>moviesCubit,
              child: MoviesScreen(),
          ));
    }
  }
}