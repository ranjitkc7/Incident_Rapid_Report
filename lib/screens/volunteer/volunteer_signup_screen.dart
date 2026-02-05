import 'package:flutter/material.dart';
import '../../service/volunteerAuth.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_formField.dart';
import 'volunteer_login_screen.dart';
import '../../utils/form_validator.dart';

class VolunteerSignUpScreen extends StatefulWidget {
  const VolunteerSignUpScreen({super.key});

  @override
  State<VolunteerSignUpScreen> createState() => _VolunteerSignUpScreenState();
}

class _VolunteerSignUpScreenState extends State<VolunteerSignUpScreen> {
  bool isShowPassword = false;
  bool isShowConfirmPassword = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final VolunteerAuthService _authService = VolunteerAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Volunteer Sign Up Page',
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
                      "Sign Up to create new account",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  CustomFormField(
                    label: "Enter the name",
                    icon: Icons.person_2_rounded,
                    controller: nameController,
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    validator: (value) =>
                        FormValidator.validateName(value ?? ""),
                  ),
                  const SizedBox(height: 8.0),
                  CustomFormField(
                    label: "Enter the email address",
                    icon: Icons.email_outlined,
                    obscureText: false,
                    controller: emailController,
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
                  const SizedBox(height: 8.0),
                  CustomFormField(
                    label: "Re-enter the password",
                    icon: Icons.lock_person,
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !isShowConfirmPassword,
                    onToggle: () {
                      setState(() {
                        isShowConfirmPassword = !isShowConfirmPassword;
                      });
                    },
                    validator: (value) => FormValidator.validateConfirmPassword(
                      passwordController.text,
                      value ?? "",
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  CustomButton(
                    text: "Sign Up",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final error = await _authService.signUp(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          role: "volunteer",
                        );

                        if (error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                error,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Sign Up Successful! Verification email sent.",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 3),
                            ),
                          );
                          Future.delayed(const Duration(seconds: 3), () {
                            Navigator.pop(context);
                          });
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
                          builder: (context) => const VolunteerLoginScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        "If Already have an account,  Log In",
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
