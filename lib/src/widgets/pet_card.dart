import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pet_adoption/src/models/animal.dart';
import 'package:pet_adoption/src/screens/animal_detail.dart';

class PetCard extends StatelessWidget {
  const PetCard({
    Key? key,
    required this.animal,
    required this.disabled,
  }) : super(key: key);

  final Animal animal;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AnimalDetailScreen(animal: animal);
        }));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
                height: 190.0,
                child: disabled
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Tooltip(
                            message: 'Already Adopted',
                            child: Icon(
                              FontAwesomeIcons.circleCheck,
                              size: 20.0,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ),
              Hero(
                tag: animal.name,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  height: 220.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.0),
                    ),
                  ),
                  child: Image(
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
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
              color: theme.backgroundColor,
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  animal.name,
                  style: TextStyle(
                    fontSize: 26.0,
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  '${animal.age} ${animal.type}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.genderless,
                      color: theme.primaryColor,
                      size: 16.0,
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      animal.gender,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  animal.size,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
