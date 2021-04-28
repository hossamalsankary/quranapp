import 'package:quranv1/quran_screen/plain_screen/readerforplan.dart';
import 'package:quranv1/widgets.dart/provider.dart';
import 'package:quranv1/widgets.dart/reader_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeavelsScreen extends StatefulWidget {
  final HoldData holder;
  final int planLeavels;
  LeavelsScreen({
    this.holder,
    this.planLeavels,
  });
  @override
  _LeavelsScreenState createState() => _LeavelsScreenState();
}

class _LeavelsScreenState extends State<LeavelsScreen> {
  List ayaht = [];
  List tafseer = [];
  int len;

  List handelLeavelsforquran() {
    List leavelnumper = [];
    int div = (len / widget.planLeavels).round();

    if (ayaht.length < div) {
      List tamp = ayaht;
      //ayaht.clear();
      //uli("------------------------------------------------------$tamp");
      return tamp;
    } else {
      leavelnumper = ayaht.getRange(0, div).toList();
      ayaht.removeRange(0, div);
    }
    // print("-------------------$div");
    // print("-------------------${ayaht.length}");
    //  print(leavelnumper.length);
    return leavelnumper;
  }

  List handelleavelsfortafseer() {
    List leavelnumper = [];
    int div = (len / widget.planLeavels).round();

    if (tafseer.length < div) {
      List tamp = tafseer;
      //ayaht.clear();
      //print("------------------------------------------------------$tamp");
      return tamp;
    } else {
      leavelnumper = tafseer.getRange(0, div).toList();
      tafseer.removeRange(0, div);
    }
    print("-------------------$leavelnumper");
    // print("-------------------${ayaht.length}");
    //  print(leavelnumper.length);
    return leavelnumper;
  }

  loobinside() {
    for (int i = 0; i < 30; i++) {
      widget.holder.leavelsforquran.add(handelLeavelsforquran());
      widget.holder.leavelsfortafseer.add(handelleavelsfortafseer());
      // print(len);
      // print(leavels.length);
    }
    // print(leavels);
  }

  @override
  void initState() {
    this.len = widget.holder.holdquran.length;
    this.ayaht = widget.holder.holdquran;
    this.tafseer = widget.holder.holdtafseerdata;
    if (widget.holder.leavelsforquran.isEmpty) {
      loobinside();
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _bulidLeavels() {
      // print(div);
      List<Widget> leavel = [];
      for (int i = 1; i < 31; i++) {
        leavel.add(Padding(
          padding: EdgeInsets.all(15),
          child: Consumer<ReaderProvider>(
            builder: (context, read, child) {
              return InkWell(
                splashColor: Colors.green,
                borderRadius: BorderRadius.circular(30),
                // radius: 100,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReaderForPlan(
                        providerread: read,
                        plainnumper: i - 1,
                        ayahs: widget.holder.leavelsforquran[i - 1],
                        tafseer: widget.holder.leavelsfortafseer[i - 1],
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  child: Text(i.toString()),
                  //  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        ));
      }
      return leavel;
    }

    return Scaffold(
      appBar: AppBar(),
      body: GridView.count(
        crossAxisCount: 3,
        children: _bulidLeavels(),
      ),
    );
  }
}
