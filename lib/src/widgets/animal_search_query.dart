import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_list_manager/flutter_bloc_list_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimalSearchQuery extends StatelessWidget {
  const AnimalSearchQuery({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchQueryCubit, String>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            style: const TextStyle(fontSize: 18.0),
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                gapPadding: 10.0,
              ),
              filled: true,
              fillColor: Theme.of(context).backgroundColor,
              hintText: 'Search pets to adopt',
              prefixIcon: const Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.grey,
              ),
            ),
            textInputAction: TextInputAction.search,
            onChanged: (value) =>
                context.read<SearchQueryCubit>().setQuery(value),
          ),
        );
      },
    );
  }
}
