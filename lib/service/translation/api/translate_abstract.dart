abstract class TranslateAbstract{
  String name;
  bool autoDetect;
  Future<String> translateString(String textToTranslate,String languageCodeTo, {String languageCodeFrom});
  Future<Map<String,dynamic>> supportedLanguages();
  Map<String,Map<String,String>> convertSupportedLanguagesMap(Map<String, dynamic> mapToConvert);
}