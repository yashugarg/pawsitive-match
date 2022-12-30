import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AdoptedPreferences {
  static const ADOPTED = "ADOPTEDPETS";

  Future<Map> getAdoptedPets({SharedPreferences? pref}) async {
    SharedPreferences prefs = pref ?? (await SharedPreferences.getInstance());
    return jsonDecode(prefs.getString(ADOPTED) ?? "{}");
  }

  Future<Map> adoptNewPet(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map adopted = await getAdoptedPets(pref: prefs);
    adopted[id.toString()] = DateTime.now().toIso8601String();
    prefs.setString(ADOPTED, jsonEncode(adopted));
    return adopted;
  }
}
