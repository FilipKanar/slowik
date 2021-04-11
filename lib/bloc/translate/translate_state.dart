part of 'translate_bloc.dart';


abstract class TranslateState extends Equatable {
  const TranslateState();
  @override
  List<Object> get props => [];
}

class TranslateInitial extends TranslateState {
  @override
  List<Object> get props => ['Initial Input', 'Initial Output'];
}

class TranslateLoading extends TranslateState {
}

class TranslateLoaded extends TranslateState {
  TranslateLoaded({@required this.translatedString, @required this.userInputString, this.translations});
  final String userInputString;
  final String translatedString;
  final List<String> translations;
  @override
  List<Object> get props => [userInputString,translatedString, translations];
}

