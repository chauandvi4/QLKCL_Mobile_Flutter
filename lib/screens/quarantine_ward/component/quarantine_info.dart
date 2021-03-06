import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qlkcl/models/quarantine.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:qlkcl/config/app_theme.dart';
import 'carousel.dart';
import 'carousel_building.dart';
import 'package:url_launcher/url_launcher.dart';

class QuarantineInfo extends StatefulWidget {
  final Quarantine quarantineInfo;
  final VoidCallback onGoBack;
  //final String? id;
  const QuarantineInfo({
    Key? key,
    required this.quarantineInfo,
    required this.onGoBack,
  }) : super(key: key);

  @override
  _QuarantineInfoState createState() => _QuarantineInfoState();
}

class _QuarantineInfoState extends State<QuarantineInfo> {
  late Future<dynamic> futureBuildingList;

  @override
  void initState() {
    super.initState();
    print(widget.quarantineInfo.id.toString());
    futureBuildingList =
        fetchBuildingList({'quarantine_ward': widget.quarantineInfo.id});
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  Widget buildInformation(BuildContext context, IconData icon, String info) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: 14,
          ),
          children: [
            WidgetSpan(
              child: Icon(
                icon,
                size: 16,
                color: CustomColors.secondaryText,
              ),
            ),
            TextSpan(
              text: info,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Carousel(),
          SizedBox(
            height: 10,
          ),
          //Name and icon
          Container(
            margin: EdgeInsets.only(
              left: 23,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              //Name
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.quarantineInfo.fullName,
                        //quarantineName!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        (widget.quarantineInfo.address != null
                                ? "${widget.quarantineInfo.address}, "
                                : "") +
                            (widget.quarantineInfo.ward != null
                                ? "${widget.quarantineInfo.ward['name']}, "
                                : "") +
                            (widget.quarantineInfo.district != null
                                ? "${widget.quarantineInfo.district['name']}, "
                                : "") +
                            (widget.quarantineInfo.city != null
                                ? "${widget.quarantineInfo.city['name']}, "
                                : ""),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Color.fromRGBO(138, 149, 158, 1),
                        ),
                      ),
                    ],
                  ),
                ),

                //Button
                Row(
                  children: [
                    IconButton(
                      iconSize: 38,
                      onPressed: widget.quarantineInfo.phoneNumber != null
                          ? () async {
                              launch("tel://" +
                                  widget.quarantineInfo.phoneNumber.toString());
                            }
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('S??? ??i???n tho???i kh??ng t???n t???i.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                      icon: WebsafeSvg.asset("assets/svg/Phone.svg"),
                    ),
                    IconButton(
                        iconSize: 38,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('???ng d???ng ch??a h??? tr??? ch???c n??ng n??y.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: WebsafeSvg.asset("assets/svg/Location.svg"))
                  ],
                ),
              ],
            ),
          ),

          FutureBuilder<dynamic>(
            future: futureBuildingList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                EasyLoading.dismiss();
                return CarouselBuilding(
                  onGoBack: widget.onGoBack,
                  data: snapshot.data,
                  currentQuarantine: widget.quarantineInfo,
                );
              } else if (snapshot.hasError) {
                return Text('Snapshot has error');
              }
              EasyLoading.show();
              return Container();
            },
          ),

          //Information
          Container(
            width: MediaQuery.of(context).size.width * 1,
            margin: EdgeInsets.only(left: 23, right: 23, top: 20, bottom: 8),
            child: Wrap(
              direction: Axis.vertical, // make sure to set this
              spacing: 4, // set
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 15,
                    bottom: 10,
                  ),
                  child: Text(
                    'Th??ng tin',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                buildInformation(
                    context,
                    Icons.history,
                    ' Th???i gian c??ch ly: ' +
                        widget.quarantineInfo.quarantineTime.toString()),
                buildInformation(
                    context,
                    Icons.groups_rounded,
                    ' ??ang c??ch ly: ' +
                        widget.quarantineInfo.currentMem.toString()),
                // ' ??ang c??ch ly: ${thisQuarantine.numOfMem}'),
                buildInformation(
                    context,
                    Icons.account_box_outlined,
                    ' Qu???n l??: ' +
                        widget.quarantineInfo.mainManager["full_name"]),

                buildInformation(
                  context,
                  Icons.place_outlined,
                  ' ?????a ch???: ' +
                      (widget.quarantineInfo.address != null
                          ? "${widget.quarantineInfo.address}, "
                          : "") +
                      (widget.quarantineInfo.ward != null
                          ? "${widget.quarantineInfo.ward['name']}, "
                          : "") +
                      (widget.quarantineInfo.district != null
                          ? "${widget.quarantineInfo.district['name']}, "
                          : "") +
                      (widget.quarantineInfo.city != null
                          ? "${widget.quarantineInfo.city['name']}, "
                          : ""),
                ),

                buildInformation(
                    context,
                    Icons.phone,
                    ' S??? ??i???n tho???i: ' +
                        (widget.quarantineInfo.phoneNumber != null
                            ? widget.quarantineInfo.phoneNumber!
                            : 'Ch??a c??')),

                buildInformation(context, Icons.email_outlined,
                    ' Email: ' + widget.quarantineInfo.email),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
