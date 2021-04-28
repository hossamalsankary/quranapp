import 'dart:convert';

import 'package:quranv1/azkar_screen/showelzakr/showalzekr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AzkarScreen extends StatefulWidget {
  @override
  _AzkarScreenState createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  getazkardata() async {
    String azkar = await rootBundle.loadString("assets/json/azkar.json");
    List azkarlist = List.from(jsonDecode(azkar));
    return azkarlist;
  }

  @override
  void initState() {
    getazkardata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor,
                    blurRadius: 6,
                    offset: Offset(0.8, 0.9),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  SizedBox(),
                  Text(
                    "الاذكار",
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green.withOpacity(0.3),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
              flex: 5,
              child: FutureBuilder(
                future: getazkardata(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List azkar = List.from(snapshot.data);
                    return GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 6,
                      ),
                      itemCount: azkar.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          splashColor: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ShowZkar(
                                    azkar[index]["content"],
                                  ),
                                ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 30),
                              child: Text(
                                azkar[index]["title"].toString(),
                                softWrap: true,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  shadows: [
                                    Shadow(color: Colors.green, blurRadius: 8)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ))
        ],
      ),
    );
  }
}
