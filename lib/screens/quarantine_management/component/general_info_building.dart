import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:qlkcl/config/app_theme.dart';
import 'package:qlkcl/models/building.dart';
import 'package:qlkcl/models/quarantine.dart';

class GeneralInfoBuilding extends StatelessWidget {
  final Quarantine currentQuarantine;
  final Building currentBuilding;
  final int numberOfFloor;
  
  GeneralInfoBuilding({
    required this.currentQuarantine,
    required this.currentBuilding,
    required this.numberOfFloor,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(159, 217, 255, 1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -25,
            left: -80,
            child: SvgPicture.asset('assets/svg/ovaldecoration.svg'),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    //mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentQuarantine.fullName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        currentBuilding.name,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('T???ng s??? t???ng: $numberOfFloor',
                          style: const TextStyle(
                            fontSize: 16,
                          )),
                    ],
                  ),
                  Column(
                    //mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        '??ang c??ch ly',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.groups_rounded,
                            size: 20,
                            color: CustomColors.primaryText,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${currentBuilding.currentMem}' +
                                (currentBuilding.capacity != null
                                    ? '/${currentBuilding.capacity}'
                                    : '/0'),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
