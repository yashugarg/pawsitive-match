part of 'animal_bloc.dart';

abstract class AnimalState extends Equatable {
  const AnimalState();

  @override
  List<Object> get props => [];
}

class AnimalInitial extends AnimalState {}

class Loaded extends AnimalState implements ItemSourceState<Animal> {
  @override
  final List<Animal> items;

  const Loaded(this.items);

  @override
  List<Object> get props => [items];
}

class Loading extends AnimalState {
  @override
  List<Object> get props => ['Loading'];
}
