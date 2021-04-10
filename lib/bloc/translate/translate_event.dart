part of 'translate_bloc.dart';

abstract class TranslateEvent extends Equatable {
  const TranslateEvent();

  @override
  List<Object> get props => [];
}

class GetTranslation extends TranslateEvent{
  final String text;
  final List<Map<String,dynamic>> languages;
  final String inputLanguageCode;
  GetTranslation({@required this.text, @required this.languages,@required this.inputLanguageCode,});
  @override
  List<Object> get props => [text, languages, inputLanguageCode];
}


class ReplaceTranslationApi extends TranslateEvent {
  final TranslateAbstract selectedApi;
  ReplaceTranslationApi({@required this.selectedApi});
}

