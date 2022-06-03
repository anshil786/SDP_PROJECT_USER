import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/services/firebase_services.dart';
import 'package:sem6_sdp_erent/widgets/custom_actionbar.dart';

import '../screens/product_page.dart';

class SavedTab extends StatefulWidget {
  @override
  State<SavedTab> createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.userRef
                .doc(_firebaseServices.getUserId())
                .collection("Saved")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error:${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return snapshot.data!.docs.isEmpty
                    ? Center(
                        child: Text('No Saved Products yet'),
                      )
                    : Stack(
                        children: [
                          Container(
                            child: ListView(
                              padding: EdgeInsets.only(
                                top: 108.0,
                                bottom: 24.0,
                              ),
                              children: snapshot.data!.docs.map((document) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductPage(
                                            productId: document.id,
                                          ),
                                        ));
                                  },
                                  child: FutureBuilder(
                                    future: _firebaseServices.productRef
                                        .doc(document.id)
                                        .get(),
                                    builder: (context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            productSnap) {
                                      //List _productMap =  [];
                                      if (productSnap.hasError) {
                                        return Container(
                                          child: Center(
                                              child:
                                                  Text("${productSnap.error}")),
                                        );
                                      }
                                      if (productSnap.connectionState ==
                                          ConnectionState.done) {
                                        Map _productMap =
                                            productSnap.data!.data();
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 24),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 90,
                                                  height: 90,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.network(
                                                      "${_productMap['images'][0]}",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 16),
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Text(
                                                            "${_productMap['name']}",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 4),
                                                          child: Text(
                                                            "${_productMap['price']}" +
                                                                " Rs/day",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Theme.of(
                                                                        context)
                                                                    .accentColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Size - ${document.data()['size']}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 190),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  _firebaseServices
                                                                      .userRef
                                                                      .doc(_firebaseServices
                                                                          .getUserId())
                                                                      .collection(
                                                                          "Saved")
                                                                      .doc(document
                                                                          .id)
                                                                      .delete();
                                                                });
                                                              },
                                                              icon: Icon(Icons
                                                                  .delete)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                      return Container(
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
              }
              // Loading State
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          CustomActionBar(
            title: "Saved Products",
            hasbackArrow: false,
          ),
        ],
      ),
    );
  }
}
