import 'package:quranv1/widgets.dart/provider.dart';
import 'package:quranv1/widgets.dart/tafseerdailog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowZkar extends StatefulWidget {
  final List content;
  ShowZkar(this.content);
  @override
  _ShowZkarState createState() => _ShowZkarState();
}

class _ShowZkarState extends State<ShowZkar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Consumer<HoldData>(
            builder: (context, holder, child) {
              return SliverAppBar(
                floating: true,
                actions: <Widget>[
                  IconButton(
                    icon: Text(
                      "-",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 35),
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
            initialItemCount: widget.content.length,
            itemBuilder: (context, index, animation) {
              List elzakr = widget.content;

              String data = elzakr[index]["text"];
              String source = elzakr[index]["source"];
              String count = elzakr[index]["count"];
              return Consumer<HoldData>(
                builder: (context, hold, child) {
                  return InkWell(
                    onTap: () {},
                    onLongPress: () {
                      showTafseer(context, source, title: "المصدر");
                    },
                    splashColor: Colors.green,
                    child: Container(
//height:if (elzakr.length == 1 ) return MediaQuery.of(context).size.height,
                      margin: EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                      // padding: EdgeInsets.only(bottom: 0, top: 10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(18)),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.share_outlined),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.info),
                                  onPressed: () {
                                    showTafseer(context, source,
                                        title: "المصدر");
                                  },
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width / 2.4,
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.7),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                          ),
                          Padding(
                            padding: elzakr.length == 1
                                ? EdgeInsets.only(
                                    top: 60, bottom: 60, left: 10, right: 10)
                                : EdgeInsets.all(30),
                            child: Text(
                              data,
                              style: TextStyle(
                                  fontSize: hold.fontSize,
                                  fontWeight: hold.fontWight),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // Container(
                          //   alignment: Alignment.center,
                          //   height: 40,
                          //   child: CircleAvatar(
                          //     backgroundColor: Theme.of(context).splashColor,
                          //     child: Text(count),
                          //   ),
                          //   width: MediaQuery.of(context).size.width / 2.4,
                          //   decoration: BoxDecoration(
                          //     color: Theme.of(context).backgroundColor,
                          //     borderRadius: BorderRadius.only(
                          //       topLeft: Radius.circular(30),
                          //       topRight: Radius.circular(30),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
