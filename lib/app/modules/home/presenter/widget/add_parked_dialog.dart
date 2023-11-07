import 'package:app_parking/app/common/buttons.dart';
import 'package:app_parking/app/common/colors.dart';
import 'package:app_parking/app/modules/parking/infra/models/truck_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddParkedAlertDialog extends StatefulWidget {
  const AddParkedAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AddParkedAlertDialog> createState() => _AddParkedAlertDialogState();
}

class _AddParkedAlertDialogState extends State<AddParkedAlertDialog> {
  final TextEditingController numberParkedController = TextEditingController();
  final TextEditingController plateTruckController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Adicionar entrada',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: AppColors.greenShadeColor),
      ),
      content: SizedBox(
        height: height * 0.35,
        width: width,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: plateTruckController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    // icon: const Icon(CupertinoIcons.square_list, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Digite a placa do caminhão'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: numberParkedController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Digite o numero da vaga'),
              ),
              const SizedBox(height: 8),
              const Text(
                '*Data e a hora da entrada serão salvos automaticamente',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
      actions: [
        FlatElevatedIconButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          width: MediaQuery.of(context).size.width,
          text: 'Cancelar',
          backgroundColor: Colors.white,
          borderColor: AppColors.blueShadeColor,
          textColor: AppColors.blueShadeColor,
          margin: const EdgeInsets.only(top: 8),
        ),
        FlatElevatedIconButton(
          margin: const EdgeInsets.symmetric(vertical: 8),
          onPressed: () {
            _addTasks(
                truck: Truck(
              numberParked: numberParkedController.text,
              side: '',
              parkedStatus: 'ocupado',
              plateTruck: plateTruckController.text,
              entryTime: '${DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
              departureTime: '',
              id: '',
            ));
            Navigator.of(context, rootNavigator: true).pop();
          },
          width: MediaQuery.of(context).size.width,
          text: 'Salvar',
          backgroundColor: AppColors.blueShadeColor,
          textColor: Colors.white,
        ),
      ],
    );
  }

  Future _addTasks({required Truck truck}) async {
    DocumentReference docRef = await FirebaseFirestore.instance.collection('parking').add(
      {
        'numberParked': truck.numberParked,
        'side': truck.side,
        'parkedStatus': truck.parkedStatus,
        'plateTruck': truck.plateTruck,
        'entryTime': truck.entryTime != null ? truck.entryTime.toString() : '',
        'departureTime': truck.departureTime != null ? truck.departureTime.toString() : '',
      },
    );
    String truckId = docRef.id;
    await FirebaseFirestore.instance.collection('parking').doc(truckId).update(
      {'id': truckId},
    );
    _clearAll();
  }

  void _clearAll() {
    plateTruckController.text = '';
  }
}
