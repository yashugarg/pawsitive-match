import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pet_adoption/src/blocs/animal/animal_bloc.dart';
import 'package:pet_adoption/src/models/animal.dart';
import 'package:pet_adoption/src/notifiers/adopted_provider.dart';
import 'package:pet_adoption/src/widgets/pet_card.dart';

class AdoptionHistoryScreen extends StatelessWidget {
  const AdoptionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adoptedProvider = context.watch<AdoptedProvider>();
    final deviceWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Adoption History',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(30.0)),
            color: Colors.grey.withOpacity(0.2),
          ),
          child: BlocProvider<AnimalBloc>(
            create: (context) => AnimalBloc()..add(LoadAnimal()),
            child: BlocBuilder<AnimalBloc, AnimalState>(
              builder: (context, state) {
                if (state is Loading) {
                  return Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      color: theme.primaryColor,
                    ),
                  );
                }

                if (state is Loaded) {
                  if (state.items.isEmpty) {
                    return Center(
                      child: Text(
                        'You have not adopted any pets yet.',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: theme.primaryColor,
                        ),
                      ),
                    );
                  } else {
                    List<Animal> pets = state.items;
                    pets.retainWhere((element) =>
                        adoptedProvider.adoptedPets[element.id.toString()] !=
                        null);
                    pets.sort(
                      (a, b) {
                        return DateTime.parse(
                                adoptedProvider.adoptedPets[b.id.toString()])
                            .compareTo(DateTime.parse(
                                adoptedProvider.adoptedPets[a.id.toString()]));
                      },
                    );
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              deviceWidth > 400 ? deviceWidth ~/ 400 : 1,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 30.0,
                          mainAxisExtent: 400.0),
                      padding: const EdgeInsets.all(20.0),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final animal = state.items[index];
                        if (adoptedProvider.adoptedPets[animal.id.toString()] !=
                            null) {
                          return PetCard(
                            animal: animal,
                            disabled: false,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    );
                  }
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
