// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qlkcl/config/app_theme.dart';
import 'package:qlkcl/models/quarantine.dart';

class GeneralInfo extends StatelessWidget {
  final Quarantine currentQuarantine;
  final int numOfBuilding;

  const GeneralInfo({
    required this.currentQuarantine,
    required this.numOfBuilding,
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
              height: 82,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    //mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      Text('Tổng số tòa: $numOfBuilding',
                          style: const TextStyle(
                            fontSize: 16,
                          )),
                    ],
                  ),
                  Column(
                    //mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Đang cách ly',
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
                            '${currentQuarantine.currentMem}' +
                                (currentQuarantine.capacity != null
                                    ? '/${currentQuarantine.capacity}'
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
