import 'package:flutter/material.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_formField.dart';
import 'volunteer_homeScreen.dart';
import 'volunteer_signup_screen.dart';
import '../../utils/form_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VolunteerLoginScreen extends StatefulWidget {
  const VolunteerLoginScreen({super.key});

  @override
  State<VolunteerLoginScreen> createState() => _VolunteerLoginScreenState();
}

class _VolunteerLoginScreenState extends State<VolunteerLoginScreen> {
  bool isShowPassword = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Volunteer Login Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFD32F2F),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 246, 240, 227),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, top: 2.0),
                    child: Text(
                      "Welcome!",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Text(
                      "Login to your account",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  CustomFormField(
                    label: "Enter the email address",
                    icon: Icons.email_outlined,
                    controller: emailController,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        FormValidator.validateEmail(value ?? ""),
                  ),
                  const SizedBox(height: 8.0),
                  CustomFormField(
                    label: "Enter the password",
                    icon: Icons.lock_outline,
                    obscureText: !isShowPassword,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    onToggle: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    validator: (value) =>
                        FormValidator.validatePassword(value ?? ""),
                  ),
                  const SizedBox(height: 20.0),
                  CustomButton(
                    text: "Login",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          UserCredential credential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );

                          User? user = credential.user;
                          await user?.reload();

                          if (!user!.emailVerified) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please verify your email before logging in.",
                                ),
                              ),
                            );
                            await FirebaseAuth.instance.signOut();
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const VolunteerHomeScreen(),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Login failed. ${e.toString()}",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    color: Colors.white,
                    radius: 12.0,
                    width: double.infinity,
                    bgColor: const Color(0xFFD32F2F),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VolunteerSignUpScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        " If you don't have an account,  Sign Up",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
