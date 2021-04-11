import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slowik/UI/home/components/buttons/add_button.dart';
import 'package:slowik/UI/home/components/info/info_message.dart';
import 'package:slowik/UI/home/components/select_language/dialog/choose_language_dialog.dart';
import 'package:slowik/bloc/languages/user_languages_bloc.dart';

class DetectLanguageTile extends StatelessWidget {
  final Map<String, dynamic> languageMap;
  final bool autoDetect;

  DetectLanguageTile({@required this.languageMap, @required this.autoDetect});

  replaceLanguage(BuildContext context) async {
    var newLanguage =
        await ChooseLanguageDialog().languageSelectDialog(context);
    BlocProvider.of<UserLanguagesBloc>(context)
        .add(SelectInputLanguage(newLanguageMap: newLanguage));
  }

  @override
  Widget build(BuildContext context) {
    return autoDetect
        ? autoDetectSupported()
        : languageMap == null
            ? AddButton(
                text: 'Input',
                callback: () {replaceLanguage(context);})
            : Container(
                child: AddButton(text: languageMap['name'], callback: () {
                  replaceLanguage(context);
                }, icon: Icon(Icons.find_replace,color: Theme.of(context).primaryColorDark),),
              );
  }

  Widget autoDetectSupported() {
    return Center(
      child: InfoMessage(
        text: 'Twoj jezyk zostanie rozpoznany',
      ),
    );
  }
}
