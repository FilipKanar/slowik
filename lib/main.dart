import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slowik/bloc/languages/user_languages_bloc.dart';
import 'package:slowik/bloc/translate/translate_bloc.dart';

import 'UI/home/home_page.dart';
import 'bloc/api/translation_api_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TranslationApiBloc()),
        BlocProvider(create: (context) => UserLanguagesBloc()),
        BlocProvider(create: (context) => TranslateBloc())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePageProvider(),
      ),
    );
  }
}

