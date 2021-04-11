import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:slowik/service/translation/api/translate_abstract.dart';

part 'translate_event.dart';

part 'translate_state.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  TranslateBloc() : super(TranslateInitial());
  String userInputString;
  String output;
  List<String> middleTranslations = [];
  TranslateAbstract currentApi;

  @override
  Stream<TranslateState> mapEventToState(
    TranslateEvent event,
  ) async* {
    if (event is ReplaceTranslationApi) {
      yield TranslateLoading();
      currentApi = event.selectedApi;
      output = null;
      yield TranslateLoaded(
          userInputString: userInputString, translatedString: "Output");
    }

    if (event is GetTranslation) {
      yield TranslateLoading();
      List<Map<String,dynamic>> languages = [];
      languages.addAll(event.languages);
      languages.removeWhere((element) => element == null);
      await getTranslations(event.props[0], event.props[2], languages);
      yield TranslateLoaded(
          userInputString: event.props[0], translatedString: output, translations: middleTranslations);
    }
  }

  getTranslations(String inputString, String inputLanguageCode,
      List<Map<String,dynamic>> languages) async {
    middleTranslations.clear();
    print('getTranslation with API ${currentApi.toString()}');
    print('Text: $inputString');
    print('languages: $languages');
    for (int i = 0; i < languages.length; i++) {
      print('middleTranslations: ${middleTranslations.toString()}');
      i == 0
          ? currentApi.autoDetect
              ? middleTranslations.add(
                  await currentApi.translateString(inputString, languages[i]['languageCodeToTranslate']))
              : middleTranslations.add(await currentApi.translateString(
                  inputString, languages[i]['languageCodeToTranslate'],
                  languageCodeFrom: inputLanguageCode))
          : middleTranslations.add(await currentApi.translateString(
              middleTranslations[i - 1], languages[i]['languageCodeToTranslate'],
              languageCodeFrom: languages[i - 1]['languageCodeToTranslate']));
    }
    print('Middle : ${middleTranslations.toString()}');
    output = middleTranslations[middleTranslations.length - 1];
  }
}
