import 'package:app_parking/app/common/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoricScreen extends StatefulWidget {
  const HistoricScreen({super.key});

  @override
  State<HistoricScreen> createState() => _HistoricScreenState();
}

class _HistoricScreenState extends State<HistoricScreen> {
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('parking').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('Nada por aqui :(');
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return Container(
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadowColor,
                        blurRadius: 5.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text('Placa do caminhao: ${data['plateTruck'] ?? ''}'),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Horário de entrada: ${data['entryTime'] ?? ''}'),
                        Text('Horário de saída: ${data['exitTime'] ?? ''}'),
                      ],
                    ),
                    isThreeLine: true,
                    dense: true,
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
