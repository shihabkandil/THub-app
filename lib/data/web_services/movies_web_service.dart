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
  }
  
  Future<List<dynamic>> getAllMovies()async{
    try{
      Response response = await dio.get("movie/popular?api_key="+API);
      return response.data;
    }
    catch(e){
      print(e.toString());
      return [];
    }
  }
}