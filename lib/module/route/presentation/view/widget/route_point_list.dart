import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_base.dart';

class RoutePointsList extends StatelessWidget {
  final List<PlaceBase> points;

  const RoutePointsList({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView.separated(
      itemCount: points.length,
      itemBuilder: (context, index) {
        return _buildPointTile(context, index, textTheme);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 1,
          thickness: 1,
          indent: 40,
          endIndent: 20,
          color: AppColor.gray,
        );
      },
    );
  }

  Widget _buildPointTile(BuildContext context, int index, TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildPointIndexCircle(index),
        const SizedBox(width: 5),
        Expanded(
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: 16),
              //subtitle: _buildDistanceRow(index, textTheme),
              leading: _buildImageAvatar(index),
              title: Text(
                points[index].name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontFamily: "roboto"),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPointIndexCircle(int index) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: AppColor.pink,
      child: CircleAvatar(
        radius: 15,
        backgroundColor: AppColor.white,
        child: Text(
          "${index + 1}",
          style: const TextStyle(color: AppColor.black),
        ),
      ),
    );
  }

  Widget _buildImageAvatar(int index) {
    return CircleAvatar(
      radius: 24,
      child: ClipOval(
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            points[index].image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.not_interested));
            },
          ),
        ),
      ),
    );
  }
}