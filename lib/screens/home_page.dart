import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/screens/bottom_tabs.dart';
import 'package:sem6_sdp_erent/screens/constants.dart';
import 'package:sem6_sdp_erent/tabs/home_tab.dart';
import 'package:sem6_sdp_erent/tabs/saved_tab.dart';
import 'package:sem6_sdp_erent/tabs/search_tab.dart';

import '../services/firebase_services.dart';
import '../widgets/custom_btn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  late PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
                controller: _tabsPageController,
                onPageChanged: (num) {
                  setState(() {
                    _selectedTab = num;
                  });
                },
                children: [
                  HomeTab(),
                  SearchTab(),
                  SavedTab(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          'THANK YOU!! PLEASE VISIT AGAIN.',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: CustomBtn(
                          text: "Your Orders",
                          onPressed: () =>
                              Navigator.pushNamed(context, 'PreviousOrder'),
                          outlineBtn: false,
                          isloading: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: CustomBtn(
                          text: "About Us",
                          onPressed: () =>
                              Navigator.pushNamed(context, 'AboutUs'),
                          outlineBtn: false,
                          isloading: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CustomBtn(
                          text: "LogOut",
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushNamed(context, 'landingPage');
                          },
                          outlineBtn: false,
                          isloading: false,
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
          Bottomtabs(
            selectedTab: _selectedTab,
            tabPressed: (num) {
              setState(
                () {
                  _tabsPageController.animateToPage(num,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
