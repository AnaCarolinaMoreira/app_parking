import 'package:app_parking/app/common/colors.dart';
import 'package:app_parking/app/modules/parking/infra/models/truck_model.dart';
import 'package:app_parking/app/modules/parking/presenter/widget/update_parked_alert_dialog.dart';
import 'package:flutter/material.dart';

class myCard extends StatefulWidget {
  final Truck truck;
  final int? number;

  const myCard({super.key, required this.truck, this.number});

  @override
  State<myCard> createState() => _myCardState();
}

class _myCardState extends State<myCard> {
  @override
  Widget build(BuildContext context) {
    bool isBusy = widget.truck.parkedStatus == 'livre' || widget.truck.parkedStatus.isEmpty ? false : true;

    return widget.truck.parkedStatus == 'livre'
        ? SizedBox()
        : InkWell(
            onTap: () {
              // setState(() {
              //   isBusy = !isBusy;
              // });
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return UpdateParkedAlertDialog(truck: widget.truck);
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getBody(title: 'Placa do caminhao:', body: widget.truck.plateTruck ?? ''),
                  getBody(title: 'Número da vaga:', body: widget.truck.numberParked ?? ''),
                  getBody(title: 'Entrada:', body: widget.truck.entryTime ?? ''),
                ],
              ),
            ),
          );
  }
}

Widget getBody({required String title, required String body}) {
  return Row(
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 16, color: AppColors.body, fontWeight: FontWeight.w700),
      ),
      Text(
        body,
        style: const TextStyle(fontSize: 16, color: AppColors.body, fontWeight: FontWeight.w400),
      ),
    ],
  );
}
