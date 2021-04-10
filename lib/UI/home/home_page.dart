import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slowik/UI/home/components/select_language/select_languages.dart';
import 'package:slowik/UI/home/components/translate_text/translate_text.dart';
import 'package:slowik/UI/home/loading/loading_with_text.dart';
import 'package:slowik/bloc/api/translation_api_bloc.dart';
import 'package:slowik/bloc/translate/translate_bloc.dart';
import 'package:slowik/service/translation/api/translate_abstract.dart';

import 'components/choose_api/choose_translation_api.dart';

class HomePageProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TranslateAbstract previousApi;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: buildApiBlocBuilder()));
  }

  Widget buildApiBlocBuilder() {
    return BlocBuilder<TranslationApiBloc, TranslationApiState>(
        builder: (context, state) {
      if (state is TranslationApiInitial) {
        previousApi=state.supportedApi;
        Provider.of<TranslateBloc>(context).add(ReplaceTranslationApi(selectedApi: previousApi));
        return generateHomeView();
      } else if (state is TranslationApiLoading) {
        return LoadingWithText(text: 'Loading api data');
      } else if (state is TranslationApiLoaded) {
        if(previousApi.runtimeType != state.props[0].runtimeType) {
          previousApi=state.props[0];
          Provider.of<TranslateBloc>(context).add(ReplaceTranslationApi(selectedApi: state.props[0]));
        }
        return generateHomeView();
      } else {
        return Container(
          child: Text('Sth wrong'),
        );
      }
    });
  }

  Widget generateHomeView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChooseTranslationApi(),
            SelectLanguages(),
            TranslateText(),
          ],
        );
  }
}
