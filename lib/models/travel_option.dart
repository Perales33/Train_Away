// Definimos la clase para poder seleccionar los elementos checkbox (Coche cama, Equipaje y Servicio restaurante)
class TravelOption {
  const TravelOption({required this.id, required this.name});

  final String id;
  final String name;
  bool get selected => false;
}
