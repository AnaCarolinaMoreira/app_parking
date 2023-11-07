import 'package:app_parking/app/modules/parking/infra/models/truck_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateParkedAlertDialog extends StatefulWidget {
  final Truck truck;

  const UpdateParkedAlertDialog({Key? Key, required this.truck}) : super(key: Key);

  @override
  State<UpdateParkedAlertDialog> createState() => _UpdateParkedAlertDialogState();
}

class _UpdateParkedAlertDialogState extends State<UpdateParkedAlertDialog> {
  final TextEditingController plateTruckController = TextEditingController();
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    plateTruckController.text = widget.truck.plateTruck;
    isCheck = (widget.truck.parkedStatus == 'livre' || widget.truck.parkedStatus.isEmpty) ? false : true;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      scrollable: true,
      title: Text(
        !isCheck ? 'atualizar' : 'Adicionar',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, color: Colors.brown),
      ),
      content: SizedBox(
        height: height * 0.35,
        width: width,
        child: Form(
          child: Column(
            children: <Widget>[
              Text(
                'Hora de entrada: ${widget.truck.entryTime}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.brown),
              ),
              Text(
                'Hora de saida: ${widget.truck.departureTime}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.brown),
              ),
              Text(
                'Lado: ${widget.truck.side}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.brown),
              ),
              Text(
                'vaga: ${widget.truck.numberParked}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.brown),
              ),
              TextFormField(
                controller: plateTruckController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    icon: const Icon(CupertinoIcons.square_list, color: Colors.brown),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Digite a placa do caminhao'),
              ),
              Row(
                children: [
                  Checkbox(
                      value: isCheck,
                      onChanged: (e) {
                        setState(() {
                          isCheck = !isCheck;
                          widget.truck.parkedStatus = !isCheck ? 'livre' : 'ocupado';
                        });
                      }),
                  const Text(
                    'Ocupado',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.brown),
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
          // style: ElevatedButton.styleFrom(
          //   primary: Colors.grey,
          // ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            _updateTasks(
              Truck(
                numberParked: widget.truck.numberParked,
                side: widget.truck.side,
                parkedStatus: !isCheck ? 'livre' : 'ocupado',
                plateTruck: widget.truck.plateTruck,
                entryTime: widget.truck.entryTime,
                departureTime: (isCheck && plateTruckController.text.isNotEmpty) ? DateTime.now.toString() : null,
              ),
            );
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text('Adicionar'),
        ),
      ],
    );
  }

  Future _updateTasks(Truck truck) async {
    var collection = FirebaseFirestore.instance.collection('parking');
    collection
        .doc(widget.truck.id)
        .update({
          'numberParked': truck.numberParked,
          'side': truck.side,
          'parkedStatus': truck.parkedStatus,
          'plateTruck': truck.plateTruck,
          'entryTime': truck.entryTime != null ? truck.entryTime.toString() : '',
          'departureTime': truck.entryTime != null ? truck.departureTime.toString() : '',
        })
        .then(
          (_) => Fluttertoast.showToast(
              msg: "Task updated successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 14.0),
        )
        .catchError(
          (error) => Fluttertoast.showToast(
              msg: "Failed: $error", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.SNACKBAR, backgroundColor: Colors.black54, textColor: Colors.white, fontSize: 14.0),
        );
  }
}
