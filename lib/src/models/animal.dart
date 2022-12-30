import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_list_manager/flutter_bloc_list_manager.dart';

class Animal extends Equatable implements ItemClassWithAccessor {
  final int id;
  final String type;
  final String name;
  final String description;
  final String age;
  final String gender;
  final String size;
  final List<String> tags;
  final List<String> images;

  const Animal({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.age,
    required this.gender,
    required this.size,
    required this.tags,
    required this.images,
  });

  @override
  operator [](String prop) {
    switch (prop) {
      case 'id':
        return id;
      case 'type':
        return type;
      case 'name':
        return name;
      case 'description':
        return description;
      case 'age':
        return age;
      case 'gender':
        return gender;
      case 'size':
        return size;
      case 'tags':
        return tags;
      case 'images':
        return images;
      default:
        throw ArgumentError('Property `$prop` does not exist on Animal.');
    }
  }

  @override
  List<Object?> get props => [
        id,
        type,
        name,
        description,
        age,
        gender,
        size,
        tags,
        images,
      ];

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['id'] as int,
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      age: json['age'] ?? '',
      gender: json['gender'] ?? '',
      size: json['size'] ?? '',
      tags: json['tags'] == null ? <String>[] : json['tags'].cast<String>(),
      images: json['photos'] == null || json['photos'] == []
          ? <String>[]
          : (json['photos'] as List).map<String>((e) => e['full']!).toList(),
    );
  }
}
