part of 'translation_api_bloc.dart';

abstract class TranslationApiEvent extends Equatable {
  const TranslationApiEvent();

  @override
  List<Object> get props => [];
}

class ChangeApi extends TranslationApiEvent{
  final TranslateAbstract chosenApi;
  ChangeApi({@required this.chosenApi});
}
