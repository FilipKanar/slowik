import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slowik/bloc/languages/user_languages_bloc.dart';
import 'package:slowik/bloc/translate/translate_bloc.dart';
import 'package:slowik/service/translation/api/translate_abstract.dart';

class TranslateForm extends StatefulWidget {
  final String userInput;
  final String translatedString;
  TranslateForm({@required this.userInput,@required this.translatedString});
  @override
  _TranslateFormState createState() => _TranslateFormState();
}

class _TranslateFormState extends State<TranslateForm> {
  final _formKey = GlobalKey<FormState>();
  TranslateAbstract selectedApi;
  String _inputString;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            maxLength: 137,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter some text',
            ),
            validator: (value) {
              if(value.length<2){
                return 'Provide text longer than 1 signs';
              }
              return null;
            },
            onChanged: (value) {
              _inputString = value;
            },
          ),
          translateButton(),
          translatedText(widget.translatedString),
        ],
      ),
    );
  }

  Widget translateButton() {
    return RaisedButton(onPressed: () {
      if(_formKey.currentState.validate()){
        List<Map<String,dynamic>> selectedLanguages = Provider.of<UserLanguagesBloc>(context, listen: false).chosenLanguagesList;
        Map<String,dynamic> languageMap= Provider.of<UserLanguagesBloc>(context, listen: false).inputLanguageCode;
        print('List jezykow: ${selectedLanguages.toString()}');
        Provider.of<TranslateBloc>(context, listen: false).add(GetTranslation(text: _inputString, languages: selectedLanguages, inputLanguageCode: languageMap == null ? null : languageMap['languageCodeToTranslate']));
      }
    },
    child: Text('Translate'),);
  }

  Widget translatedText(String text){
    return Container(padding:EdgeInsets.all(7),child: SelectableText(text== null ? 'Output' : text));
  }
}
