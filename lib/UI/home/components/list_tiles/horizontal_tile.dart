import 'package:flutter/material.dart';

class HorizontalTile extends StatelessWidget {
  final Map<String,dynamic> countryMap;
  HorizontalTile({@required this.countryMap});

  returnLanguageMap(BuildContext context,Map<String,dynamic> newMap){
    Navigator.pop(context, newMap);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(onPressed: (){
          returnLanguageMap(context, countryMap);
        }, child: Row(
          children: [Text(countryMap['name'])],
        ),)
      ],
    );
  }
}
