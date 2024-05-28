import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onClickFilter;
  final void Function(String)? onChanged;
  final bool isFiltersActive;

  const AppSearchBar({
    super.key,
    this.controller,
    this.onClickFilter,
    this.onChanged,
    this.isFiltersActive = false
  });

  @override
  Widget build(BuildContext context) {
    const double height = 45.0; // Высота для всех виджетов
    const double filterButtonSize = 45.0; // Размер квадратной кнопки фильтров
    const double spacing = 10.0; // Расстояние между виджетами

    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: const TextStyle(fontSize: 12),
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: "Куда отправимся?",
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
                hintStyle: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          const SizedBox(width: spacing),
          SizedBox(
            width: filterButtonSize,
            height: filterButtonSize,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColor.black,
              ),
              child: IconButton(
                onPressed: onClickFilter,
                icon: Badge(
                  isLabelVisible: isFiltersActive,
                  child: const Icon(
                    Icons.tune,
                    color: AppColor.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
