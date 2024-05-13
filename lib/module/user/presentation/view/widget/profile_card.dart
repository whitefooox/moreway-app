import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  const ProfileCard({super.key, required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          child: Image.network(
            imageUrl,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.not_interested);
            },
          ),
        ),
        const SizedBox(height: 10,),
        Text(
          name,
          style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)
        )
      ],
    );
  }
}
