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
      response = await dio.get("${query}/movie/?api_key="+API_KEY+"&page=2");
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