import 'package:equatable/equatable.dart';

// class Parked extends Equatable {
//   final String numberParked;
//   final String side;
//   String parkedStatus;
//   final Truck? truck;

//   Parked({
//     required this.numberParked,
//     required this.side,
//     required this.parkedStatus,
//     required this.truck,
//   });

//   @override
//   List<Object> get props => [];

//   Map<String, dynamic> toMap() {
//     return {
//       'numberParked': numberParked,
//       'side': side,
//       'parkedStatus': parkedStatus,
//       'truck': truck!.toMap(),
//     };
//   }

//   static Parked fromMap(Map<String, dynamic> map) {
//     return Parked(
//       numberParked: map['numberParked'] ?? '',
//       side: map['side'] ?? '',
//       parkedStatus: map['parkedStatus'] ?? '',
//       truck: Truck.fromMap(map['truck']),
//     );
//   }
// }

class Truck extends Equatable {
  //Parked
  final String numberParked;
  final String side;
  String parkedStatus;
  //truck
  final String plateTruck;
  final String? entryTime; //entrada
  final String? departureTime; //saida
  final String? id;

  Truck({
    //Parked
    required this.numberParked,
    required this.side,
    required this.parkedStatus,
    //truck
    required this.plateTruck,
    required this.entryTime,
    required this.departureTime,
    this.id,
  });

  @override
  List<Object> get props => [];

  Map<String, dynamic> toMap() {
    return {
      'numberParked': numberParked,
      'side': side,
      'parkedStatus': parkedStatus,
      //truck
      'plateTruck': plateTruck,
      'entryTime': entryTime,
      'departureTime': departureTime,
      'id': id,
    };
  }

  static Truck fromMap(Map<String, dynamic> map) {
    return Truck(
      // numberParked: map['numberParked'] != null && map['numberParked'].isNotEmpty ? int.parse(map['numberParked']) : 0,
      numberParked: map['numberParked'] ?? '',
      side: map['side'] ?? '',
      parkedStatus: map['parkedStatus'] ?? '',
      //truck
      plateTruck: map['plateTruck'] ?? '',
      // entryTime: map['entryTime'] != null && map['entryTime'].isNotEmpty ? DateTime.parse(map['entryTime']) : null,
      // departureTime: map['departureTime'] != null && map['departureTime'].isNotEmpty ? DateTime.parse(map['departureTime']) : null,
      entryTime: map['entryTime'] ?? '',
      departureTime: map['departureTime'] ?? '',
      id: map['id'] ?? '',
    );
  }

  // static List<Truck> trucksToList(Map<String, dynamic> map) {
  //   return List.from(map['parking']).map((e) => Truck.fromMap(e)).toList();
  // }
}
