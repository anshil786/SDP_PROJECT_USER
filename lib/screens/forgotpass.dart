import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/screens/register_page.dart';

import '../widgets/custom_btn.dart';
import '../widgets/custom_input.dart';
import 'constants.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error occured"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("close"))
            ],
          );
        });
  }

  Future<String?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _loginEmail);
      return null;
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'weak-password') {
      //   return 'The password provided is too weak.';
      // } else if (e.code == 'email-already-in-use') {
      //   return 'The account already exists for that email.';
      // }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _loginformLoading = true;
    });
    String? _signInFeedBack = await _loginAccount();
    if (_signInFeedBack != null) {
      _alertDialogBuilder(_signInFeedBack);
      setState(() {
        _loginformLoading = false;
      });
    }
    setState(() {
      _loginformLoading = false;
    });
    Navigator.pop(context);
  }

  bool _loginformLoading = false;
  String _loginEmail = "";
  String _loginPassword = "";
  late FocusNode _passwordFocusNode;
  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(top: 20),
        width: double.infinity,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            Container(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                "Reset password",
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                CustomInput(
                  hintText: "Email",
                  onChanged: (value) {
                    _loginEmail = value;
                  },
                  onSubmit: (value) {
                    _passwordFocusNode.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                  isPasswordField: false,
                ),
                // // CustomInput(
                // //   hintText: "password...",
                // //   onChanged: (value) {
                // //     _loginPassword = value;
                // //   },
                // //   onSubmit: (value) {
                // //     _submitForm();
                // //   },
                //   focusNode: _passwordFocusNode,
                //   textInputAction: TextInputAction.done,
                //   isPasswordField: true,
                // ),
                SizedBox(
                  height: 30,
                ),
                CustomBtn(
                  text: "submit",
                  onPressed: () {
                    _submitForm();
                  },
                  // outlineBtn: false,
                  isloading: _loginformLoading,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
