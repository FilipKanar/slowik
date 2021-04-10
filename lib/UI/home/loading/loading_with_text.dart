import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWithText extends StatelessWidget {

  final String text;
  LoadingWithText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitPouringHourglass(color: Colors.green),
            Padding(
              padding: const EdgeInsets.all(3.5),
              child: Text(text, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}
