import 'package:budget_tracking_app/screens/dasboard.dart';
import 'package:budget_tracking_app/screens/signup_screen.dart';
import 'package:budget_tracking_app/utils/colors.dart';
import 'package:budget_tracking_app/utils/validators.dart';
import 'package:budget_tracking_app/view/base_view.dart';
import 'package:budget_tracking_app/view_model/login_view_model.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Validators validate = Validators();
  TextEditingController? _emailId;
  TextEditingController? _password;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BaseView<LogInViewModel>(
      onModelReady: (model) {
        _emailId = TextEditingController();
        _password = TextEditingController();
      },
      builder: (_, model, __) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            title: const Text(
              "Budget tracker",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                      (Route<dynamic> route) => false);
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: primary, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: model.logInKey,
              child: Column(
                children: [
                  Center(child: Image.asset("asset/boarding.png", scale: 1)),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Text(
                          "Login akun anda",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Color(0xff67727d),
                          ),
                        ),
                        TextFormField(
                          controller: _emailId,
                          cursorColor: black,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          validator: (value) => validate.validateEmail(value!),
                          autovalidateMode: model.autoValidate
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "email@gmail.com",
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: (size.width - 140),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Password",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Color(0xff67727d),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _password,
                                    cursorColor: black,
                                    obscureText: true,
                                    validator: (value) =>
                                        validate.validatePassword(value!),
                                    autovalidateMode: model.autoValidate
                                        ? AutovalidateMode.always
                                        : AutovalidateMode.disabled,
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: "********",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                model.setAutoValidate(true);
                                if (model.logInKey.currentState!.validate()) {
                                  model.clearData(context);
                                  _emailId?.clear();
                                  _password?.clear();
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const Dashboard(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                }
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
