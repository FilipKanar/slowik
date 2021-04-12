import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slowik/UI/home/components/info/info_message.dart';
import 'package:slowik/UI/home/loading/loading_with_text.dart';
import 'package:slowik/bloc/translate/translate_bloc.dart';

class OutputMessage extends StatelessWidget {
  OutputMessage();

  @override
  Widget build(BuildContext context) {
    Column();
    return translateBlocBuilder();
  }

  translateBlocBuilder() {
    return BlocBuilder<TranslateBloc, TranslateState>(
        builder: (context, state) {
      if (state is TranslateInitial) {
        return initialMessage();
      } else if (state is TranslateLoading) {
        return LoadingWithText(text: 'Loading translation');
      } else if (state is TranslateLoaded) {
        print('loaded');
        return buildOutputMessage(
            state.props[0], state.props[1], state.props[2]);
      } else {
        return Container();
      }
    });
  }

  Widget initialMessage() {
    return Container();
  }

  Widget buildOutputMessage(
      String input, String output, List<String> middleTranslations) {
    print('build output message: $input');
    print('build output message: $output');
    print('build output message: ${middleTranslations.toString()}');
    return input == null || output == null || middleTranslations == null
        ? initialMessage()
        : Column(
      mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(17, 3, 17, 0),
                child: InfoMessage(
                  text: 'Tłumaczenie:',
                  fontWeight: FontWeight.bold,
                  textSize: 17,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(17, 11, 17, 0),
                child: InfoMessage(
                  text: input,
                  textSize: 13,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(17, 17, 17, 0),
                child: InfoMessage(
                  text: 'Wszystkie tłumaczenia:',
                  fontWeight: FontWeight.bold,
                  textSize: 17,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(17, 17, 17, 50),
                child: ListView.builder(
                  shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: middleTranslations.length,
                    itemBuilder: (context, index) {
                      return InfoMessage(
                        text: middleTranslations[index],
                        textSize: 13,
                      );
                    }),
              ),
            ],
          );
  }
}
