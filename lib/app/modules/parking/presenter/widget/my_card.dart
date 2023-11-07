import 'package:app_parking/app/modules/parking/infra/models/truck_model.dart';
import 'package:app_parking/app/modules/home/presenter/widget/add_parked_dialog.dart';
import 'package:app_parking/app/modules/parking/presenter/widget/update_parked_alert_dialog.dart';
import 'package:flutter/material.dart';

class myCard extends StatefulWidget {
  // final String numberParked;
  // final String side;
  final Truck truck;
  final int? number;

  const myCard({super.key, /* required this.numberParked, required this.side, */ required this.truck, this.number});

  @override
  State<myCard> createState() => _myCardState();
}

class _myCardState extends State<myCard> {
  @override
  Widget build(BuildContext context) {
    bool isBusy = widget.truck.parkedStatus == 'livre' || widget.truck.parkedStatus.isEmpty ? false : true;

    return InkWell(
      onTap: () {
        setState(() {
          isBusy = !isBusy;
          // isBusy ? widget.truck.parkedStatus = 'livre' : widget.truck.parkedStatus = 'ocupada';
          // isBusy = widget.truck.parkedStatus == 'livre' ? false : true;
          // widget.truck.parkedStatus == 'livre' || widget.truck.parkedStatus.isEmpty ? false : true;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return UpdateParkedAlertDialog(truck: widget.truck);
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: isBusy ? Colors.red : Colors.green, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Text('${widget.truck.side}${widget.number ?? ''}'),
      ),
    );
  }
}
