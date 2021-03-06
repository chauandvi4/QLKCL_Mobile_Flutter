import 'package:flutter/material.dart';
import 'package:qlkcl/config/app_theme.dart';

class InfoCovid extends StatelessWidget {
  final Color color;
  final String title;
  final String newCase;
  final String totalCase;
  const InfoCovid(
      {required this.color,
      required this.title,
      required this.newCase,
      required this.totalCase});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 128,
      child: Card(
        color: color,
        margin: EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: CustomColors.white),
              ),
              subtitle: Text(
                "+" + newCase,
                textAlign: TextAlign.center,
                style: TextStyle(color: CustomColors.white),
              ),
            ),
            Text(
              totalCase,
              style: TextStyle(color: CustomColors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCovidHomePage extends StatelessWidget {
  final String increaseConfirmed;
  final String confirmed;
  final String increaseDeaths;
  final String deaths;
  final String increaseRecovered;
  final String recovered;
  final String lastUpdate;

  const InfoCovidHomePage(
      {this.increaseConfirmed: "0",
      this.confirmed: "0",
      this.increaseDeaths: "0",
      this.deaths: "0",
      this.increaseRecovered: "0",
      this.recovered: "0",
      this.lastUpdate: "HH:mm, dd/MM/yyyy"});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        margin: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: InfoCovid(
                color: CustomColors.warning,
                title: "Nhi???m b???nh",
                newCase: increaseConfirmed,
                totalCase: confirmed,
              ),
            ),
            Expanded(
              flex: 3,
              child: InfoCovid(
                color: CustomColors.error,
                title: "T??? vong",
                newCase: increaseDeaths,
                totalCase: deaths,
              ),
            ),
            Expanded(
              flex: 3,
              child: InfoCovid(
                color: CustomColors.success,
                title: "B??nh ph???c",
                newCase: increaseRecovered,
                totalCase: recovered,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          children: [
            Text(
              "C???p nh???t: " + lastUpdate,
              textAlign: TextAlign.left,
            ),
            Spacer(),
            Text(
              "Ngu???n: B??? Y T???"
            ),
          ],
        ),
      ),
    ]);
  }
}
