import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slowik/UI/home/components/list_tiles/country_tile.dart';
import 'package:slowik/UI/home/components/list_tiles/horizontal_tile.dart';
import 'package:slowik/UI/home/loading/loading_with_text.dart';
import 'package:slowik/bloc/api/translation_api_bloc.dart';

class LanguageList extends StatefulWidget {
  @override
  _LanguageListState createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
  @override
  Widget build(BuildContext context) {
    return languageListBlocBuilder();
  }

  languageListBlocBuilder() {
    return BlocBuilder<TranslationApiBloc, TranslationApiState>(
        builder: (context, state) {
      if (state is TranslationApiLoading) {
        return LoadingWithText(text: 'Loading supported languages');
      } else if (state is TranslationApiLoaded) {
        return listViewBuilder(state.supportedLanguages);
      } else {
        return Container(
          child: Text('Sth wrong'),
        );
      }
    });
  }

  listViewBuilder(Map<String, dynamic> languageMap) {
    return GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 4.7,
        crossAxisSpacing: 4.7,
        crossAxisCount: 2,
        childAspectRatio: 2.5,
      ),
      shrinkWrap: true,
      itemCount: languageMap.length,
      itemBuilder: (context, index) {
        return HorizontalTile(
          countryMap: languageMap.values.elementAt(index),
        );
      },
    );
  }
}
