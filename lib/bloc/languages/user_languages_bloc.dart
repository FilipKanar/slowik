import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'user_languages_event.dart';
part 'user_languages_state.dart';

class UserLanguagesBloc extends Bloc<UserLanguagesEvent, UserLanguagesState> {
  UserLanguagesBloc() : super(UserLanguagesInitial());
  List<Map<String,dynamic>> chosenLanguagesList = List<Map<String,dynamic>>(5);
  Map<String, dynamic> inputLanguageCode;



  @override
  Stream<UserLanguagesState> mapEventToState(
    UserLanguagesEvent event,
  ) async* {

    if(event is ReplaceLanguage){
      yield UserLanguagesLoading();
      chosenLanguagesList[event.index] = event.newLanguageMap;
      yield UserLanguagesLoaded(languageList: chosenLanguagesList, inputLanguageCode: inputLanguageCode);
    }

    if(event is SelectInputLanguage){
      inputLanguageCode = event.newLanguageMap;
      yield UserLanguagesLoaded(languageList: chosenLanguagesList, inputLanguageCode: inputLanguageCode);
    }

    if(event is ClearLanguagesOnSwitch){
      yield UserLanguagesLoading();
      chosenLanguagesList = List<Map<String,dynamic>>(5);
      yield UserLanguagesLoaded(languageList: chosenLanguagesList, inputLanguageCode: inputLanguageCode);
    }
  }
}
