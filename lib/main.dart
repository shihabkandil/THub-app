import 'package:flutter/material.dart';
import 'package:movieapi/helper/app_router.dart';

void main() {
  runApp(MoviesApp(appRouter: AppRouter(),));
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({Key? key , required this.appRouter}) : super(key: key);
  
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}

