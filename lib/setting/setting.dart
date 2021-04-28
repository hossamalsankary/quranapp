import 'package:quranv1/widgets.dart/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HoldData>(
      builder: (context, hold, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "ألاعدادات",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.green),
            ),
            centerTitle: true,
          ),
          body: Container(
            child: Wrap(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 19),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "عام",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                      Divider(
                        height: 20,
                      ),
                      setingItems(
                        settingitemname: "حجم الخط",
                        ondecress: () {
                          hold.decfont();
                        },
                        onincress: () {
                          hold.incfont();
                        },
                        sittingitem: hold.fontSize.toString(),
                      ),
                      Divider(
                        height: 20,
                      ),
                      setingItems(
                        settingitemname: "سمك الخط",
                        ondecress: () {
                          hold.changefontdecress();
                        },
                        onincress: () {
                          hold.changefontincress();
                        },
                        sittingitem: hold.index.toString(),
                      ),
                      Divider(
                        height: 17,
                      ),
                      setingItems(
                        settingitemname: "سرعة العرض",
                        ondecress: () {
                          hold.changespeeddecress();
                        },
                        onincress: () {
                          hold.changespeedincress();
                        },
                        sittingitem: hold.speed.toString(),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color:
                          Theme.of(context).backgroundColor.withOpacity(0.1)),
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                          " بِسْمِ ٱللَّهِ",
                          style: TextStyle(
                              fontSize: hold.fontSize,
                              fontWeight: hold.fontWight),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [
                      Divider(
                        height: 2,
                      ),
                      // Center(
                      //   child: Text(
                      //     "Developer information",
                      //     style: TextStyle(
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      Card(
                        margin: EdgeInsets.all(10),
                        color:
                            Theme.of(context).backgroundColor.withOpacity(0.2),
                        elevation: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text("developer by : hossam alsankary "),
                            Divider(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.sentiment_satisfied_alt),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.face),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.account_box),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(blurRadius: 10, color: Colors.grey),
                ]),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.3,
          ),
        );
      },
    );
  }

  setingItems(
      {Function onincress,
      Function ondecress,
      String sittingitem,
      String settingitemname}) {
    var style = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "+",
                    style: style.copyWith(fontSize: 20),
                  ),
                ),
                onTap: onincress,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  sittingitem,
                  style: style,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "-",
                    style: style.copyWith(fontSize: 20),
                  ),
                ),
                onTap: ondecress,
              ),
            ],
          ),
          Text(
            settingitemname,
            style: style.copyWith(
                shadows: [Shadow(blurRadius: 10, color: Colors.white)],
                fontSize: 18,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
