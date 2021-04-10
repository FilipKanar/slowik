part of 'translation_api_bloc.dart';

abstract class TranslationApiState extends Equatable {
  const TranslationApiState();
  @override
  List<Object> get props => [];
}

class TranslationApiInitial extends TranslationApiState {
  final TranslateAbstract supportedApi = GoogleTranslate();
  @override
  List<Object> get props => [supportedApi];
}

class TranslationApiLoading extends TranslationApiState {
}

class TranslationApiLoaded extends TranslationApiState {
  final TranslateAbstract supportedApi;
  final Map<String, dynamic> supportedLanguages;
  TranslationApiLoaded({@required this.supportedApi,@required this.supportedLanguages});

  @override
  List<Object> get props => [supportedApi,supportedLanguages];
}
