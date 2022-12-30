import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_list_manager/flutter_bloc_list_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pet_adoption/src/blocs/animal/animal_bloc.dart';
import 'package:pet_adoption/src/models/animal.dart';
import 'package:pet_adoption/src/models/animal_type_model.dart';
import 'package:pet_adoption/src/notifiers/adopted_provider.dart';
import 'package:pet_adoption/src/notifiers/theme_provider.dart';
import 'package:pet_adoption/src/screens/adoption_history.dart';
import 'package:pet_adoption/src/widgets/animal_search_query.dart';
import 'package:pet_adoption/src/widgets/animal_type_filter.dart';
import 'package:pet_adoption/src/widgets/pet_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themProvider = context.watch<DarkThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 100.0,
        leading: InkWell(
          child: Icon(
            themProvider.darkTheme
                ? FontAwesomeIcons.moon
                : FontAwesomeIcons.solidMoon,
          ),
          onTap: () {
            themProvider.darkTheme = !themProvider.darkTheme;
          },
        ),
        centerTitle: true,
        title: const Text(
          'Pawsitive Match',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdoptionHistoryScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.history),
            ),
          ),
        ],
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
            child: ListManager<Animal, Loaded, AnimalBloc>(
              filterProperties: const ['type'],
              searchProperties: const ['name', 'gender', 'age', 'size', 'tags'],
              child: Column(
                children: [
                  const AnimalSearchQuery(),
                  AnimalFilterLauncher(
                    animalTypes: AnimalType.animalTypes,
                  ),
                  const SizedBox(height: 10.0),
                  const Expanded(child: ItemListRenderer()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemListRenderer extends StatelessWidget {
  const ItemListRenderer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adoptedProvider = context.watch<AdoptedProvider>();
    final deviceWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<ItemListBloc, ItemListState>(
      builder: (_, state) {
        if (state is NoSourceItems) {
          return const Text('No source items');
        }

        if (state is ItemEmptyState) {
          return const Text('No matching results');
        }

        if (state is ItemResults<Animal>) {
          return GridView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: deviceWidth > 400 ? deviceWidth ~/ 400 : 1,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 30.0,
              mainAxisExtent: 400.0,
            ),
            padding: const EdgeInsets.all(20.0),
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final animal = state.items[index];

              return PetCard(
                animal: animal,
                disabled:
                    adoptedProvider.adoptedPets[animal.id.toString()] != null,
              );
            },
          );
        }

        return Container();
      },
    );
  }
}
