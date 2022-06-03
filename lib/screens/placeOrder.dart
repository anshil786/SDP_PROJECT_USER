import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/screens/previousorder.dart';
import 'package:intl/intl.dart';
import '../services/firebase_services.dart';
import '../widgets/custom_actionbar.dart';
import 'package:sem6_sdp_erent/screens/product_page.dart';

class PlaceOrder extends StatefulWidget {
  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  FirebaseServices _firebaseServices = FirebaseServices();
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> _formKey1 = GlobalKey();

  String _selectedProductSize = "0";
  void _onPressed() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final FirebaseAuth _auth = FirebaseAuth.instance;

    User user = FirebaseAuth.instance.currentUser;
    Firestore.instance.collection("Users").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        Firestore.instance
            .collection("Users")
            .document(user.uid)
            .collection("Cart")
            .getDocuments()
            .then((querySnapshot) {
          querySnapshot.documents.forEach((result) {
            Firestore.instance
                .collection("Order")
                .document()
                .setData(result.data());
          });
        });
      });
    });
  }

  CollectionReference _addToCart() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("Details");
  }

  late String firstName;

  late String lastName;

  late String mobileNumber;

  late String numberofDays;

  late String email;

  late String deliveryAddress;

  late String pinCode;

  String formatDate(DateTime date) =>
      new DateFormat("dd MMMM yyyy").format(date);

  User user = FirebaseAuth.instance.currentUser;

  // DocumentSnapshot documentData = snapshot.data!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomActionBar(
              hasbackArrow: true,
              title: "ORDER DETAILS",
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      firstName = value;
                    },
                    decoration: InputDecoration(
                        // hintText: " Name",
                        labelText: "First Name",
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black),
                        border: InputBorder.none,
                        fillColor: Colors.black12,
                        filled: true),
                    obscureText: false,
                    maxLength: 30,
                  ),
                  TextField(
                    onChanged: (value) {
                      lastName = value;
                    },
                    decoration: InputDecoration(
                        // hintText: " Name",
                        labelText: "Last Name",
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black),
                        border: InputBorder.none,
                        fillColor: Colors.black12,
                        filled: true),
                    obscureText: false,
                    maxLength: 30,
                  ),
                  Form(
                    key: _formKey1,
                    child: TextFormField(
                      validator: ((value) {
                        if (int.parse(value!) < 999999999) {
                          return 'Enter valid Mobile No.';
                        }
                      }),
                      onChanged: (value) {
                        mobileNumber = value;
                      },
                      decoration: InputDecoration(
                          hintText: " xxxxxxxxxx",
                          labelText: "Mobile Number",
                          labelStyle:
                              TextStyle(fontSize: 15, color: Colors.black),
                          border: InputBorder.none,
                          fillColor: Colors.black12,
                          filled: true),
                      obscureText: false,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Form(
                    child: TextFormField(
                      onChanged: (value) {
                        numberofDays = value;
                      },
                      decoration: InputDecoration(
                          hintText: "number of days you want to rent product",
                          labelText: "Number Of Days",
                          labelStyle:
                              TextStyle(fontSize: 15, color: Colors.black),
                          border: InputBorder.none,
                          fillColor: Colors.black12,
                          filled: true),
                      obscureText: false,
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (!value!.contains('@')) {
                          return 'please enter valid email';
                        }
                        // return null;
                      },
                      decoration: InputDecoration(
                          //hintText: "",
                          labelText: "Email",
                          labelStyle:
                              TextStyle(fontSize: 15, color: Colors.black),
                          border: InputBorder.none,
                          fillColor: Colors.black12,
                          filled: true),
                      obscureText: false,
                      maxLength: 30,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      deliveryAddress = value;
                    },
                    decoration: InputDecoration(
                        //hintText: "",
                        labelText: "Delivery Address",
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black),
                        border: InputBorder.none,
                        fillColor: Colors.black12,
                        filled: true),
                    obscureText: false,
                    maxLength: 300,
                    maxLines: 3,
                    //keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    onChanged: (value) {
                      pinCode = value;
                    },
                    decoration: InputDecoration(
                        hintText: " xxxxxx",
                        labelText: "Pin Code",
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black),
                        border: InputBorder.none,
                        fillColor: Colors.black12,
                        filled: true),
                    obscureText: false,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                  ),
                  RaisedButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    //disabledTextColor: Colors.orange,
                    // hoverColor: Colors.orange,
                    splashColor: Color(0xFFFF1E00),
                    //disabledColor: Colors.blue,
                    elevation: 5,

                    onPressed: () async {
                      if (!_formKey1.currentState!.validate()) {
                        return;
                      }
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      final doc = await _addToCart().doc();
                      final id = doc.id;
                      await _addToCart().doc(id).set({
                        'firstname': firstName,
                        'lastname': lastName,
                        'mobilenumber': mobileNumber,
                        'Days': numberofDays,
                        'email': email,
                        'deliveryaddress': deliveryAddress,
                        'pincode': pinCode,
                        'date': formatDate(DateTime.now()),
                      });

                      final cartdoc = await Firestore.instance
                          .collection("Users")
                          .document(user.uid)
                          .collection("Cart")
                          .get();
                      final cartlist = await cartdoc.docs;
                      cartlist.forEach((element) async {
                        final snapshot = await Firestore.instance
                            .collection('Users')
                            .doc(user.uid)
                            .collection('Details')
                            .doc(id)
                            .collection('personalorder')
                            .doc(element.id)
                            .set({'size': element.get('size')});
                        final snap = await Firestore.instance
                            .collection('Users')
                            .doc(user.uid)
                            .collection('Order')
                            .doc(element.id)
                            .set({
                          'size': element.get('size'),
                          'date': formatDate(DateTime.now()),
                        });
                      });

                      // Firestore.instance
                      //     .collection("Users")
                      //     .getDocuments()
                      //     .then((querySnapshot) {
                      //   querySnapshot.documents.forEach((result) {
                      //     Firestore.instance
                      //         .collection("Users")
                      //         .document(user.uid)
                      //         .collection("Cart")
                      //         .getDocuments()
                      //         .then((querySnapshot) {
                      //       querySnapshot.documents.forEach((result) {
                      //         Firestore.instance
                      //             .collection('Users')
                      //             .doc(user.uid)
                      //             .collection("Details")
                      //             .document(id)
                      //             .collection('personalorder')
                      //             .add(result.data());
                      //       });
                      //     });
                      //   });
                      // });

                      Navigator.pushNamed(context, 'Success');

                      var collection = Firestore.instance
                          .collection('Users')
                          .document(user.uid)
                          .collection('Cart');
                      var snapshots = await collection.get();
                      for (var doc in snapshots.docs) {
                        await doc.reference.delete();
                      }
                    },

                    child: Text("Place Order"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text("details")),
//     );
//   }
  }
}
