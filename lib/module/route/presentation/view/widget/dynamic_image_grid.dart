import 'package:flutter/material.dart';

class DynamicImageGrid extends StatelessWidget {
  final List<String> imageUrls;

  const DynamicImageGrid({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemCount = imageUrls.length;
    final visibleItemCount = itemCount > 3 ? 3 : itemCount; // Отображаем не более 3

    // Функция для создания дочерних элементов GridView
    Widget _buildGridItem(int index) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.not_interested));
              },
            ),
          ),
        ),
      );
    }

    if (itemCount <= 1) {
      return itemCount == 1
          ? SizedBox.expand(child: _buildGridItem(0))
          : Container();
    } else if (itemCount == 2) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _buildGridItem(0)),
          Expanded(child: _buildGridItem(1)),
        ],
      );
    } else {
      // Всегда отображаем 3 изображения (или меньше, если их меньше)
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildGridItem(0),
                if (visibleItemCount > 1) _buildGridItem(1),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand, // Растягиваем Stack на всю доступную область
              children: [
                if (visibleItemCount > 2) _buildGridItem(2),
                // Виджет для отображения количества неотображаемых изображений
                if (itemCount > 3)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "+${itemCount - 3}", // Выводим количество неотображаемых изображений
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
