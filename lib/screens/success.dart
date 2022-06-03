import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          // padding: const EdgeInsets.all(120.0),
          Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 190,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              height: 150,
              child: Image(
                  image: AssetImage('assets/images/hook-1727484_960_720.png')),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            // margin: EdgeInsets.only(top: 30),
            child: Text(
              "Order Successful!!",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            //   margin: EdgeInsets.only(top: 152),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(25)),
              child: RaisedButton(
                color: Colors.black,
                textColor: Colors.white,
                //disabledTextColor: Colors.orange,
                // hoverColor: Colors.orange,
                splashColor: Color(0xFFFF1E00),
                //disabledColor: Colors.blue,
                elevation: 5,
                child: Text('Continue Shopping'),
                onPressed: () {
                  Navigator.pushNamed(context, 'homepage');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
