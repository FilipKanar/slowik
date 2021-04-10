import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slowik/UI/home/components/select_language/dialog/choose_language_dialog.dart';
import 'package:slowik/bloc/languages/user_languages_bloc.dart';

class CountryTile extends StatelessWidget {

  final Map<String,dynamic> languageMap;
  final int tileIndex;

  CountryTile({@required this.tileIndex, @required this.languageMap});

  replaceLanguage(BuildContext context) async{
    var newLanguage = await ChooseLanguageDialog().languageSelectDialog(context);
    BlocProvider.of<UserLanguagesBloc>(context)
        .add(ReplaceLanguage(index: tileIndex, newLanguageMap: newLanguage));
  }


  @override
  Widget build(BuildContext context) {
    return languageMap == null ? IconButton(icon: Icon(Icons.add), onPressed: () {
      replaceLanguage(context);
    }) : Column(
      children: [
        Text(languageMap['name']),
        IconButton(icon: Icon(Icons.animation), onPressed: (){replaceLanguage(context);}),
      ],
    );
  }
}
