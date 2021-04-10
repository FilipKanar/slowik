import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slowik/UI/home/components/select_language/dialog/choose_language_dialog.dart';
import 'package:slowik/bloc/languages/user_languages_bloc.dart';

class DetectLanguageTile extends StatelessWidget {
  final Map<String,dynamic> languageMap;

  DetectLanguageTile({@required this.languageMap});

  replaceLanguage(BuildContext context) async{
    var newLanguage = await ChooseLanguageDialog().languageSelectDialog(context);
    BlocProvider.of<UserLanguagesBloc>(context)
        .add(SelectInputLanguage(newLanguageMap: newLanguage));
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(flex: 4, child: Text('This api doesn\'t support language detection. Select your input  language'),),
        Expanded(
          flex: 1,
          child: languageMap == null ? IconButton(icon: Icon(Icons.add), onPressed: () {
            replaceLanguage(context);
          }) : Container(
            child: Column(
              children: [
                Text(languageMap['name']),
                IconButton(icon: Icon(Icons.animation), onPressed: (){replaceLanguage(context);}),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
