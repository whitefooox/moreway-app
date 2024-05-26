import 'package:flutter/material.dart';

Future<String?> showCreateRouteNameDialog(BuildContext context) async {
  String routeName = '';

  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Как назвать маршрут?'),
        content: TextField(
          onChanged: (value) {
            routeName = value;
          },
          decoration: const InputDecoration(hintText: 'Название...'),
        ),
        actions: [
          TextButton(
            child: const Text('Отмена'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(routeName);
            },
          ),
        ],
      );
    },
  );
}
