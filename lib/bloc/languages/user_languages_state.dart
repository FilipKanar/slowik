part of 'user_languages_bloc.dart';

abstract class UserLanguagesState extends Equatable {
  const UserLanguagesState();
  @override
  List<Object> get props => [];
}

class UserLanguagesInitial extends UserLanguagesState {
  @override
  List<Object> get props => [List<Map<String,dynamic>>(5), null];
}

class UserLanguagesLoading extends UserLanguagesState {
}

class UserLanguagesLoaded extends UserLanguagesState {
  final List<Map<String,dynamic>> languageList;
  final Map<String, dynamic> inputLanguageCode;
  UserLanguagesLoaded({@required this.languageList, @required this.inputLanguageCode});
  @override
  List<Object> get props => [languageList, inputLanguageCode];
}

