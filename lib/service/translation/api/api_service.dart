import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {


  Future<dynamic> getRequestWithDio({@required String url, @required Map<String,String> headers}) async {
    Response response;
    Dio dio = new Dio();
    dio.options.headers=headers;
    response = await dio.get(url,options: Options(contentType: Headers.formUrlEncodedContentType));
    return response;
  }

  makePostRequest(
      {@required String url,
      @required Map<String, String> headers,
      @required Map<String, String> data}) async {
    print('URL: $url}');
    print('headers: ${headers.toString()}');
    print('body: ${data.toString()}');
    Dio dio = new Dio();
    dio.options.baseUrl = url; //"https://nlp-translation.p.rapidapi.com/v1/translate";
    dio.options.headers = headers;
    /*{
      "X-RapidAPI-Key": 'c1a9e6e9dcmshe40d4a6ff8eaf31p1f5e40jsn56a7cbc8af53',
      "x-rapidapi-host": "nlp-translation.p.rapidapi.com"
    };*/
    var response = await dio.post(url,
        data: data, //{"text": "Hello, world!", "from": "en", "to": "es"},
        options: Options(contentType: Headers.formUrlEncodedContentType));
    print('Response: ${response.data.toString()}');
    return response;
  }
}
