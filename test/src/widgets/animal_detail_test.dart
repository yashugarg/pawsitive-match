import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:pet_adoption/src/data/animals.dart';
import 'package:pet_adoption/src/notifiers/adopted_provider.dart';
import 'package:pet_adoption/src/screens/animal_detail.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Adopt Pet Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AdoptedProvider>(
            lazy: false,
            create: (context) => AdoptedProvider(),
          ),
        ],
        child: MaterialApp(
          home: Material(
            child: Builder(builder: (BuildContext context) {
              return AnimalDetailScreen(animal: petsData[7]);
            }),
          ),
        ),
      ),
    );

    expect(find.text('Adopt Me!'), findsOneWidget);
    expect(find.text('Already Adopted!'), findsNothing);

    await tester.tap(find.text('Adopt Me!'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('OK'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Adopt Me!'), findsNothing);
    expect(find.text('Already Adopted!'), findsOneWidget);
  });
}
