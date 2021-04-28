import 'dart:convert';

import 'package:quranv1/compinents/default_button.dart';
import 'package:quranv1/widgets.dart/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isdone = false;
  getdatafronhttp() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var response =
        await http.get('http://localhost:1337/restaurants', headers: headers);

    print(response.body);
  }

  handelData() async {
    Map<String, dynamic> data = Map();
    try {
      String stafseer = await rootBundle.loadString("assets/json/tafseer.json");
      String squran = await rootBundle.loadString("assets/json/quran.json");
      // decode data
      Map quran = Map.from(jsonDecode(squran));
      Map tafseer = Map.from(jsonDecode(stafseer));
      data = {"quran": quran, "tafseer": tafseer};

      return data;
    } catch (e) {
      print(e);
    }
  }

  planList() {
    // ignore: unnecessary_statements
    List surahs = context.read<HoldData>().quran["data"]["surahs"];
    List tafseer = context.read<HoldData>().tafseer["data"]["surahs"];
    List hildtafsser = [];
    List holdayahs = [];
    // print(surahs);
    surahs.forEach((map) {
      Map surah = map;
      List ayahs = surah["ayahs"];
      String surahname = surah["name"];
      holdayahs.add(surahname);
      ayahs.forEach((ayah) {
        holdayahs.add(ayah["text"]);
      });
    });
    tafseer.forEach((map) {
      Map tafsser = map;
      List ayahs = tafsser["ayahs"];
      String surahname = tafsser["name"];
      hildtafsser.add(surahname);
      ayahs.forEach((ayah) {
        hildtafsser.add(ayah["text"]);
      });
    });
    context.read<HoldData>().holdtafseerdata = hildtafsser;
    context.read<HoldData>().holdquran = holdayahs;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdatafronhttp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: handelData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var decode = Map.from(snapshot.data);
          context.select((HoldData holddata) {
            holddata.addData(
                quran: decode["quran"],
                tafseer: decode["tafseer"],
                azkar: decode["azkar"]);
          });
          planList();
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg0.jpg"),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.yellow, BlendMode.modulate),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: DefaultButton(
                          width: 200.0,
                          color: Colors.transparent,
                          text: "خاتم  القران  الكريم",
                          press: () {
                            Navigator.pushNamed(context, "/home");
                          },
                        ),
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.yellow.withOpacity(0.2)
                  ])),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg0.jpg"),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.yellow, BlendMode.modulate),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.yellow.withOpacity(0.2)
                  ])),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
