import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimalType {
  final int id;
  final String label;
  final IconData icon;

  AnimalType({
    required this.id,
    required this.label,
    required this.icon,
  });

  List<Object?> get props => [id, label, icon];

  static List<AnimalType> animalTypes = [
    AnimalType(id: 0, label: "All", icon: FontAwesomeIcons.paw),
    AnimalType(id: 1, label: "Dog", icon: FontAwesomeIcons.dog),
    AnimalType(id: 2, label: "Cat", icon: FontAwesomeIcons.cat),
    AnimalType(id: 3, label: "Bird", icon: FontAwesomeIcons.crow),
    AnimalType(id: 4, label: "Horse", icon: FontAwesomeIcons.horse),
    AnimalType(id: 5, label: "Rabbit", icon: FontAwesomeIcons.frog),
  ];
}
