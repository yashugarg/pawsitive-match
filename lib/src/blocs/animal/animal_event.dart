part of 'animal_bloc.dart';

abstract class AnimalEvent extends Equatable {
  const AnimalEvent();

  @override
  List<Object> get props => [];
}

class LoadAnimal extends AnimalEvent {}
