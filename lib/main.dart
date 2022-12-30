import 'package:flutter/material.dart';
import 'package:pet_adoption/src/notifiers/adopted_provider.dart';
import 'package:pet_adoption/src/screens/home.dart';
import 'package:pet_adoption/src/utils/styles.dart';
import 'package:provider/provider.dart';

import 'package:pet_adoption/src/notifiers/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  AdoptedProvider adoptedProvider = AdoptedProvider();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.themePreferences.getTheme();
    adoptedProvider.adoptedPets =
        await adoptedProvider.adoptedPreferences.getAdoptedPets();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkThemeProvider>(
          lazy: false,
          create: (context) => themeChangeProvider,
        ),
        ChangeNotifierProvider<AdoptedProvider>(
          lazy: false,
          create: (context) => adoptedProvider,
        ),
      ],
      child: const HomeCall(),
    );
  }
}

class HomeCall extends StatelessWidget {
  const HomeCall({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pawsitive Match',
      debugShowCheckedModeBanner: false,
      theme: Styles.themeData(
        context.watch<DarkThemeProvider>().darkTheme,
        context,
      ),
      home: const HomeScreen(),
    );
  }
}
