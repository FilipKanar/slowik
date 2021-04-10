import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slowik/UI/home/components/translate_text/translate_form/translate_form.dart';
import 'package:slowik/UI/home/loading/loading_with_text.dart';
import 'package:slowik/bloc/translate/translate_bloc.dart';

class TranslateText extends StatefulWidget {

  @override
  _TranslateTextState createState() => _TranslateTextState();
}

class _TranslateTextState extends State<TranslateText> {
  String userInput;
  String translatedString;

  @override
  Widget build(BuildContext context) {
    return translateBlocBuilder();
  }

  translateBlocBuilder() {
    return BlocBuilder<TranslateBloc, TranslateState>(
        builder: (context, state) {
      if (state is TranslateInitial) {
        userInput = state.props[0];
        translatedString = state.props[1];
        return buildTranslationForm();
      } else if (state is TranslateLoading) {
        return LoadingWithText(text: 'Loading translations');
      } else if (state is TranslateLoaded) {
        userInput = state.props[0];
        translatedString = state.props[1];
        return buildTranslationForm();
      } else {
        return Center(
          child: Text('sth wrong'),
        );
      }
    });
  }

  buildTranslationForm() {
    return TranslateForm(translatedString: translatedString,userInput: userInput,);
  }
}
