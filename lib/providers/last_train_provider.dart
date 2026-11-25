import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LastTrainProvider extends ChangeNotifier {
  static const String _claveOrigen = 'last_train_origen';
  static const String _claveDestino = 'last_train_destino';

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  String? _origen;
  String? _destino;

  String? get origen => _origen;
  String? get destino => _destino;
  bool get lastTrain => _origen != null && _destino != null;

  Future<void> charge() async {
    _origen = await _preferences.getString(_claveOrigen);
    _destino = await _preferences.getString(_claveDestino);
    notifyListeners();
  }

  Future<void> save({
    required String origen,
    required String destino
  }) async {
    await _preferences.setString(_claveOrigen, origen);
    await _preferences.setString(_claveDestino, destino);

    _origen = origen;
    _destino = destino;
    notifyListeners();
  }
}