import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
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
    return Column(
      children: [
        translateAbstract.autoDetect
            ? Container()
            : DetectLanguageTile(
                languageMap:
                    Provider.of<UserLanguagesBloc>(context).state.props[1]),
        Container(
          alignment: Alignment.center,
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CountryTile(
                languageMap: selectedLanguages[index],
                tileIndex: index,
              );
            },
          ),
        ),
      ],
    );
  }
}
