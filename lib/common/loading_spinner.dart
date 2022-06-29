import 'package:flutter/material.dart';

//Prikaz spinnera -  buildLoading(context);
//Makni spinner - Navigator.of(context).pop();

buildLoadingSpinner(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        );
      });
}

removeLoadingSpinner(BuildContext context) {
  Navigator.of(context).pop();
}