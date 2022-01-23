
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapi/constants/strings.dart';
import 'package:movieapi/presentation/screens/movies_screen.dart';

class AppRouter{
  Route? generateRoute(RouteSettings settings){
    switch (settings.name){
      case MoviesPage: return MaterialPageRoute(builder:(_)=>MoviesScreen());
    }
  }
}