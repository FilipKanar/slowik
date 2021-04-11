import 'package:flutter/material.dart';
import 'package:slowik/UI/home/components/translate_text/translate_form/translate_form.dart';

class TranslateText extends StatefulWidget {

  @override
  _TranslateTextState createState() => _TranslateTextState();
}

class _TranslateTextState extends State<TranslateText> {

  @override
  Widget build(BuildContext context) {
    return buildTranslationForm();
  }


  buildTranslationForm() {
    return TranslateForm();
  }
}
