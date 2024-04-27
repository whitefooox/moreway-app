import 'package:flutter/material.dart';

IconData buildIconFromPlaceType(String type) {
  switch (type) {
    case "Парк":
      return Icons.park;
    case "Площадь":
      return Icons.square;
    case "Музей":
      return Icons.museum;
    case "Ресторан":
      return Icons.restaurant;
    default:
      return Icons.location_on;
  }
}
