import 'package:budget_tracking_app/screens/dasboard.dart';
import 'package:budget_tracking_app/screens/login_screen.dart';
import 'package:budget_tracking_app/utils/colors.dart';
import 'package:budget_tracking_app/utils/validators.dart'; // tambahkan import validators.dart
import 'package:budget_tracking_app/view/base_view.dart';
import 'package:budget_tracking_app/view_model/signup_view_modal.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
      onModelReady: (model) {
        model.setAutoValidate(false); // set autovalidate to false initially
      },
      builder: (_, model, __) {
        TextEditingController email = TextEditingController();
        TextEditingController password = TextEditingController();
        TextEditingController name = TextEditingController();
        Validators validate = Validators(); // buat instance dari Validators

        var size = MediaQuery.of(context).size;

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
                        builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Login",
                    style: TextStyle(color: primary, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: model.signUpKey,
              child: Column(
                children: [
                  Center(
                    child: Image.asset("asset/boarding.png", scale: 1),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign up to Budget tracker",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Simpan data keuangan Anda disini sehingga Anda dapat mengaksesnya dari mana saja Anda inginkan.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Your Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Color(0xff67727d),
                          ),
                        ),
                        TextFormField(
                          controller: name,
                          cursorColor: black,
                          validator: (value) => validate.validateName(
                              value!), // gunakan validate dari instance Validators
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: "Your Name",
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Color(0xff67727d),
                          ),
                        ),
                        TextFormField(
                          controller: email,
                          cursorColor: black,
                          validator: (value) => validate.validateEmail(
                              value!), // gunakan validate dari instance Validators
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "email@gmail.com",
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                    controller: password,
                                    cursorColor: black,
                                    obscureText: true,
                                    validator: (value) => validate.validatePassword(
                                        value!), // gunakan validate dari instance Validators
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      hintText: "********",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                model.setAutoValidate(true);
                                if (model.signUpKey.currentState!.validate()) {
                                  model.clearData(context);
                                  email.clear();
                                  password.clear();
                                  name.clear();
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
