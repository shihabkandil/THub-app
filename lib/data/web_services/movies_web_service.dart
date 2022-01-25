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
  Future<dynamic> getAllMovies()async{
    try{
      Response response = await dio.get("discover/movie?api_key="+API);
      return response.data;
    }
    catch(e){
      throw(e);
    }
  }
}