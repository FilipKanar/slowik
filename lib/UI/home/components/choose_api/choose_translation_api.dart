import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slowik/UI/home/components/info/info_message.dart';
import 'package:slowik/UI/home/components/list_tiles/api_tile.dart';
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

  Widget apiChooseBlocBuilder() {
    return BlocBuilder<TranslationApiBloc, TranslationApiState>(
        builder: (context, state) {
      if (state is TranslationApiInitial) {
        Provider.of<TranslationApiBloc>(context)
            .add(ChangeApi(chosenApi: GoogleTranslate()));
        return Center(
          child: Text('Initializing data'),
        );
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(21, 31, 21, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: InfoMessage(text: 'Wybierz Api',textSize: 27,fontWeight: FontWeight.bold,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ApiTile(
                name: 'google',
                assetPath: 'assets/images/icons/google_translate_icon.png',
                onPressed: () {
                  BlocProvider.of<TranslationApiBloc>(context)
                      .add(ChangeApi(chosenApi: GoogleTranslate()));
                  BlocProvider.of<UserLanguagesBloc>(context)
                      .add(ClearLanguagesOnSwitch());
                },
                focused: currentApi.runtimeType == GoogleTranslate,
              ),
              ApiTile(
                name: 'lingvanex',
                assetPath: 'assets/images/icons/lingvanex_icon.png',
                onPressed: () {
                  BlocProvider.of<TranslationApiBloc>(context)
                      .add(ChangeApi(chosenApi: LingvanexTranslate()));
                  BlocProvider.of<UserLanguagesBloc>(context)
                      .add(ClearLanguagesOnSwitch());
                },
                focused: currentApi.runtimeType == LingvanexTranslate,
              ),
              ApiTile(
                name: 'lyglo',
                assetPath: 'assets/images/icons/lyglo_icon.png',
                onPressed: () {
                  BlocProvider.of<TranslationApiBloc>(context)
                      .add(ChangeApi(chosenApi: LygloTranslate()));
                  BlocProvider.of<UserLanguagesBloc>(context)
                      .add(ClearLanguagesOnSwitch());
                },
                focused: currentApi.runtimeType == LygloTranslate,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
