import 'package:flutter/material.dart';
import 'package:untitled2/view/UpdateData.dart';
import 'package:untitled2/view/DeleteData.dart';
import 'package:untitled2/view/GetData.dart';
import 'package:untitled2/view/PostData.dart';


class NavigationModel extends StatefulWidget {
  const NavigationModel({Key? key}) : super(key: key);

  @override
  _NavigationModelState createState() => _NavigationModelState();
}

class _NavigationModelState extends State<NavigationModel> {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text("CarApiFlutter")),
        bottomNavigationBar: const SafeArea(
          child: Material(
            color: Colors.black87,
            child: TabBar(
              labelColor: Colors.red,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.red,
              tabs: [
                Tab(child:Icon(Icons.arrow_downward)),
                Tab(child:Icon(Icons.north_east)),
                Tab(child:Icon(Icons.autorenew)),
                Tab(child:Icon(Icons.delete_forever_outlined))
              ],
            ),
          ),
        ),
        body: const TabBarView(children: [
          GetData(),
          PostData(),
          UpdateData(),
          DeleteData(),
        ],
        ),
      ),
    );
  }
}
