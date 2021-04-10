import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slowik/UI/home/loading/loading_with_text.dart';
import 'package:slowik/bloc/api/translation_api_bloc.dart';
import 'package:slowik/bloc/languages/user_languages_bloc.dart';
import 'package:slowik/service/translation/api/translate_abstract.dart';
import 'package:slowik/service/translation/google/google_translate.dart';
import 'package:slowik/service/translation/lingvanex/lingvanex_translate.dart';
import 'package:slowik/service/translation/lyglo/lyglo_translate.dart';

class ChooseTranslationApi extends StatefulWidget {

  @override
  _ChooseTranslationApiState createState() => _ChooseTranslationApiState();
}

class _ChooseTranslationApiState extends State<ChooseTranslationApi> {

  @override
  Widget build(BuildContext context) {
    return apiChooseBlocBuilder();
  }

  Widget apiChooseBlocBuilder(){
    return BlocBuilder<TranslationApiBloc, TranslationApiState>(
        builder: (context, state) {
          if (state is TranslationApiInitial) {
            Provider.of<TranslationApiBloc>(context).add(ChangeApi(chosenApi: GoogleTranslate()));
            return Center(child: Text('Initializing data'),);
          } else if (state is TranslationApiLoading) {
            return LoadingWithText(text: 'Loading translation apis');
          } else if (state is TranslationApiLoaded) {
            return buildChooseApi(state.props[0]);
          } else {
            return Container(
              child: Text('Sth wrong'),
            );
          }
        });
  }


  Widget buildChooseApi(TranslateAbstract currentApi) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          child: Text('Google'),
          onPressed: () {
            BlocProvider.of<TranslationApiBloc>(context)
                .add(ChangeApi(chosenApi: GoogleTranslate()));
            BlocProvider.of<UserLanguagesBloc>(context).add(ClearLanguagesOnSwitch());
          },
          style: TextButton.styleFrom(
            side: currentApi.runtimeType == GoogleTranslate
                ? BorderSide(color: Theme.of(context).primaryColorDark)
                : BorderSide(color: Theme.of(context).primaryColorLight),
          ),
        ),
        TextButton(
          child: Text('Lingvanex'),
          onPressed: () {
            BlocProvider.of<TranslationApiBloc>(context)
                .add(ChangeApi(chosenApi: LingvanexTranslate()));
            BlocProvider.of<UserLanguagesBloc>(context).add(ClearLanguagesOnSwitch());
          },
          style: TextButton.styleFrom(
            side: currentApi.runtimeType == LingvanexTranslate
                ? BorderSide(color: Theme.of(context).primaryColorDark)
                : BorderSide(color: Theme.of(context).primaryColorLight),
          ),
        ),
        TextButton(
          child: Text('Lyglo'),
          onPressed: () {
            BlocProvider.of<TranslationApiBloc>(context)
                .add(ChangeApi(chosenApi:LygloTranslate()));
            BlocProvider.of<UserLanguagesBloc>(context).add(ClearLanguagesOnSwitch());
          },
          style: TextButton.styleFrom(
            side: currentApi.runtimeType == LygloTranslate
                ? BorderSide(color: Theme.of(context).primaryColorDark)
                : BorderSide(color: Theme.of(context).primaryColorLight),
          ),
        ),
      ],
    );
  }

}