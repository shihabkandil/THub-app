import 'package:dio/dio.dart';
import 'package:movieapi/constants/strings.dart';

class MovieWebService{
  late Dio dio;
  
  MovieWebService(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20*1000,
      receiveTimeout: 20*1000
    );
    dio = Dio(options);
  }

  Future<dynamic> getAllMovies({required String query})async{
    try{
      Response response;
      if(query == DiscoverMoviesQuery)
      response = await dio.get("${query}/movie/?api_key="+API_KEY);
      else if(query == TopRatedMoviesQuery){
        response = await dio.get("discover/movie/?api_key="+API_KEY+"&with_genres=10751");
      }
      else if(query == NowplayingMoviesQuery){
        response = await dio.get("movie/now_playing?api_key="+API_KEY+"&with_genres=10751");
      }
      else if (query == PopularMoviesQuery){
        response = await dio.get("movie/now_playing?api_key="+API_KEY+"&with_genres=10751&page=2");
      }
      else
         response = await dio.get("movie/${query}?api_key="+API_KEY);

      if(response.statusCode==200){
      return response.data;
      }
      else
        return [];
    }
    catch(e){
      throw(e);
    }
  }

  Future<dynamic> getSimilarMovies({required String movieID}) async {
    try{
      Response response = await dio.get("movie/${movieID}/similar?api_key="+API_KEY);
      if(response.statusCode==200){
        return response.data;
      }
      else
        return [];
    }
    catch(e){
      throw(e);
    }
  }

  Future<dynamic> getMovieTrailers({required String movieID})async {
    try{

      Response response = await dio.get("movie/${movieID}/videos?api_key="+API_KEY);
      if(response.statusCode==200){
        print(movieID);
        return response.data;
      }
      else
        return [];
    }
    catch(e){
      throw(e);
    }
  }


}