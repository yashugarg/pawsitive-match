import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_list_manager/flutter_bloc_list_manager.dart';

import 'package:pet_adoption/src/models/animal_type_model.dart';

class AnimalFilterLauncher extends StatelessWidget {
  final List<AnimalType> animalTypes;
  const AnimalFilterLauncher({required this.animalTypes, super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => AnimalTypeFilter(
        filterConditionsBloc: context.read<FilterConditionsBloc>(),
        animalTypes: animalTypes,
      ),
    );
  }
}

class AnimalTypeFilter extends StatelessWidget {
  final List<AnimalType> animalTypes;
  final FilterConditionsBloc _filterConditionsBloc;

  const AnimalTypeFilter({
    required FilterConditionsBloc filterConditionsBloc,
    required this.animalTypes,
    super.key,
  }) : _filterConditionsBloc = filterConditionsBloc;

  bool selectedCondition(int index) {
    if (index != 0) {
      return isActive(animalTypes[index].label);
    } else {
      return !animalTypes.fold(false,
          (previousValue, element) => previousValue || isActive(element.label));
    }
  }

  isActive(String value) {
    return _filterConditionsBloc.isConditionActive("type", value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      child: BlocBuilder<FilterConditionsBloc, FilterConditionsState>(
        bloc: _filterConditionsBloc,
        builder: (context, state) {
          final theme = Theme.of(context);
          if (state is ConditionsInitialized) {
            return ListView.builder(
              padding: const EdgeInsets.only(
                left: 24.0,
                top: 8.0,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: animalTypes.length,
              itemBuilder: (context, index) {
                final _selectedCondition = selectedCondition(index);
                return Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _selectAnimal(
                            animalTypes[index],
                            state.availableConditions['type'],
                          );
                        },
                        child: Material(
                          color: _selectedCondition
                              ? theme.primaryColor
                              : theme.backgroundColor,
                          elevation: 8.0,
                          borderRadius: BorderRadius.circular(20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              AnimalType.animalTypes[index].icon,
                              size: 30.0,
                              color: _selectedCondition
                                  ? theme.backgroundColor
                                  : theme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        animalTypes[index].label,
                        style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _selectAnimal(AnimalType value, List<String>? availableConditions) {
    if (isActive(value.label)) return;
    for (var element in animalTypes) {
      if (isActive(element.label)) {
        _filterConditionsBloc.add(RemoveCondition(
          property: 'type',
          value: element.label,
        ));
      }
    }
    if (value.id != 0) {
      _filterConditionsBloc.add(AddCondition(
        property: 'type',
        value: value.label,
      ));
    }
  }
}
