import 'package:app_parking/app/common/colors.dart';
import 'package:app_parking/app/modules/parking/infra/models/truck_model.dart';
import 'package:app_parking/app/modules/parking/presenter/widget/my_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GarageScreen extends StatefulWidget {
  const GarageScreen({super.key});

  @override
  State<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('parking').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('nada por aqui :(');
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                Truck truck = Truck.fromMap(data);

                return myCard(truck: truck);
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
