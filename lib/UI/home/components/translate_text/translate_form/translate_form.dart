import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slowik/UI/home/components/info/info_message.dart';
import 'package:slowik/UI/home/components/output/output_message.dart';
import 'package:slowik/bloc/languages/user_languages_bloc.dart';
import 'package:slowik/bloc/translate/translate_bloc.dart';
import 'package:slowik/service/translation/api/translate_abstract.dart';

class TranslateForm extends StatefulWidget {
  final String userInput;

  TranslateForm({@required this.userInput});

  @override
  _TranslateFormState createState() => _TranslateFormState();
}

class _TranslateFormState extends State<TranslateForm> {
  final _formKey = GlobalKey<FormState>();
  TranslateAbstract selectedApi;
  String _inputString;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 17),
              child: InfoMessage(
                text: 'Wprowadz tekst',
                textSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 137,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                hintText: '...',
              ),
              validator: (value) {
                if (value.length < 2) {
                  return 'Provide text longer than 1 signs';
                }
                return null;
              },
              onChanged: (value) {
                _inputString = value;
              },
            ),
            Container(width: double.infinity,child: translateButton()),
            translatedText(),
          ],
        ),
      ),
    );
  }

  Widget translateButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          List<Map<String, dynamic>> selectedLanguages =
              Provider.of<UserLanguagesBloc>(context, listen: false)
                  .chosenLanguagesList;
          Map<String, dynamic> languageMap =
              Provider.of<UserLanguagesBloc>(context, listen: false)
                  .inputLanguageCode;
          print('List jezykow: ${selectedLanguages.toString()}');
          Provider.of<TranslateBloc>(context, listen: false).add(GetTranslation(
              text: _inputString,
              languages: selectedLanguages,
              inputLanguageCode: languageMap == null
                  ? null
                  : languageMap['languageCodeToTranslate']));
        }
      },
      child: Text('Przetłumacz'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
        shadowColor: Theme.of(context).primaryColorLight,
      ),
    );
  }

  Widget translatedText() {
    return Container(
      width: double.infinity,
        padding: EdgeInsets.all(7),
        child: SingleChildScrollView(child: OutputMessage()));
  }
}
