import 'package:quranv1/azkar_screen/azkar.dart';
import 'package:quranv1/chat/chat.dart';
import 'package:quranv1/quran_screen/quran.dart';
import 'package:quranv1/setting/setting.dart';
import 'package:quranv1/widgets.dart/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color tabitemcolor = Colors.white;
  Color active = Colors.green;

  int _currentIndex = 0;
  PageController _pageController = PageController();

  onTabTapped(val) {
    setState(() {
      _currentIndex = val;
      _pageController.jumpToPage(_currentIndex);
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, HoldData hold, child) {
          return PageView(
            onPageChanged: (value) {
          if(value != 3)    setState(() {
            print(value);
            _currentIndex = value;
          });
            },
            controller: _pageController,
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [QuranHome(), AzkarScreen(), Chat(hold), Setting()],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            _pageController.jumpToPage(3);

          });
        },
        child: Icon(Icons.settings , color:Colors.white,
            ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
backgroundColor: Theme.of(context).primaryColor,
        opacity: .2,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.red, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(

            backgroundColor: Colors.green,
            icon: Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.dashboard,
              color: Colors.green,
            ),
            title: Text("القران الكريم"),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.green,
            icon: Icon(
              Icons.access_time,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.access_time,
              color: Colors.green,
            ),
            title: Text("الاذكار"),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.green,
            icon: Icon(
              Icons.chat,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.chat,
              color: Colors.green,
            ),
            title: Text("شات"),
          ),
          // BubbleBottomBarItem(
          //   backgroundColor: Colors.green,
          //   icon:Text(""),
          //
          //   title: Text(""),
          // ),
          // BubbleBottomBarItem(
          //   backgroundColor: Colors.green,
          //   icon: Icon(
          //     Icons.menu,
          //     color: Colors.white,
          //   ),
          //   activeIcon: Icon(
          //     Icons.menu,
          //     color: Colors.green,
          //   ),
          //   title: Text("الاعدادات"),
          // )
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedFontSize: 10,
      //   selectedItemColor: Colors.green,
      //   unselectedItemColor: Colors.white,
      //   elevation: 20,
      //   unselectedFontSize: 8,
      //   selectedLabelStyle: TextStyle(
      //     color: Colors.white,
      //     height: 1.5,
      //     fontWeight: FontWeight.w900,
      //   ),
      //
      //   onTap: onTabTapped, // new
      //   currentIndex: _currentIndex, // new
      //   items: [
      //     new BottomNavigationBarItem(
      //       icon: Image(
      //         width: 30,
      //         colorBlendMode: BlendMode.screen,
      //         image: AssetImage("assets/images/quranicon.png"),
      //       ),
      //       label: 'القران الكريم',
      //     ),
      //     new BottomNavigationBarItem(
      //       icon: Image(
      //         width: 30,
      //         image: AssetImage("assets/images/read.png"),
      //       ),
      //       label: 'الاذكار',
      //     ),
      //     new BottomNavigationBarItem(
      //       icon: Image(
      //         filterQuality: FilterQuality.high,
      //         width: 30,
      //         image: AssetImage("assets/images/icons.png"),
      //       ),
      //       label: 'شات',
      //     ),
      //     new BottomNavigationBarItem(
      //       icon: Image(
      //         width: 30,
      //         colorBlendMode: BlendMode.screen,
      //         image: AssetImage("assets/images/setting.png"),
      //       ),
      //       label: 'الاعدادات',
      //     ),
      //   ],
      // ),
    );
  }
}
