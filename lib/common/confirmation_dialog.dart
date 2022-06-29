import 'package:flutter/material.dart';

class ConfirmationDialog {
  static openConfirmationDialog(
    title,
    subtitle,
    context,
  ) =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(title),
                content: (Text(subtitle)),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: const Color.fromARGB(255, 0, 95, 55),
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Ne'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 95, 55),
                      primary: const Color.fromARGB(255, 255, 255, 255),
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () => {
                      Navigator.pop(context, true),
                    },
                    child: const Text('Da'),
                  ),
                ],
              ));
}
