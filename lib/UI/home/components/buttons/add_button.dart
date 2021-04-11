import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String text;
  final Function callback;
  final Icon icon;

  AddButton(
      {@required this.text, @required this.callback, this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.brown[50],
         // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(17))),
          shadowColor: Theme.of(context).primaryColorDark,
        ),
        onPressed: () {
          callback();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: TextStyle(color: Theme.of(context).primaryColorDark,),),
            icon != null ? icon : Icon(Icons.add,color: Theme.of(context).primaryColorDark,),
          ],
        ));
  }
}
