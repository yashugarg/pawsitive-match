import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pet_adoption/src/blocs/animal/animal_bloc.dart';
import 'package:pet_adoption/src/data/animals.dart';
import 'package:pet_adoption/src/models/animal.dart';

void main() {
  group('Animal Bloc Testing', () {
    late AnimalBloc animalBloc;

    setUp(() {
      animalBloc = AnimalBloc();
    });

    test("Initial Test", () {
      expect(animalBloc.state, isA<Loading>());
    });

    blocTest(
      "Animal Bloc Loader Test",
      build: () => animalBloc,
      act: (AnimalBloc bloc) => bloc.add(LoadAnimal()),
      expect: () =>
          [Loaded(animalData.map((e) => Animal.fromJson(e)).toList())],
      verify: (AnimalBloc bloc) => expect(bloc.state, isA<Loaded>()),
    );
  });
}
