import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movieapi/constants/strings.dart';
import 'package:movieapi/data/models/movie.dart';

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
      response = await dio.get("${query}/movie/?api_key="+API+"&page=2");
      else
         response = await dio.get("movie/${query}?api_key="+API);

      return response.data;
    }
    catch(e){
      throw(e);
    }
  }
}