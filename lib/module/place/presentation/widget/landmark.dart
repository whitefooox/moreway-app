import 'package:flutter/material.dart';

class Attraction1Card extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double rating;
  final double distance;

  const Attraction1Card({super.key, 
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            imageUrl,
            height: 200.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    const Icon(Icons.star, color: Colors.amber, size: 20.0),
                    Text(
                      '$rating',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
                Text(
                  '${distance.toStringAsFixed(1)} км до достопримечательности',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}