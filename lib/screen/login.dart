import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_coop_driver_mixay/Admin/register.dart';
import 'package:flutter_coop_driver_mixay/Colors.dart/MxColors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_coop_driver_mixay/screen/menu.dart';
import 'package:flutter_coop_driver_mixay/model/profile.dart';

import '../model/Border.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
  bool obscurPassword = true;

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
                            'Login',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: MxColors.mainColorRed),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "กรุณากรอกอีเมล"),
                              EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                            ]),
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: MxColors.mainColorRed,
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
                            // cursorColor: MxColors.mainColorRed,
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
                              ),
                              onPressed: () async {
                                if (formKey.currentState != null &&
                                    formKey.currentState!.validate()) {
                                  try {
                                    formKey.currentState!.save();
                                    final email = profile.email ?? '';
                                    final password = profile.password ?? '';
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: email, password: password)
                                        .then((value) {
                                      formKey.currentState!.reset();
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const MenuScreen();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    Fluttertoast.showToast(
                                      msg: e.message!,
                                      gravity: ToastGravity.CENTER,
                                      fontSize: 16.0,
                                      backgroundColor: MxColors.mainColorRed,
                                      textColor: MxColors.mainColorWhite,
                                    );
                                  }
                                }
                              },
                              child: const Text("ลงชื่อเข้าใช้",
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Don't Have an Account? ",
                                style:
                                    TextStyle(color: MxColors.titleColorBlack),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const RegisterScreen();
                                    }));
                                  },
                                  child: const Text(
                                    "Sign Up",
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
