import 'dart:async';

import 'package:quranv1/widgets.dart/provider.dart';
import 'package:quranv1/widgets.dart/reader_provider.dart';
import 'package:quranv1/widgets.dart/tafseerdailog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReaderForPlan extends StatefulWidget {
  final ReaderProvider providerread;
  final List ayahs;
  final List tafseer;
  final int plainnumper;

  ReaderForPlan(
      {this.providerread, this.ayahs, this.tafseer, this.plainnumper});
  @override
  _ReaderForPlanState createState() => _ReaderForPlanState();
}

class _ReaderForPlanState extends State<ReaderForPlan> {
  bool scroll = false;
  autoScroll(speed) {
    var read = widget.providerread;

    if (read.postionsforplain.isEmpty ||
        !(read.postionsforplain.containsKey(widget.plainnumper))) {
      read.postionsforplain.addAll({widget.plainnumper: 0});
    } else {
      if (read.postionsforplain[widget.plainnumper].currentContext != null) {
        RenderBox cox = read.postionsforplain[widget.plainnumper].currentContext
            .findRenderObject();

        cox.showOnScreen(
          descendant: RenderObject.debugActiveLayout,
          duration: Duration(seconds: speed),
          curve: Curves.ease,
        );
      }

      if (scroll) {
        Timer(Duration(seconds: speed), () => autoScroll(speed));
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var holder = context.read<HoldData>();
    var read = context.read<ReaderProvider>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        child: Icon(
          Icons.arrow_downward,
          color: scroll ? Colors.green : Colors.red,
        ),
        onPressed: () {
          setState(() {
            scroll = !scroll;
          });
          autoScroll(holder.speed);
        },
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Text(
              "-",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 35),
            ),
            iconSize: 30.0,
            onPressed: () {
              holder.decfont();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 30.0,
            onPressed: () {
              holder.incfont();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.ayahs.length,
        itemBuilder: (context, index) {
          // return Container(
          //   child: SelectableText(
          //     widget.ayahs[index],
          //     textDirection: TextDirection.rtl,
          //     style: TextStyle(
          //         fontSize: widget.ayahs[index].toString().contains("سورة")
          //             ? 30
          //             : 20),
          //   ),
          // );
          return ReadContainer(
            ayah: widget.ayahs[index],
            tafseer: widget.tafseer[index],
            font: 20,
            index: index,
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ReadContainer(
      {double font = 20, int index, String ayah, String tafseer}) {
    GlobalKey _globalKey = GlobalKey();

    return Consumer<ReaderProvider>(
      builder: (context, read, child) {
        context.select((ReaderProvider read) {
          read.postionsforplain[widget.plainnumper] = _globalKey;
        });
        return InkWell(
          key: _globalKey,
          onTap: () {
            // widget.onpress();
            // final RenderBox ref = _globalKey.currentContext.findRenderObject();
            // print(ref.localToGlobal(Offset.zero));
            // print(widget.providerdata.heights);
            // print(context.size.height);
          },
          child: InkWell(
            splashColor: Colors.green,
            onLongPress: () {
              showTafseer(context, tafseer);
            },
            child: Container(
              //height: MediaQuery.of(context).size.height / 6,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              //alignment: ayahlen <= 70 ? Alignment.center : Alignment.topLeft,
              padding: EdgeInsets.only(top: 0, bottom: 40, left: 20, right: 20),
              margin: EdgeInsets.symmetric(vertical: 1),
              child: Wrap(
                //crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.height / 3.2,
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).backgroundColor.withOpacity(0.1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.share),
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/images/full.jpg",
                            ),
                            child: Text("$index"),
                          ),
                          Icon(Icons.bookmark),
                          IconButton(
                              icon: Icon(Icons.read_more),
                              onPressed: () {
                                showTafseer(context, tafseer);
                              })
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 15),
                    child: Wrap(
                      children: [
                        Consumer<HoldData>(
                          builder: (context, hold, child) {
                            return Text(
                              "$ayah",
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                letterSpacing: 2,
                                height: 2,
                                fontSize: hold.fontSize,
                                fontWeight: ayah.contains("سورة")
                                    ? FontWeight.w900
                                    : hold.fontWight,
                              ),
                            );
                          },
                        ),
                        if (index == 211)
                          InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(top: 25),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 70,
                              child: Text("Done"),
                            ),
                          )
                        else
                          SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
