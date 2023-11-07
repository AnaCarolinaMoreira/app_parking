import 'package:app_parking/app/modules/historic/presenter/screens/historic_screen.dart';
import 'package:app_parking/app/modules/home/presenter/widget/add_parked_dialog.dart';
import 'package:app_parking/app/modules/parking/presenter/screens/garage_screnn.dart';
import 'package:app_parking/app/modules/parking/presenter/screens/parking_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController(initialPage: 0);
  late int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_selectedIndex == 0 ? 'Estacionamento' : "Histórico"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Icon(_selectedIndex == 0 ? CupertinoIcons.car : CupertinoIcons.square_list),
          ),
        ],
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddParkedAlertDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.brown,
            unselectedItemColor: Colors.black,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
                pageController.jumpToPage(index);
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.car),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_list),
                label: '',
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        key: const Key("pageView"),
        controller: pageController,
        children: const <Widget>[
          Center(
            child: GarageScreen(),
          ),
          Center(
            child: HistoricScreen(),
          ),
        ],
      ),
    );
  }
}
