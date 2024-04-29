import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/place/domain/entity/place_filter_options.dart';
import 'package:moreway/module/place/domain/entity/selected_place_filters.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

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
    _selectedPlaceFilters = widget.selectedPlaceFilters.copyWithNull(
        rangeRating: () =>
            widget.selectedPlaceFilters.rangeRating ??
            widget.filtersOptions.rangeRating,
        distance: () =>
            widget.selectedPlaceFilters.distance ??
            widget.filtersOptions.rangeDistance);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(screenSize.width * 0.035),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRatingSlider(),
          const SizedBox(height: 5),
          _buildDistanceSlider(),
          const SizedBox(height: 5),
          _buildLocalityDropdown(),
          const SizedBox(height: 5),
          _buildTypeDropdown(),
          SizedBox(height: screenSize.width * 0.035),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.done),
                  onPressed: () {
                    widget.onSubmit(_selectedPlaceFilters);
                  },
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text('Применить'),
                  ),
                ),
              ),
              SizedBox(
                width: screenSize.width * 0.035,
              ),
              Expanded(
                  flex: 1,
                  child: ElevatedButton.icon(
                      icon: const Icon(Icons.clear),
                      onPressed: () {},
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text("Сбросить"),
                      )))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          flex: 3,
          child: Text(
            'Рейтинг',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 6,
          child: SfRangeSlider(
            activeColor: AppColor.black,
            min: widget.filtersOptions.rangeRating[0],
            max: widget.filtersOptions.rangeRating[1],
            values: SfRangeValues(
              _selectedPlaceFilters.rangeRating![0],
              _selectedPlaceFilters.rangeRating![1],
            ),
            interval: 1,
            stepSize: 1,
            showLabels: true,
            showDividers: true,
            onChanged: (values) {
              setState(() {
                _selectedPlaceFilters = _selectedPlaceFilters.copyWithNull(
                    rangeRating: () => [values.start, values.end]);
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
        const Expanded(
          flex: 3,
          child: Text(
            'Расстояние',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 6,
          child: SfRangeSlider(
            activeColor: AppColor.black,
            interval: (widget.filtersOptions.rangeDistance[1].toDouble() -
                    widget.filtersOptions.rangeDistance[0].toDouble()) /
                4,
            showLabels: true,
            showDividers: true,
            min: widget.filtersOptions.rangeDistance[0].toDouble(),
            max: widget.filtersOptions.rangeDistance[1].toDouble(),
            values: SfRangeValues(
              _selectedPlaceFilters.distance![0].toDouble(),
              _selectedPlaceFilters.distance![1].toDouble(),
            ),
            onChanged: (values) {
              setState(() {
                _selectedPlaceFilters = _selectedPlaceFilters.copyWithNull(
                  distance: () => [values.start.toInt(), values.end.toInt()],
                );
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
            icon: null,
            value: _selectedPlaceFilters.locality,
            onChanged: (value) {
              setState(() {
                _selectedPlaceFilters = _selectedPlaceFilters.copyWithNull(
                  locality: () => value,
                );
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
                _selectedPlaceFilters = _selectedPlaceFilters.copyWithNull(
                  type: () => value,
                );
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
