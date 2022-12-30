import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_list_manager/flutter_bloc_list_manager.dart';

import 'package:pet_adoption/src/data/animals.dart';
import 'package:pet_adoption/src/models/animal.dart';

part 'animal_event.dart';
part 'animal_state.dart';

class AnimalBloc extends Bloc<AnimalEvent, AnimalState> {
  AnimalBloc() : super(Loading()) {
    on<AnimalEvent>(
      (event, emit) => emit(
        Loaded(petsData),
      ),
    );
  }
}
