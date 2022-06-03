import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/screens/product_page.dart';

import '../services/firebase_services.dart';
import '../widgets/custom_actionbar.dart';

class PreviousOrder extends StatefulWidget {
  @override
  State<PreviousOrder> createState() => _PreviousOrderState();
}

class _PreviousOrderState extends State<PreviousOrder> {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.userRef
                .doc(_firebaseServices.getUserId())
                .collection("Order")
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
                    ? Center(child: Text('NO orders!!'))
                    : ListView(
                        padding: EdgeInsets.only(
                          top: 108.0,
                          bottom: 24.0,
                        ),
                        children: snapshot.data!.docs.map((document) {
                          return GestureDetector(
                            onTap: () {},
                            child: FutureBuilder(
                              future: _firebaseServices.productRef
                                  .doc(document.id)
                                  .get(),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> productSnap) {
                                //List _productMap =  [];
                                if (productSnap.hasError) {
                                  return Container(
                                    child: Center(
                                        child: Text("${productSnap.error}")),
                                  );
                                }
                                if (productSnap.connectionState ==
                                    ConnectionState.done) {
                                  Map _productMap = productSnap.data!.data();
                                  return Column(children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 24),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 115,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                "${_productMap['images'][0]}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 16),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Text(
                                                      "${_productMap['name']}",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 4),
                                                        child: Text(
                                                          "${_productMap['price']}Rs/day",
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
                                                    ],
                                                  ),
                                                  Text(
                                                    "Size - ${document.data()['size']}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "date - ${document.data()['date']}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]);
                                }
                                return Container(
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              },
                            ),
                          );
                        }).toList(),
                      );
              }

              // Loading State
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          CustomActionBar(
            hasbackArrow: true,
            title: "Your Orders",
          ),
        ],
      ),
    );
  }
}
