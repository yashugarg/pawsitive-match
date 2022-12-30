import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:pet_adoption/src/models/animal.dart';
import 'package:pet_adoption/src/notifiers/adopted_provider.dart';
import 'package:pet_adoption/src/widgets/show_confetti_dialog.dart';

class AnimalDetailScreen extends StatelessWidget {
  final Animal animal;

  const AnimalDetailScreen({required this.animal, super.key});

  @override
  Widget build(BuildContext context) {
    final adoptedProvider = context.watch<AdoptedProvider>();
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final isAdopted = adoptedProvider.adoptedPets[animal.id.toString()] != null;
    return Scaffold(
      backgroundColor: theme.backgroundColor.withOpacity(0.9),
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: screenHeight * 0.35,
            child: Hero(
              tag: animal.name,
              child: animal.images.length < 2
                  ? Image(
                      image: animal.images.isNotEmpty
                          ? NetworkImage(animal.images.first)
                          : const AssetImage(
                              'assets/images/placeholder.png',
                            ) as ImageProvider,
                      errorBuilder: (context, error, stackTrace) => const Image(
                        image: AssetImage('assets/images/placeholder.png'),
                        fit: BoxFit.fitHeight,
                      ),
                      fit: BoxFit.fitHeight,
                    )
                  : CarouselSlider(
                      items:
                          animal.images.map((e) => Image.network(e)).toList(),
                      options: CarouselOptions()),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                elevation: 6.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: theme.backgroundColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        animal.name,
                        style: TextStyle(
                          fontSize: 26.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          animal.type,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        animal.description,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        animal.age,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.genderless,
                            color: Theme.of(context).primaryColor,
                            size: 16.0,
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            animal.gender,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        animal.size,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 50.0,
            padding: const EdgeInsets.symmetric(
              horizontal: 22.0,
              vertical: 30.0,
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Chip(
                  label: Text(
                    animal.tags[index],
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: theme.primaryColor,
                );
              },
              itemCount: animal.tags.length,
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                    isAdopted ? Colors.grey : theme.primaryColor),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
              onPressed: () async {
                // if (!isAdopted) {
                  await adoptedProvider.adoptNew(animal.id);
                  showConfettiDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Adopted!'),
                      content: Text('You have adopted ${animal.name}!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                // }
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  isAdopted ? 'Already Adopted!' : 'Adopt Me!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
