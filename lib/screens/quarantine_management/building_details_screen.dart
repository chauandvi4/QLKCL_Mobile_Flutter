import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qlkcl/models/building.dart';
import 'package:qlkcl/models/floor.dart';
import 'package:qlkcl/models/quarantine.dart';
import 'package:qlkcl/screens/quarantine_management/component/floor_list.dart';
import 'component/general_info_building.dart';
import './edit_building_screen.dart';
import './add_floor_screen.dart';

class BuildingDetailsScreen extends StatefulWidget {
  final Building? currentBuilding;
  final Quarantine? currentQuarantine;
  // final int? id;

  const BuildingDetailsScreen({
    Key? key,
    this.currentBuilding,
    this.currentQuarantine,
  }) : super(key: key);
  static const routeName = '/building-details';
  @override
  _BuildingDetailsScreen createState() => _BuildingDetailsScreen();
}

class _BuildingDetailsScreen extends State<BuildingDetailsScreen> {
  late Future<dynamic> futureFloorList;

  onRefresh() {
    //print('On refresh');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    futureFloorList =
        fetchFloorList({'quarantine_building': widget.currentBuilding!.id});
    print(widget.currentBuilding!.id);

    final appBar = AppBar(
      title: const Text("Thông tin chi tiết tòa"),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditBuildingScreen(
                  currentBuilding: widget.currentBuilding,
                  currentQuarantine: widget.currentQuarantine,
                  onGoBackFloorList: onRefresh,
                ),
              ),
            );
          },
          icon: Icon(Icons.edit),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: FutureBuilder<dynamic>(
            future: futureFloorList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('Snap shot data');
                print(snapshot.data);
                EasyLoading.dismiss();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.25,
                      child: GeneralInfoBuilding(
                        currentQuarantine: widget.currentQuarantine!,
                        currentBuilding: widget.currentBuilding!,
                        numberOfFloor: snapshot.data.length,
                      ),
                    ),
                    Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.75,
                      child: FloorList(
                        data: snapshot.data,
                        currentBuilding: widget.currentBuilding!,
                        currentQuarantine: widget.currentQuarantine!,
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Snapshot has error');
              }
              EasyLoading.show();
              return Container();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFloorScreen(
                currentBuilding: widget.currentBuilding,
                currentQuarantine: widget.currentQuarantine,
                onGoBackFloorList: onRefresh,
              ),
            ),
          );
        },
        //tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
