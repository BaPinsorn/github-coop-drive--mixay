import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_coop_driver_mixay/Colors.dart/MxColors.dart';
import 'package:flutter_coop_driver_mixay/model/Border.dart';
import 'package:flutter_coop_driver_mixay/model/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../screen/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  void top() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: MxColors.mainColorWhite,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light));
  }

  @override
  void initState() {
    top();
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  bool obscurPassword = true; // Define the variable obscurPassword

  void _addToFirebase() {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference = firestore.collection('users').doc();

    documentReference.set({
      'id': profile.id,
      'user_id': profile.userid,
      'email': profile.email,
      'password': profile.password,
    }).then((value) {
      // print("บันทึกลง firebase แล้ว");
    }).catchError((error) {
      // print("บันทึกลง firebase ไม่ได้");
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          //ไม่มีข้อผิดพลาดเกิดขึ้น = แอพสามารถเชื่อมไปยัง firebase ได้
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: MxColors.mainColorWhite,
              body: Container(
                color: MxColors.mainColorWhite,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 85,
                          ),
                          const Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: MxColors.mainColorRed),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "กรุณากรอกรหัสพนักงาน";
                              } else if (value.length > 20) {
                                return "กรุณากรอกรหัสพนักงาน ไม่เกิน 20 ตัวอักษร";
                              }
                              return null;
                            },
                            maxLength: 20,
                            autofocus: true,
                            // cursorColor: MxColors.mainColorRed,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(18),
                              filled: true,
                              fillColor: MxColors.backgroundColorblueGrey50,
                              helperStyle: const TextStyle(
                                  fontSize: 15,
                                  color: MxColors.titleColorBlack),
                              helperText: "รหัสพนักงาน",
                              hintStyle: const TextStyle(
                                  color: MxColors.hintStyleColorblueGrey400),
                              hintText: "EMP-001",
                              prefixIcon: const Icon(
                                Icons.person,
                                color: MxColors.hintStyleColorblueGrey400,
                              ),
                              border: BorderChange
                                  .enabledBorder(), // Use the enabled border style
                              focusedBorder: BorderChange
                                  .focusedBorder(), // Use the focused border style
                              errorBorder: BorderChange
                                  .errorBorder(), // Use the error border style
                              focusedErrorBorder: BorderChange
                                  .focusedErrorBorder(), // Use the focused error border style
                            ),
                            onSaved: (String? id) {
                              profile.id = id;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "กรุณากรอกอีเมล"),
                              EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            // cursorColor: MxColors.mainColorRed,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(18),
                              filled: true,
                              fillColor: MxColors.backgroundColorblueGrey50,
                              helperStyle: const TextStyle(
                                  fontSize: 15,
                                  color: MxColors.titleColorBlack),
                              helperText: "อีเมลผู้ใช้ของคุณ",
                              hintStyle: const TextStyle(
                                  color: MxColors.hintStyleColorblueGrey400),
                              hintText: "E-Mail",
                              prefixIcon: const Icon(
                                Icons.email,
                                color: MxColors.hintStyleColorblueGrey400,
                              ),
                              border: BorderChange
                                  .enabledBorder(), // Use the enabled border style
                              focusedBorder: BorderChange
                                  .focusedBorder(), // Use the focused border style
                              errorBorder: BorderChange
                                  .errorBorder(), // Use the error border style
                              focusedErrorBorder: BorderChange
                                  .focusedErrorBorder(), // Use the focused error border style
                            ),
                            onSaved: (String? email) {
                              profile.email = email;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "กรุณากรอกรหัสผ่าน";
                              } else if (value.length < 8) {
                                return "กรุณากรอกรหัสผ่าน อย่างน้อย 8 ตัวอักษร";
                              }
                              return null;
                            },

                            keyboardType: TextInputType.visiblePassword,
                            obscureText: obscurPassword,
                            // obscuringCharacter: "*",
                            cursorColor: MxColors.mainColorRed,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(18),
                              filled: true,
                              fillColor: MxColors.backgroundColorblueGrey50,
                              helperStyle: const TextStyle(
                                  fontSize: 15,
                                  color: MxColors.titleColorBlack),
                              helperText:
                                  "รหัสผู้ใช้ของคุณอย่างน้อย 8 ตัวอักษร",
                              hintStyle: const TextStyle(
                                  color: MxColors.hintStyleColorblueGrey400),
                              hintText: "Password",
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: MxColors.hintStyleColorblueGrey400,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => setState(
                                    () => obscurPassword = !obscurPassword),
                                icon: Icon(
                                  obscurPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: MxColors.hintStyleColorblueGrey400,
                                ),
                              ),
                              border: BorderChange
                                  .enabledBorder(), // Use the enabled border style
                              focusedBorder: BorderChange
                                  .focusedBorder(), // Use the focused border style
                              errorBorder: BorderChange
                                  .errorBorder(), // Use the error border style
                              focusedErrorBorder: BorderChange
                                  .focusedErrorBorder(), // Use the focused error border style
                            ),
                            onSaved: (String? password) {
                              profile.password = password;
                            },
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                backgroundColor: MaterialStateProperty.all(
                                    MxColors.mainColorRed),
                              ),
                              onPressed: () async {
                                if (formKey.currentState != null &&
                                    formKey.currentState!.validate()) {
                                  try {
                                    formKey.currentState!.save();
                                    _addToFirebase();
                                    final email = profile.email ?? '';
                                    final password = profile.password ?? '';
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: email, password: password)
                                        .then((value) {
                                      formKey.currentState!.reset();
                                      Fluttertoast.showToast(
                                        msg: "สร้างบัญชีผู้ใช้เรียบร้อยแล้ว",
                                        gravity: ToastGravity.TOP,
                                        fontSize: 16.0,
                                        backgroundColor:
                                            MxColors.subtitleColorBlue,
                                        textColor: MxColors.mainColorWhite,
                                      );
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const LoginScreen();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    // print(e.code);
                                    String message = "";
                                    if (e.code == 'email-already-in-use') {
                                      message =
                                          "บัญชีนี้ถูกใช้งานแล้ว กรุณาใช้บัญชีอื่นแทน";
                                      //จากอ.กล้องรักสยาม วิธีสร้าง Register/Login
                                      // } else if (e.code == "weak-password") {
                                      //   message =
                                      //       "รหัสผ่านต้องไม่น้อยกว่า 6 ตัวอักษร";
                                      // } else {
                                      message = message;
                                    }
                                    Fluttertoast.showToast(
                                      msg: message,
                                      gravity: ToastGravity.CENTER,
                                      fontSize: 16.0,
                                      backgroundColor: MxColors.mainColorRed,
                                      textColor: MxColors.mainColorWhite,
                                    );
                                  }
                                }
                              },
                              child: const Text("ลงทะเบียน",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: MxColors.mainColorWhite,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Don't have an ? ",
                                style:
                                    TextStyle(color: MxColors.titleColorBlack),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const LoginScreen();
                                    }));
                                  },
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MxColors.mainColorRed),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          // Return a default widget here if the snapshot has no error
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
