import 'package:flutter/foundation.dart';

import 'package:pet_adoption/src/utils/adopted_preferences.dart';

class AdoptedProvider with ChangeNotifier {
  AdoptedPreferences adoptedPreferences = AdoptedPreferences();
  Map _adoptedPets = {};

  Map get adoptedPets => _adoptedPets;

  set adoptedPets(Map value) {
    _adoptedPets = value;
    notifyListeners();
  }

  Future<void> adoptNew(int value) async {
    if (_adoptedPets[value.toString()] == null) {
      _adoptedPets = await adoptedPreferences.adoptNewPet(value);
      notifyListeners();
    }
  }
}
