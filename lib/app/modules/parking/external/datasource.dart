import 'package:app_parking/app/modules/parking/infra/models/truck_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Truck>> getListTruck() async {
    List<Truck> list = [];

    QuerySnapshot querySnapshot = await _firestore.collection('parking').get();

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

      Truck truck = Truck.fromMap(data);
      list.add(truck);
    }

    return list;
  }
}
