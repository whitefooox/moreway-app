import 'package:flutter/material.dart';

Future<void> showFewPlacesDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Мало мест'),
        content: const Text(
          'Для создания маршрута необходимо не менее 2 достопримечательностей.',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
