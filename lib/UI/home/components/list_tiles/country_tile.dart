import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slowik/UI/home/components/buttons/add_button.dart';
import 'package:slowik/UI/home/components/select_language/dialog/choose_language_dialog.dart';
import 'package:slowik/bloc/languages/user_languages_bloc.dart';

class CountryTile extends StatelessWidget {
  final Map<String, dynamic> languageMap;
  final int tileIndex;

  CountryTile({@required this.tileIndex, @required this.languageMap});

  replaceLanguage(BuildContext context) async {
    var newLanguage =
        await ChooseLanguageDialog().languageSelectDialog(context);
    BlocProvider.of<UserLanguagesBloc>(context)
        .add(ReplaceLanguage(index: tileIndex, newLanguageMap: newLanguage));
  }

  @override
  Widget build(BuildContext context) {
    return languageMap == null
        ? AddButton(text: '${(tileIndex+1).toString()}.',callback: () {replaceLanguage(context);},)
        : ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.brown[100],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(17))),
            ),
            onPressed: () {
              replaceLanguage(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(languageMap['name'], style: TextStyle(color: Theme.of(context).primaryColorDark,),),
                Text(languageMap['languageCodeShort'], style: TextStyle(color: Theme.of(context).primaryColorDark,),),
              ],
            ));
  }
}
