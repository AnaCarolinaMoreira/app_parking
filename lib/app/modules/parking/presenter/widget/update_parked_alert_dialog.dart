import 'package:app_parking/app/common/buttons.dart';
import 'package:app_parking/app/common/colors.dart';
import 'package:app_parking/app/modules/parking/infra/models/truck_model.dart';
import 'package:app_parking/app/modules/parking/presenter/widget/checkbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Atualizar',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Text(
              'Hora de entrada: ${widget.truck.entryTime}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              'Hora de saida: ${widget.truck.departureTime}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              'Lado: ${widget.truck.side}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              'vaga: ${widget.truck.numberParked}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            TextFormField(
              controller: plateTruckController,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  icon: const Icon(CupertinoIcons.square_list, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Digite a placa do caminhão'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Flexible(
                    child: RoundCheckbox(
                      value: isCheck,
                      onChanged: () {
                        setState(() {
                          isCheck = !isCheck;
                          widget.truck.parkedStatus = !isCheck ? 'livre' : 'ocupado';
                        });
                      },
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  const Expanded(
                    flex: 5,
                    child: Text(
                      'Ocupado',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            _updateTasks(
              Truck(
                numberParked: widget.truck.numberParked,
                side: widget.truck.side,
                parkedStatus: !isCheck ? 'livre' : 'ocupado',
                plateTruck: widget.truck.plateTruck,
                entryTime: (widget.truck.parkedStatus == 'ocupado' && widget.truck.entryTime!.isEmpty)
                    ? '${DateTime.now().hour}:${DateTime.now().minute} Dia:${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'
                    : '',
                departureTime: (widget.truck.parkedStatus == 'livre' && widget.truck.departureTime!.isEmpty)
                    ? '${DateTime.now().hour}:${DateTime.now().minute} Dia:${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'
                    : '',
              ),
            );
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
          'departureTime': truck.departureTime != null ? truck.departureTime.toString() : '',
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
