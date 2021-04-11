import 'package:flutter/material.dart';

class InfoMessage extends StatelessWidget {
  final String text;
  final double textSize;
  final FontWeight fontWeight;
  InfoMessage({@required this.text, this.textSize, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: textSize, fontWeight: fontWeight,color: Theme.of(context).primaryColorDark),textAlign: TextAlign.center,);
  }
}
