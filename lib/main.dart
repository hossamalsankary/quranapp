import 'package:quranv1/home_screen/home.dart';
import 'package:quranv1/splach_screen/spach.dart';
import 'package:quranv1/widgets.dart/provider.dart';
import 'package:quranv1/widgets.dart/reader_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HoldData(),
      child: ChangeNotifierProvider(
        create: (context) {
          return ReaderProvider();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(accentColor: Colors.green),
          initialRoute: "home",
          routes: {
            "/home": (_) => HomeScreen(),
            "/": (_) => WelcomeScreen(),
          },
        ),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // get inherted from flutterLocalNotifications
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       new FlutterLocalNotificationsPlugin();
//   var initializationSettingsAndroid;
//   var initializationSettingsIOS;
//   var initializationSettings;

//   void _showNotification(name, body) async {
//     await _demoNotification(name, body);
//   }

//   Future<void> _demoNotification(name, body) async {
//     String notificationNmae = name, notificationBody = body;
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'channel_ID', 'channel name', 'channel description',
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'test ticker',
//         fullScreenIntent: true,
//         color: Colors.black);

//     var iOSChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);

//     await flutterLocalNotificationsPlugin.show(
//         0, notificationNmae, notificationBody, platformChannelSpecifics,
//         payload: 'test oayload');
//   }

//   @override
//   void initState() {
//     _showNotification("hossam", "hello");
//     Future.delayed(Duration(seconds: 10)).then((value) {
//       _showNotification("hossam", "Iam comeing From BackGreouns");
//     });
//     super.initState();
//     initializationSettingsAndroid =
//         new AndroidInitializationSettings('app_icon');
//     initializationSettingsIOS = new IOSInitializationSettings(
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     initializationSettings = new InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//     flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: onSelectNotification);
//   }

//   Future onSelectNotification(String payload) async {
//     if (payload != null) {
//       debugPrint('Notification payload: $payload');
//     }
//     await Navigator.push(context,
//         new MaterialPageRoute(builder: (context) => new SecondRoute()));
//   }

//   Future onDidReceiveLocalNotification(
//       int id, String title, String body, String payload) async {
//     await showDialog(
//         context: context,
//         builder: (BuildContext context) => CupertinoAlertDialog(
//               title: Text(title),
//               content: Text(body),
//               actions: <Widget>[
//                 CupertinoDialogAction(
//                   isDefaultAction: true,
//                   child: Text('Ok'),
//                   onPressed: () async {
//                     Navigator.of(context, rootNavigator: true).pop();
//                     await Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => SecondRoute()));
//                   },
//                 )
//               ],
//             ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         // onPressed: _showNotification,
//         tooltip: 'Increment',
//         child: Icon(Icons.notifications),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// class SecondRoute extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('AlertPage'),
//       ),
//       body: Center(
//         child: RaisedButton(
//           child: Text('go Back ...'),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//     );
//   }
// }
