import 'package:flutter/material.dart';

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
            CircularProgressIndicator(
              strokeWidth: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(3.5),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
