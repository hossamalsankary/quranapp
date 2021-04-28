import 'package:quranv1/quran_screen/compinents/read_screen.dart';
import 'package:quranv1/widgets.dart/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurahsScreen extends StatefulWidget {
  @override
  _SurahsScreenState createState() => _SurahsScreenState();
}

class _SurahsScreenState extends State<SurahsScreen> {
  _buildQuranList() {
    Map quran = context.read<HoldData>().quran;
    Map tafseer = context.read<HoldData>().tafseer;
    List<Widget> surahsname = [];
    List tafseersurahs = tafseer["data"]["surahs"];
    List surahs = quran["data"]["surahs"];

    for (int i = 0; i < surahs.length; i++) {
      surahsname.add(DecorationSura(
        context: context,
        nameAr: surahs[i]["name"],
        nameEn: surahs[i]["englishNameTranslation"],
        place: surahs[i]["revelationType"],
        suaradata: surahs[i]["ayahs"],
        tafseer: tafseersurahs[i]["ayahs"],
      ));
    }

    return surahsname;
  }

  @override
  Widget build(BuildContext context) {
    _buildQuranList();

    return Container(
      child: ListView(
        children: _buildQuranList(),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget DecorationSura(
    {BuildContext context,
    String nameAr,
    String nameEn,
    String place,
    List suaradata,
    List tafseer}) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Reader(suaradata, tafseer, nameEn, nameAr, context);
        },
      ));
    },
    splashColor: Colors.green,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${nameEn}\n *${place} "),
          Text(
            "$nameAr\n ${place != 'Meccan' ? 'مدني' : 'مكي'} ",
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(3), right: Radius.circular(3)),
      ),
    ),
  );
}
