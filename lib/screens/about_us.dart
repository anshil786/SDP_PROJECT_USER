import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/custom_actionbar.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  String _url = "https://wa.me/+919099901228/?text=Hello ERENT!!";
  String _tel = "tel:9099901228";
  void _launchURL() async {
    if (await canLaunch(_url)) {
      await launch(_url, forceWebView: true);
    }
  }

  void _launchTEL() async {
    if (await canLaunch(_tel)) {
      await launch(_tel, forceWebView: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 15,
              ),
              CustomActionBar(
                hasbackArrow: true,
                title: "ERENT",
              ),
              // Padding(

              //   padding: EdgeInsets.only(top: 10),
              // ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: SingleChildScrollView(
                    //scrollDirection: Axis.vertical,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Center(
                          child: Text(
                              "~~Trendy is the last stage before Tacky~~",
                              style: GoogleFonts.lato(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          " _Our Branches_\n",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "• A/8, Seth Complex, Gandhi Road, Panchbatti Bharuch - 392001.\n",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "• Shop 512, Sakti Nath Complex, Near Sakti Nath Circle, Nabipur - 392015.\n",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "• Shop No. 101, First Floor Harihar Complex, Zadeshwar Road Bharuch, Ankleshwar - 392022.\n",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 55,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Container(
                            //     child: Icon(
                            //   Icons.delete,
                            //   color: Colors.black,
                            // )),
                            FloatingActionButton(
                              child: FaIcon(FontAwesomeIcons.whatsapp),
                              backgroundColor: Colors.black,
                              onPressed: () {
                                launch(_url);
                              },
                            ),
                            FloatingActionButton(
                              child: FaIcon(FontAwesomeIcons.phone),
                              backgroundColor: Colors.black,
                              onPressed: () {
                                launch(_tel);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
