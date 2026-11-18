import 'package:train_away/models/stations.dart';
import 'package:train_away/models/travel_category.dart';
import 'package:train_away/models/travel_option.dart';
import 'package:train_away/models/travel_schedule.dart';

class MockService {
  const MockService();

  Future<List<Station>> getStations() async => const [
        // Andalucía
        Station(id: 'almeria', name: 'Estación de Almería'),
        Station(id: 'cadiz', name: 'Estación de Cádiz'),
        Station(id: 'cordoba', name: 'Estación de Córdoba'),
        Station(id: 'granada', name: 'Estación de Granada'),
        Station(id: 'huelva', name: 'Estación de Huelva'),
        Station(id: 'jaen', name: 'Estación de Jaén'),
        Station(id: 'malaga', name: 'Estación de Málaga'),
        Station(id: 'sevilla', name: 'Estación de Sevilla'),

        // Aragón
        Station(id: 'huesca', name: 'Estación de Huesca'),
        Station(id: 'teruel', name: 'Estación de Teruel'),
        Station(id: 'zaragoza', name: 'Estación de Zaragoza'),

        // Asturias
        Station(id: 'oviedo', name: 'Estación de Oviedo'),

        // Cantabria
        Station(id: 'santander', name: 'Estación de Santander'),

        // Castilla-La Mancha
        Station(id: 'albacete', name: 'Estación de Albacete'),
        Station(id: 'ciudad-real', name: 'Estación de Ciudad Real'),
        Station(id: 'cuenca', name: 'Estación de Cuenca'),
        Station(id: 'guadalajara', name: 'Estación de Guadalajara'),
        Station(id: 'toledo', name: 'Estación de Toledo'),

        // Castilla y León
        Station(id: 'avila', name: 'Estación de Ávila'),
        Station(id: 'burgos', name: 'Estación de Burgos'),
        Station(id: 'leon', name: 'Estación de León'),
        Station(id: 'palencia', name: 'Estación de Palencia'),
        Station(id: 'salamanca', name: 'Estación de Salamanca'),
        Station(id: 'segovia', name: 'Estación de Segovia'),
        Station(id: 'soria', name: 'Estación de Soria'),
        Station(id: 'valladolid', name: 'Estación de Valladolid'),
        Station(id: 'zamora', name: 'Estación de Zamora'),

        // Cataluña
        Station(id: 'barcelona', name: 'Estación de Barcelona'),
        Station(id: 'girona', name: 'Estación de Girona'),
        Station(id: 'lleida', name: 'Estación de Lleida'),
        Station(id: 'tarragona', name: 'Estación de Tarragona'),

        // Comunidad Valenciana
        Station(id: 'alicante', name: 'Estación de Alicante'),
        Station(id: 'castellon', name: 'Estación de Castellón'),
        Station(id: 'valencia', name: 'Estación de Valencia'),

        // Extremadura
        Station(id: 'badajoz', name: 'Estación de Badajoz'),
        Station(id: 'caceres', name: 'Estación de Cáceres'),

        // Galicia
        Station(id: 'a-coruna', name: 'Estación de A Coruña'),
        Station(id: 'lugo', name: 'Estación de Lugo'),
        Station(id: 'ourense', name: 'Estación de Ourense'),
        Station(
          id: 'santiago-de-compostela',
          name: 'Estación de Santiago de Compostela',
        ),

        // La Rioja
        Station(id: 'logrono', name: 'Estación de Logroño'),

        // Comunidad de Madrid
        Station(id: 'madrid', name: 'Estación de Madrid'),

        // Navarra
        Station(id: 'pamplona', name: 'Estación de Pamplona'),

        // País Vasco
        Station(id: 'bilbao', name: 'Estación de Bilbao'),
        Station(id: 'donostia', name: 'Estación de Donostia'),
        Station(id: 'vitoria-gasteiz', name: 'Estación de Vitoria-Gasteiz'),

        // Región de Murcia
        Station(id: 'murcia', name: 'Estación de Murcia'),
  ];

  Future<List<TravelCategory>> getCategories() async => const [
    TravelCategory(id: 'first', name: '1ª Clase'),
    TravelCategory(id: 'second', name: '2ª Clase')
  ];

  Future<List<TravelOption>> getTravelOptions() async => const[
    TravelOption(id: 'luggage', name: 'Equipaje'),
    TravelOption(id: 'restaurant', name: 'Servicio restaurante'),
    TravelOption(id: 'bed', name: 'Coche cama')
  ];

  Future<List<TravelSchedule>> getSchedules() async => const [
      TravelSchedule(id: '07-00', time: '07:00'),
      TravelSchedule(id: '09-00', time: '09:00'),
      TravelSchedule(id: '11-00', time: '11:00'),
      TravelSchedule(id: '13-00', time: '13:00'),
      TravelSchedule(id: '15-00', time: '15:00'),
      TravelSchedule(id: '17-00', time: '17:00'),
      TravelSchedule(id: '19-00', time: '19:00'),
      TravelSchedule(id: '21-00', time: '21:00'),
    ];
}