import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/business_logic/cubit/movies_cubit.dart';
import 'package:movieapi/data/models/movie.dart';
import 'package:movieapi/data/models/movies_results.dart';
import 'package:movieapi/presentation/widgets/movie_card.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {

  late List<Movie> allMovies;

  @override
  void initState() {
    super.initState();
  allMovies = BlocProvider.of<MoviesCubit>(context).getAllMovies();
  }
  
  Widget buildBlocWidget(){
    return BlocBuilder<MoviesCubit,MoviesState>(
        builder: (context,state){
      if(state is MoviesLoaded){
        allMovies = (state).Movies;
        return buildLoadedListWidgets();
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
        color: Colors.white,
      ),
    );
}

Widget buildLoadedListWidgets(){
    return SingleChildScrollView(
      child:Container(
        color: Colors.black,
        child: Column(
          children: [
            buildMoviesList(),
          ],
        ),
      )
    );
}

Widget buildMoviesList(){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2/3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,

        ),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: allMovies.length,
        itemBuilder: (context,index){
          //TODO : Not done
          return MovieCard(movie: allMovies[index],);
        });
}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildBlocWidget(),
    );
  }
}
