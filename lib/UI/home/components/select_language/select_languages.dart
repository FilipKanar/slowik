import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slowik/UI/home/components/info/info_message.dart';
import 'package:slowik/UI/home/components/list_tiles/country_tile.dart';
import 'package:slowik/UI/home/components/list_tiles/detect_language_tile.dart';
import 'package:slowik/UI/home/loading/loading_with_text.dart';
import 'package:slowik/bloc/api/translation_api_bloc.dart';
import 'package:slowik/bloc/languages/user_languages_bloc.dart';
import 'package:slowik/service/translation/api/translate_abstract.dart';

class SelectLanguages extends StatefulWidget {
  @override
  _SelectLanguagesState createState() => _SelectLanguagesState();
}

class _SelectLanguagesState extends State<SelectLanguages> {
  @override
  Widget build(BuildContext context) {
    return selectedLanguagesBlocBuilder();
  }

  Widget selectedLanguagesBlocBuilder() {
    return BlocBuilder<UserLanguagesBloc, UserLanguagesState>(
        builder: (context, state) {
      if (state is UserLanguagesInitial) {
        return selectedLanguagesList(state.props[0]);
      } else if (state is UserLanguagesLoading) {
        return LoadingWithText(text: 'Loading languages list');
      } else if (state is UserLanguagesLoaded) {
        return selectedLanguagesList(state.props[0]);
      } else {
        return Text('Sth wrong');
      }
    });
  }

  Widget selectedLanguagesList(List<Map<String, dynamic>> selectedLanguages) {
    TranslateAbstract translateAbstract =
        Provider.of<TranslationApiBloc>(context).state.props[0];
    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 41, 17, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,13),
            child: translateAbstract.autoDetect
                ? InfoMessage(
                    text: 'Wybrane api rozpozna jezyk wprowadzanego tekstu. Wybierz jezyki przez ktore chcesz przetlumaczyc.',
                    fontWeight: FontWeight.bold,
                    textSize: 17,
                  )
                : InfoMessage(
                    text: 'Wybierz jezyk wprowadzanego tekstu oraz jezyki przez ktore chcesz przetlumaczyc.',
                    fontWeight: FontWeight.bold,
                    textSize: 17,
                  ),
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 3,
              crossAxisCount: 3,
              childAspectRatio: 2.3,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(1.77),
                child: index == 0
                    ? DetectLanguageTile(
                        languageMap: Provider.of<UserLanguagesBloc>(context)
                            .state
                            .props[1],
                        autoDetect: translateAbstract.autoDetect,
                      )
                    : CountryTile(
                      languageMap: selectedLanguages[index - 1],
                      tileIndex: index - 1,
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}
