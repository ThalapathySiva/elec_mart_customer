import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  final Function onOTPSuccess;
  final Function onOTPIncorrect;

  const OTPScreen({this.phoneNumber, this.onOTPSuccess, this.onOTPIncorrect});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = null;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final AuthResult user =
          await firebaseAuth.signInWithCredential(credential);
      final FirebaseUser currentUser = await firebaseAuth.currentUser();
      assert(user.user.uid == currentUser.uid);
    } catch (e) {
      handleError(e);
    }
  }

  verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      setState(() {
        this.verificationId = verId;
      });
    };
    try {
      print("STARTING VERIFICATION of +91${widget.phoneNumber}");
      firebaseAuth.verifyPhoneNumber(
          phoneNumber: '+91${widget.phoneNumber}',
          codeSent: smsOTPSent,
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verId) {
            setState(() {
              this.verificationId = verId;
            });
          },
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print("RECEIVED FROM AUTH: " + phoneAuthCredential.toString());
          },
          verificationFailed: (AuthException e) {
            print("AUTH VERIFICATION FAILED : " +
                e.message +
                e.code +
                e.toString());
          });
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    verifyPhone();
    phoneNo = widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: layout(),
    );
  }

  void handleError(PlatformException e) {
    print(e.toString());
    print('ERROR CODE : ' + e.code);
    if (e.code == 'ERROR_INVALID_VERIFICATION_CODE') {
      errorMessage = 'Invalid OTP';
      widget.onOTPIncorrect();
    }
  }

  Widget layout() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          Container(padding: EdgeInsets.only(top: 20)),
          backButton(),
          Container(padding: EdgeInsets.only(top: 20)),
          Text(
            'ENTER OTP',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontSize: 30,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 24),
            child: Text(
                "OTP Sent to +91 $phoneNo. Please enter the OTP to continue.",
                style: TextStyle(fontSize: 14, color: BLACK_COLOR),
                textAlign: TextAlign.center),
          ),
          SizedBox(height: 20),
          CustomTextField(
            labelText: "OTP",
            errorText: errorMessage,
            onChanged: (val) {
              this.smsOTP = val;
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              PrimaryButtonWidget(
                buttonText: "Verify",
                onPressed: () async {
                  try {
                    final AuthCredential credential =
                        PhoneAuthProvider.getCredential(
                            verificationId: verificationId, smsCode: smsOTP);
                    print("RECEIVED CREDENTIAL : " + credential.toString());
                    await firebaseAuth.signInWithCredential(credential).then(
                        (authResult) {
                      //OTP verification success
                      print("OTP VERIFICATION SUCCESS");
                      widget.onOTPSuccess();
                    }, onError: (error) {
                      handleError(error);
                    });
                  } catch (e) {
                    handleError(e);
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget backButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Icon(FeatherIcons.arrowLeft, color: PRIMARY_COLOR),
      ),
    );
  }
}
