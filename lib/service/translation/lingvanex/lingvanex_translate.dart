import 'package:dio/dio.dart';
import 'package:slowik/service/translation/api/api_service.dart';
import 'package:slowik/service/translation/api/translate_abstract.dart';
import 'package:slowik/data/top_secret/api_data.dart' as ApiData;

class LingvanexTranslate extends TranslateAbstract {
  final String name = 'lingvanex';
  final bool autoDetect = ApiData.lingvanex_auto_detect;

  @override
  Future<String> translateString(String textToTranslate, String languageCodeTo,
      {String languageCodeFrom}) async {
    Response response = await makeLingvanexRequest(textToTranslate, languageCodeTo,
        languageCodeFrom: languageCodeFrom);
    if (response.statusCode == 200) {
      return response.data['result'];
    } else {
      return textToTranslate;
    }
  }

  Future<Response> makeLingvanexRequest(
      String textToTranslate, String languageCodeTo,
      {String languageCodeFrom}) async {
    Map<String, String> data = fillBody(textToTranslate, languageCodeTo,
        languageCodeFrom: languageCodeFrom);
    Map<String, String> headers = fillHeaders(data.toString().length);
    return await ApiService().makePostRequest(
        url: 'https://' +
            ApiData.lingvanex_host +
            ApiData.lingvanex_translate_post_endpoint,
        headers: headers,
        data: data);
  }

  Map<String, String> fillBody(String textToTranslate, String languageCodeTo,
      {String languageCodeFrom}) {
    Map<String, String> data =Map<String,String>();
    data.addAll(ApiData.lingvanex_translate_post_body);
    data['data'] = textToTranslate;
    languageCodeFrom == null ? data.remove('from') : data['from'] = languageCodeFrom;
    data['to'] = languageCodeTo;
    return data;
  }

  Map<String, String> fillHeaders(int length) {
    Map<String, String> headers = Map<String,String>();
    headers.addAll(ApiData.lingvanex_translate_post_headers);
    headers['Content-Length'] = length.toString();
    return headers;
  }

  @override
  Future<Map<String,dynamic>> supportedLanguages() async{
    return returnLanguagesMap();
  }

  Future<Map<String,dynamic>> returnLanguagesMap()  async{
    Response response = await ApiService().getRequestWithDio(url: 'https://' +
        ApiData.lingvanex_host +
        ApiData.lingvanex_get_languages_endpoint, headers: ApiData.lingvanex_get_languages_headers);
    if(response.statusCode ==200){
      return {'data' : response.data['result']};
    } else {
      return {'error' : 'Languages download failed'};
    }

  }

  @override
  Map<String, Map<String, String>> convertSupportedLanguagesMap(
      Map<String, dynamic> mapToConvert) {
    List<dynamic> mapList = mapToConvert['data'];
    Map<String, Map<String, String>> returnMap =
    Map<String, Map<String, String>>();
    mapList.forEach((element) {
      returnMap.addAll({element['code_alpha_1'] : {'name' : element['englishName'], 'languageCodeShort' : element['code_alpha_1'], 'languageCodeToTranslate' : element['full_code']}});
    });
    return returnMap;
  }

}
