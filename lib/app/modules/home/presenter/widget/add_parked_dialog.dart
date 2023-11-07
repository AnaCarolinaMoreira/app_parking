import 'package:app_parking/app/modules/parking/infra/models/truck_model.dart';
import 'package:app_parking/app/modules/parking/infra/models/truck_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddParkedAlertDialog extends StatefulWidget {
  // final Truck truck;
  const AddParkedAlertDialog({
    Key? key,
    // required this.truck,
  }) : super(key: key);

  @override
  State<AddParkedAlertDialog> createState() => _AddParkedAlertDialogState();
}

class _AddParkedAlertDialogState extends State<AddParkedAlertDialog> {
  //vaga
  // final TextEditingController numberParkedController = TextEditingController();
  final List<String> sideTag = ['A', 'B'];
  String selectedValue = '';

//caminhao
  final TextEditingController plateTruckController = TextEditingController();
  // String inputTime = '';
  // String exitTime = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Adicionar vagas ao estacionamento',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.brown),
      ),
      content: SizedBox(
        height: height * 0.35,
        width: width,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Selecione o lado que deseja adicionar\n a vagas sera adicionada\n ao lado A ou labo B',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Row(
                children: <Widget>[
                  const Icon(CupertinoIcons.tag, color: Colors.brown),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Selecione lado A ou labo B',
                        style: TextStyle(fontSize: 14),
                      ),
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      validator: (value) => value == null ? 'Por favor selecione um lado' : null,
                      items: sideTag
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) => setState(
                        () {
                          if (value != null) selectedValue = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: selectedValue.isNotEmpty
              ? () {
                  _addTasks(
                      truck: Truck(numberParked: '', side: selectedValue, parkedStatus: 'livre', plateTruck: '', entryTime: DateTime.now.toString(), departureTime: null, id: ''));
                  Navigator.of(context, rootNavigator: true).pop();
                }
              : null,
          child: const Text('Save'),
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
        'entryTime': truck.entryTime.toString(),
        'exitTime': truck.departureTime.toString(),
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
