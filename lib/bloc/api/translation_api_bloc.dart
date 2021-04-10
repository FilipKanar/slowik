import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:slowik/service/translation/api/translate_abstract.dart';
import 'package:slowik/service/translation/google/google_translate.dart';

part 'translation_api_event.dart';
part 'translation_api_state.dart';

class TranslationApiBloc extends Bloc<TranslationApiEvent, TranslationApiState> {
  TranslationApiBloc() : super(TranslationApiInitial());
  Map<String, Map<String,dynamic>> apiSupportedLanguages= {'google' : null,'lingvanex' : null, 'lyglo' : null};
  
  @override
  Stream<TranslationApiState> mapEventToState(
    TranslationApiEvent event,
  ) async* {
    if(event is ChangeApi){
      yield TranslationApiLoading();

      if(apiSupportedLanguages[event.chosenApi.name] == null){
        apiSupportedLanguages[event.chosenApi.name] = await event.chosenApi.supportedLanguages();
      }

      yield TranslationApiLoaded(supportedApi: event.chosenApi,supportedLanguages: event.chosenApi.convertSupportedLanguagesMap(apiSupportedLanguages[event.chosenApi.name]));
    }
  }


}
