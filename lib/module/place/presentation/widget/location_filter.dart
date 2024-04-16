import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/place/domain/entity/place_filter_options.dart';
import 'package:moreway/module/place/domain/entity/selected_place_filters.dart';

class LocationFilter extends StatefulWidget {
  final PlaceFilterOptions filtersOptions;
  final SelectedPlaceFilters selectedPlaceFilters;
  final void Function(SelectedPlaceFilters) onSubmit;

  const LocationFilter({
    super.key,
    required this.filtersOptions,
    required this.onSubmit,
    required this.selectedPlaceFilters,
  });

  @override
  State<LocationFilter> createState() => _LocationFilterState();
}

class _LocationFilterState extends State<LocationFilter> {
  late SelectedPlaceFilters _selectedPlaceFilters;

  @override
  void initState() {
    super.initState();
    _selectedPlaceFilters = widget.selectedPlaceFilters.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Фильтры',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildRatingSlider(),
          const SizedBox(height: 16.0),
          _buildDistanceSlider(),
          const SizedBox(height: 16.0),
          _buildLocalityDropdown(),
          const SizedBox(height: 16.0),
          _buildTypeDropdown(),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              widget.onSubmit(_selectedPlaceFilters);
            },
            child: const Text('Применить фильтры'),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Рейтинг',
          style: TextStyle(fontSize: 16.0),
        ),
        Container(
          width: 200.0,
          child: RangeSlider(
            activeColor: AppColor.black,
            divisions: 5,
            labels: RangeLabels(
              _selectedPlaceFilters.rangeRating[0].toStringAsFixed(0),
              _selectedPlaceFilters.rangeRating[1].toStringAsFixed(0),
            ),
            min: widget.filtersOptions.rangeRating[0],
            max: widget.filtersOptions.rangeRating[1],
            values: RangeValues(
              _selectedPlaceFilters.rangeRating[0],
              _selectedPlaceFilters.rangeRating[1],
            ),
            onChanged: (values) {
              setState(() {
                _selectedPlaceFilters.rangeRating = [values.start, values.end];
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDistanceSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Расстояние',
          style: TextStyle(fontSize: 16.0),
        ),
        Container(
          width: 200.0,
          child: RangeSlider(
            activeColor: AppColor.black,
            labels: RangeLabels(
              _selectedPlaceFilters.distance[0].toStringAsFixed(0),
              _selectedPlaceFilters.distance[1].toStringAsFixed(0),
            ),
            min: widget.filtersOptions.rangeDistance[0].toDouble(),
            max: widget.filtersOptions.rangeDistance[1].toDouble(),
            values: RangeValues(
              _selectedPlaceFilters.distance[0].toDouble(),
              _selectedPlaceFilters.distance[1].toDouble(),
            ),
            onChanged: (values) {
              setState(() {
                _selectedPlaceFilters.distance = [
                  values.start.toInt(),
                  values.end.toInt()
                ];
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLocalityDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Город',
          style: TextStyle(fontSize: 16.0),
        ),
        DropdownButton(
            value: _selectedPlaceFilters.locality,
            onChanged: (value) {
              setState(() {
                _selectedPlaceFilters.locality = value;
              });
            },
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text('Не выбрано'),
              ),
              ...widget.filtersOptions.localities
                  .map(
                    (locality) => DropdownMenuItem(
                      value: locality,
                      child: Text(locality),
                    ),
                  )
                  .toList(),
            ]),
      ],
    );
  }

  Widget _buildTypeDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Тип',
          style: TextStyle(fontSize: 16.0),
        ),
        DropdownButton(
            value: _selectedPlaceFilters.type,
            onChanged: (value) {
              setState(() {
                _selectedPlaceFilters.type = value;
              });
            },
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text('Не выбрано'),
              ),
              ...widget.filtersOptions.types
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    ),
                  )
                  .toList(),
            ]),
      ],
    );
  }
}
