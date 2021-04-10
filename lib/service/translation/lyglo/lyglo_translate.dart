
import 'package:dio/dio.dart';
import 'package:slowik/service/translation/api/api_service.dart';
import 'package:slowik/service/translation/api/translate_abstract.dart';
import 'package:slowik/data/top_secret/api_data.dart' as ApiData;

class LygloTranslate extends TranslateAbstract {
  final String name = 'lyglo';
  final bool autoDetect = ApiData.lyglo_auto_detect;

  @override
  Future<String> translateString(String textToTranslate, String languageCodeTo,
      {String languageCodeFrom}) async {
    await Future.delayed(Duration(milliseconds: 1500));
    Response response = await makeLygloRequest(textToTranslate, languageCodeTo,
        languageCodeFrom: languageCodeFrom);
    if (response.statusCode == 200) {
      return response.data['translation'];
    } else {
      return textToTranslate;
    }
  }

  Future<Response> makeLygloRequest(
      String textToTranslate, String languageCodeTo,
      {String languageCodeFrom}) async {
    Map<String, String> data = fillBody(textToTranslate, languageCodeTo,
        languageCodeFrom: languageCodeFrom);
    Map<String, String> headers = fillHeaders(data.toString().length);
    return await ApiService().makePostRequest(
        url: 'https://' +
            ApiData.lyglo_host +
            ApiData.lyglo_translate_post_endpoint,
        headers: headers,
        data: data);
  }

  Map<String, String> fillBody(String textToTranslate, String languageCodeTo,
      {String languageCodeFrom}) {
    Map<String, String> data =Map<String,String>();
    data.addAll(ApiData.lyglo_translate_post_body);
    data['text'] = textToTranslate;
    data['sourceLanguage'] = languageCodeFrom;
    data['targetLanguage'] = languageCodeTo;
    return data;
  }

  Map<String, String> fillHeaders(int length) {
    Map<String, String> headers = Map<String,String>();
    headers.addAll(ApiData.lyglo_translate_post_headers);
    headers['Content-Length'] = length.toString();
    return headers;
  }


  @override
  Future<Map<String,dynamic>> supportedLanguages() async{
    return returnLanguagesMap();
  }


  Future<Map<String,dynamic>> returnLanguagesMap()  async{
    Response response = await ApiService().getRequestWithDio(url: 'https://' +
        ApiData.lyglo_host +
        ApiData.lyglo_get_languages_endpoint, headers: ApiData.lyglo_get_languages_headers);
    if(response.statusCode == 200){
      return {'data' : response.data};
    } else {
      return {'error' : 'Language download failed.'};
    }
  }

  @override
  Map<String, Map<String, String>> convertSupportedLanguagesMap(
      Map<String, dynamic> mapToConvert) {
    List<dynamic> mapList = mapToConvert['data'];
    Map<String, Map<String, String>> returnMap =
    Map<String, Map<String, String>>();
    mapList.forEach((element) {
      returnMap.addAll({element['code'] : {'name' : element['name'], 'languageCodeShort' : element['code'], 'languageCodeToTranslate' : element['code']}});
    });
    return returnMap;
  }
}
