import 'package:flutter/material.dart';
import 'package:qlkcl/components/cards.dart';
import 'package:qlkcl/models/building.dart';
import 'package:qlkcl/models/floor.dart';
import 'package:qlkcl/models/quarantine.dart';
import 'package:qlkcl/models/room.dart';
import '../room_details_screen.dart';

class RoomList extends StatelessWidget {
  final Quarantine currentQuarantine;
  final Building currentBuilding;
  final Floor currentFloor;
  final data;
  const RoomList(
      {Key? key,
      this.data,
      required this.currentQuarantine,
      required this.currentBuilding,
      required this.currentFloor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('room list');
    print(data);
    return (data == null || data.isEmpty)
        ? Center(
            child: Text('Không có dữ liệu'),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              //last item
              if (index == data.length - 1) {
                return Column(
                  children: [
                    QuarantineRelatedCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoomDetailsScreen(
                              currentBuilding: currentBuilding,
                              currentQuarantine: currentQuarantine,
                              currentFloor: currentFloor,
                              currentRoom: Room.fromJson(data[index]),
                            ),
                          ),
                        );
                      },
                      id: data[index]['id'],
                      name: data[index]['name'],
                      numOfMem: data[index]['num_current_member'],
                      maxMem: data[index]['capacity'],
                    ),
                    SizedBox(height: 70),
                  ],
                );
              } else
                return QuarantineRelatedCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomDetailsScreen(
                          currentBuilding: currentBuilding,
                          currentQuarantine: currentQuarantine,
                          currentFloor: currentFloor,
                          currentRoom: Room.fromJson(data[index]),
                        ),
                      ),
                    );
                  },
                  id: data[index]['id'],
                  name: data[index]['name'],
                  numOfMem: data[index]['num_current_member'],
                  maxMem: data[index]['capacity'],
                );
            },
            itemCount: data.length,
          );
  }
}
