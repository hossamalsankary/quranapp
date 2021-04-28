import 'package:quranv1/quran_screen/plain_screen/LeavelsScreen.dart';
import 'package:quranv1/widgets.dart/provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PlainScreen extends StatefulWidget {
  @override
  _PlainScreenState createState() => _PlainScreenState();
}

class _PlainScreenState extends State<PlainScreen> {
  List<String> plandata = [
    "  ختم القران \n مره في الشهر",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).bottomAppBarColor.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 12,
                      color: Theme.of(context).primaryColor,
                      spreadRadius: 12)
                ]),
            child: Center(
              child: Text(
                " خطة ختم القران",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ),
        ),
        //  Expanded(child: SizedBox()),
        Consumer<HoldData>(
          builder: (context, hold, child) {
            return Expanded(
              flex: 11,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => LeavelsScreen(
                                holder: hold,
                                planLeavels: 30,
                              )));
                },
                splashColor: Colors.green,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    plandata[0],
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  width: double.infinity,
                  // height: 200,
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor),
                  // child: Text(
                  //   index.toString(),
                  // ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
