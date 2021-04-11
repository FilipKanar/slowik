import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:slowik/service/translation/api/api_service.dart';
import 'package:slowik/service/translation/api/translate_abstract.dart';
import 'package:slowik/data/top_secret/api_data.dart' as ApiData;

class GoogleTranslate extends TranslateAbstract {
  final String name = 'google';
  final bool autoDetect = ApiData.google_auto_detect;

  @override
  Future<String> translateString(String textToTranslate, String languageCodeTo,
      {String languageCodeFrom}) async {
    Response response = await makeGoogleRequest(textToTranslate, languageCodeTo,
        languageCodeFrom: languageCodeFrom);
    print('responseBodyGoogle: ${response.data.toString()}');
    if (response.statusCode == 200) {
      return response.data['data']['translation'];
    } else {
      return textToTranslate;
    }
  }

  Future<Response> makeGoogleRequest(
      String textToTranslate, String languageCodeTo,
      {String languageCodeFrom}) async {
    Map<String, String> data = fillBody(textToTranslate, languageCodeTo,
        languageCodeFrom: languageCodeFrom);
    Map<String, String> headers = fillHeaders(json.encode(data.toString()).length);
    return await ApiService().makePostRequest(
        url: 'https://' +
            ApiData.google_host +
            ApiData.google_translate_post_endpoint,
        headers: headers,
        data: data);
  }

  Map<String, String> fillBody(String textToTranslate, String languageCodeTo,
      {String languageCodeFrom}) {
    Map<String, String> data =Map<String,String>();
    data.addAll(ApiData.google_translate_post_body);
    data['text'] = textToTranslate;
    languageCodeFrom == null ? data.remove('sl') : data['sl'] = languageCodeFrom;
    data['tl'] = languageCodeTo;
    return data;
  }

  Map<String, String> fillHeaders(int length) {
    Map<String, String> headers = Map<String,String>();
    headers.addAll(ApiData.google_translate_post_headers);
    headers['Content-Length'] = length.toString();
    return headers;
  }

  @override
  Future<Map<String, dynamic>> supportedLanguages() async {
    return returnLanguagesMap();
  }

  Future<Map<String, dynamic>> returnLanguagesMap() async {
    Response response = await ApiService().getRequestWithDio(
        url: 'https://' +
            ApiData.google_host +
            ApiData.google_get_languages_endpoint,
        headers: ApiData.google_get_languages_headers);
    if (response.statusCode == 200) {
      return response.data['data'];
    } else {
      return {'error': 'Languages download failed'};
    }
  }

  @override
  Map<String, Map<String, String>> convertSupportedLanguagesMap(
      Map<String, dynamic> mapToConvert) {
    Map<String, dynamic> map = mapToConvert;
    Map<String, Map<String, String>> returnMap =
        Map<String, Map<String, String>>();
    map.forEach((key, value) {
      returnMap.addAll({key : {'name' : value, 'languageCodeShort' : key, 'languageCodeToTranslate' : key}});
    });
    return returnMap;
  }

}
