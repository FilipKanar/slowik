import 'package:flutter/material.dart';

class ApiTile extends StatelessWidget {
  final String assetPath;
  final String name;
  final Function onPressed;
  final bool focused;

  ApiTile({this.assetPath,this.onPressed,this.focused, @required this.name});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.all(9.11),
        child: Column(
          children: [
            Image.asset(assetPath, height: 50, width: 50,),
            Text(name, style: TextStyle(color: Theme.of(context).primaryColorDark),),
          ],
        ),
      ),
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        primary: focused ? Colors.brown[100] : Colors.brown[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
        side: focused
            ? BorderSide(color: Theme.of(context).primaryColorDark,)
            : BorderSide(color: Theme.of(context).primaryColorLight),
      ),
    );
  }
}
