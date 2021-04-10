import 'package:flutter/material.dart';
import 'package:slowik/UI/home/components/select_language/language_list/language_list.dart';

class ChooseLanguageDialog {
  Future languageSelectDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(content: _languagesList(context));
      },
    );
  }

  Widget _languagesList(BuildContext context) {
    return Container(width: double.maxFinite, child: LanguageList());
  }
}
