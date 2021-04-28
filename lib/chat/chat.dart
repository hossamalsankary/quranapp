import 'dart:async';
import 'dart:math';

import 'package:quranv1/widgets.dart/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Chat extends StatefulWidget {
  final HoldData hold;
  Chat(this.hold);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
// confirm chat maind
//get all data
  ScrollController _scrollcontroler = ScrollController();
  TextEditingController _controler = TextEditingController();

  delaytogo(int time) {
    Timer(Duration(milliseconds: time), () {
      _scrollcontroler.animateTo(_scrollcontroler.position.maxScrollExtent,
          duration: Duration(milliseconds: 100), curve: Curves.easeIn);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chatMaind() {
      List quranData = widget.hold.holdquran;
      int randm = Random().nextInt(quranData.length);
      return quranData[randm];
      // print(quranData);
    }

    String ayah = chatMaind();
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: CircleAvatar(
            radius: 100,
            child: Container(
              child: Stack(
                children: [
                  Positioned(
                    top: 2,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(
                          100,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            backgroundImage: AssetImage(
              "assets/images/full.jpg",
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 12,
              child: ListView.builder(
                //reverse: true,

                controller: _scrollcontroler,
                // addAutomaticKeepAlives: true,
                shrinkWrap: true,
                itemCount: widget.hold.fakedata.length,
                itemBuilder: (context, index) {
                  // print(val);
                  // widget.hold.fakedata = widget.hold.fakedata.reversed.toList();

                  return Container(
                    margin: EdgeInsets.only(top: 10, left: 7, right: 3),
                    alignment: widget.hold.fakedata[index]["isq"] == true
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    decoration: BoxDecoration(),
                    child: OpcityEffect(
                      time: 1000,
                      child: Material(
                        animationDuration: Duration(milliseconds: 2),
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(45),
                          topLeft: widget.hold.fakedata[index]["isq"] == true
                              ? Radius.circular(50)
                              : Radius.circular(0),
                          topRight: widget.hold.fakedata[index]["isq"] == true
                              ? Radius.circular(0)
                              : Radius.circular(50),
                          bottomRight:
                              widget.hold.fakedata[index]["isq"] == true
                                  ? Radius.circular(45)
                                  : Radius.circular(30),
                        ),
                        elevation: 40,
                        shadowColor: Colors.black,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        borderOnForeground: true,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            widget.hold.fakedata[index]["text"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                            softWrap: true,
                            overflow: TextOverflow.clip,

                            // style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
          Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 2,
                      child: RotatedBox(
                        quarterTurns: 30,
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            size: 30,
                          ),
                          onPressed: () {
                            widget.hold.chatadd(
                                {"text": _controler.text, "isq": true});
                            delaytogo(3);

                            Timer(Duration(milliseconds: 1000), () {
                              widget.hold.chatadd(
                                {"text": ayah, "isq": false},
                              );
                              delaytogo(100);
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 12,
                      child: Container(
                        // width: MediaQuery.of(context).size.width - 30,
                        height: 65,
                        padding: EdgeInsets.all(11),
                        child: TextField(
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (val) {
                            widget.hold.chatadd(
                                {"text": _controler.text, "isq": true});
                            delaytogo(3);
                            Timer(Duration(milliseconds: 1000), () {
                              widget.hold.chatadd(
                                {"text": ayah, "isq": false},
                              );
                              delaytogo(100);
                            });
                          },
                          controller: _controler,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 3, right: 10),
                            hoverColor: Colors.green,
                            focusColor: Colors.green,
                            hintText: "من فضلك اكتب اي كلمة  من القران الكريم",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black12,
                      Colors.black12,
                      Colors.black12,
                      Colors.green.withOpacity(0.3),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Theme.of(context).primaryColor,
                ),
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controler.dispose();
    _scrollcontroler.dispose();
    super.dispose();
  }
}

class OpcityEffect extends StatefulWidget {
  final Widget child;
  final int time;
  OpcityEffect({this.child, this.time});
  @override
  _OpcityEffectState createState() => _OpcityEffectState();
}

class _OpcityEffectState extends State<OpcityEffect>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.time),
        vsync: this,
        lowerBound: 0,
        upperBound: 1)
      ..forward()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _controller.value,
      child: InkWell(
        radius: 100,
        child: widget.child,
        splashColor: Colors.green,
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          if (_controller.isCompleted) {
            _controller.reset();
            _controller.forward();
          }
        },
      ),
    );
  }
}
