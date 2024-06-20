import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/route/domain/entity/route.dart' as domain;

class RouteListTile extends StatelessWidget {
  final domain.Route route;

  const RouteListTile({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          route.points.first.image,
        ),
      ),
      title: Text(route.name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Row(
        children: [
          Chip(
            label: Text(route.rating.toStringAsFixed(1)),
            backgroundColor: AppColor.gray.withOpacity(0.1),
            avatar: Icon(Icons.star, color: AppColor.pink),
          ),
          SizedBox(width: 5),
          Chip(
            label: Text("${route.points.length} мест"),
            backgroundColor: AppColor.gray.withOpacity(0.1),
            avatar: Icon(Icons.location_on, color: AppColor.pink),
          ),
        ],
      ),
    );
  }
}
