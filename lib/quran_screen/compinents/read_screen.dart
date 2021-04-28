import 'dart:async';

import 'package:quranv1/widgets.dart/provider.dart';
import 'package:quranv1/widgets.dart/reader_provider.dart';
import 'package:quranv1/widgets.dart/tafseerdailog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Reader extends StatefulWidget {
  final String enname;
  final String arname;

  final List surahdata;
  final List tafseer;

  final BuildContext context;
  Reader(this.surahdata, this.tafseer, this.enname, this.arname, this.context);
  _ReaderState createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
  ScrollController _controler = ScrollController();
  BuildContext context;
  bool isdone = false;
  bool scroll = false;

  autoScroll(speed) {
    var read = widget.context.read<ReaderProvider>();

    if (read.postions.isEmpty || !(read.postions.containsKey(widget.enname))) {
      read.postions.addAll({widget.enname: 0});
    } else {
      if (read.postions[widget.enname].currentContext != null) {
        RenderBox cox =
            read.postions[widget.enname].currentContext.findRenderObject();
        cox.showOnScreen(
          descendant: RenderObject.debugActiveLayout,
          duration: Duration(seconds: speed),
          curve: Curves.ease,
        );
      }

      print("done");
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
    context = this.context;
    return Consumer<ReaderProvider>(
      builder: (context, read, child) {
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
              autoScroll(context.read<HoldData>().speed);
            },
          ),
          body: CustomScrollView(
            physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            controller: _controler,
            slivers: <Widget>[
              Consumer<HoldData>(
                builder: (context, holder, child) {
                  return SliverAppBar(
                    forceElevated: true,
                    floating: true,
                    // pinned: true,
                    title: Text(widget.arname),
                    centerTitle: true,

                    actions: <Widget>[
                      IconButton(
                        padding: EdgeInsets.only(left: 28),
                        icon: Text(
                          "-",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 35),
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
                  );
                },
              ),
              SliverAnimatedList(
                itemBuilder: (context, index, animation) {
                  //  print(_controler.positions);
                  return Consumer<ReaderProvider>(
                    builder: (context, read, child) {
                      //   print(read.postions);
                      // if (read.offsets.contains(_controler.offset)) {

                      //}
                      //(read.postions);
                      return AyahContainer(
                        curentayah: context.read<ReaderProvider>().ayahindex,
                        ayah: widget.surahdata[index]["text"],
                        tafseer: widget.tafseer[index]["text"],
                        index: index,
                        providerdata: read,
                        enname: widget.enname,
                        isdone: isdone,
                        onpress: () {
                          // print(read.offsets[index]);
                          read.inc(index);
                        },
                      );
                    },
                  );
                },
                initialItemCount: widget.surahdata.length,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controler.dispose();
    super.dispose();
  }
}

class AyahContainer extends StatefulWidget {
  final int index;
  final ReaderProvider providerdata;
  final String ayah;
  final String tafseer;
  final bool sajda;
  final int curentayah;
  final Function onpress;
  final bool isdone;
  final enname;
  AyahContainer(
      {this.curentayah,
      this.index,
      this.ayah,
      this.tafseer,
      this.providerdata,
      this.sajda = false,
      this.onpress,
      this.enname,
      this.isdone});

  @override
  _AyahContainerState createState() => _AyahContainerState();
}

class _AyahContainerState extends State<AyahContainer> {
  Color unselectcolor = Colors.white, selectcolor = Colors.green;
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    context.select((ReaderProvider read) {
      read.postions[widget.enname] = _globalKey;
    });
    return Consumer<HoldData>(
      builder: (context, hold, child) {
        return Container(
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
                  padding: EdgeInsets.all(7),
                  height: 50,
                  width: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.green,
                        child: Icon(Icons.share),
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/full.jpg",
                        ),
                        child: Text("${widget.index}"),
                      ),
                      Icon(Icons.bookmark),
                      IconButton(
                        icon: Icon(Icons.read_more),
                        onPressed: () {
                          showTafseer(context, widget.tafseer);
                        },
                        splashColor: Colors.green,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                key: _globalKey,
                onLongPress: () {
                  showTafseer(context, widget.tafseer);
                },
                onTap: () {
                  widget.onpress();
                  // final RenderBox ref =
                  //     _globalKey.currentContext.findRenderObject();
                  // print(ref.localToGlobal(Offset.zero));
                  // print(widget.providerdata.heights);
                  // print(context.size.height);
                },
                child: Padding(
                  padding: EdgeInsets.all(1),
                  child: Text(
                    "${widget.ayah} ",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: 4,
                        height: 2,
                        fontWeight: hold.fontWight,
                        fontSize: hold.fontSize,
                        color: widget.index == widget.curentayah
                            ? selectcolor
                            : unselectcolor),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
