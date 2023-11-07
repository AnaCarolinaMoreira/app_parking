// import 'package:app_parking/app/modules/parking/external/datasource.dart';
// import 'package:app_parking/app/modules/parking/infra/models/truck_model.dart';
// import 'package:app_parking/app/modules/parking/presenter/widget/my_card.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class ParkingScreen extends StatefulWidget {
//   const ParkingScreen({super.key});

//   @override
//   State<ParkingScreen> createState() => _ParkingScreenState();
// }

// class _ParkingScreenState extends State<ParkingScreen> {
//   // ParkingDataSource dataSource = ParkingDataSource();
//   // List<Truck> list = [];
//   // void teste() async {
//   //   list = await dataSource.getListTruck();
//   // }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // teste();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         // physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: list.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Padding(
//                       padding: const EdgeInsets.all(24),
//                       child: Column(
//                         children: [
//                           list.first.side == 'A'
//                               ? const Text(
//                                   'A',
//                                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                                 )
//                               : SizedBox(),
//                           list[index].side == 'A'
//                               ? Wrap(
//                                   children: [
//                                     myCard(
//                                       truck: list[index],
//                                       number: index + 1,
//                                     ),
//                                   ],
//                                 )
//                               : SizedBox(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           );
//         });
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return SingleChildScrollView(
//   //     child: Column(
//   //       children: [
//   //         const Text(
//   //           'Estacionamento',
//   //           style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
//   //           textAlign: TextAlign.center,
//   //         ),
//   //         Row(
//   //           children: [
//   //             Expanded(
//   //               flex: 1,
//   //               child: Padding(
//   //                 padding: const EdgeInsets.all(24),
//   //                 child: Column(
//   //                   children: [
//   //                     const Text(
//   //                       'A',
//   //                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//   //                     ),
//   //                     Wrap(
//   //                       children: List.generate(
//   //                         15,
//   //                         (index) => CreateParkingSpot(
//   //                           numberParked: 'A${index + 1}',
//   //                           side: 'A',
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ),
//   //             ),
//   //             Expanded(
//   //               flex: 1,
//   //               child: Padding(
//   //                 padding: const EdgeInsets.all(24),
//   //                 child: Column(
//   //                   children: [
//   //                     const Text(
//   //                       'B',
//   //                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//   //                     ),
//   //                     Wrap(
//   //                       children: List.generate(
//   //                         15,
//   //                         (index) => CreateParkingSpot(
//   //                           numberParked: 'B${index + 1}',
//   //                           side: 'B',
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
// }
