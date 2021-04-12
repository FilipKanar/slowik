import 'package:flutter/material.dart';

class HorizontalTile extends StatelessWidget {
  final Map<String, dynamic> countryMap;

  HorizontalTile({@required this.countryMap});

  returnLanguageMap(BuildContext context, Map<String, dynamic> newMap) {
    Navigator.pop(context, newMap);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.brown[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(41))),
      ),
      onPressed: () {
        returnLanguageMap(context, countryMap);
      },
      child: Text(
        countryMap['name'],style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
    );
  }
}
