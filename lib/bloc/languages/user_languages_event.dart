part of 'user_languages_bloc.dart';

abstract class UserLanguagesEvent extends Equatable {
  const UserLanguagesEvent();
  @override
  List<Object> get props => [];
}


class ReplaceLanguage extends UserLanguagesEvent {
  final int index;
  final Map<String, dynamic> newLanguageMap;
  ReplaceLanguage({@required this.index, @required this.newLanguageMap});
}

class SelectInputLanguage extends UserLanguagesEvent {
  final Map<String, dynamic> newLanguageMap;
  SelectInputLanguage({@required this.newLanguageMap});
}

class ClearLanguagesOnSwitch extends UserLanguagesEvent {
  ClearLanguagesOnSwitch();
}
