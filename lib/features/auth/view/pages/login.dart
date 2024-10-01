import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jop_finder_app/features/auth/view/pages/forget_password.dart';
import 'package:jop_finder_app/features/auth/view/pages/shared/styled_Button.dart';
import 'package:jop_finder_app/features/auth/view/pages/shared/styled_textField.dart';
import 'package:jop_finder_app/features/auth/view/pages/shared/text_Divider.dart';
import 'package:jop_finder_app/features/auth/view/pages/shared/welcome_text.dart';
import 'package:jop_finder_app/features/auth/view/pages/signin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Create controllers for the TextFields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void validation() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == "password") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password not correct"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 253),
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //First three Rows of Text presentation of the title headline and text
                const WelcomeText(
                    title: "Jôbizz",
                    headline: "Welcome Back 👋",
                    text: "Let’s log in. Apply to jobs!"),
                const SizedBox(height: 50),

                //TextFileds for name email password and confirm pass
                StyledTextField(
                    hint: "E-mail",
                    icon: Icons.mail_outline_outlined,
                    controller: _emailController),
                const SizedBox(height: 16),
                StyledTextField(
                    hint: "Password",
                    icon: Icons.lock_outlined,
                    isPassword: true,
                    controller: _passwordController),
                const SizedBox(height: 30),

                //Button to Login
                StyledButton(
                    onPressed: () {
                      validation();
                    },
                    text: "Login"),
                const SizedBox(height: 30),

                //Forgetpassword Text button
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPasswordScreen()));
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 53, 104, 153),
                        fontSize: 13,
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),

                //Text between two lines
                const TextBetweenDivider(text: "Or continue with"),
                const SizedBox(height: 70),

                //Row for the Google and facebook Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    SvgPicture.asset(
                      'assets/images/google.svg',
                      width: 30,
                      height: 30,
                    ),
                    const Icon(
                      Icons.facebook,
                      color: Colors.blue,
                      size: 38,
                    ),
                    const SizedBox(),
                  ],
                ),
                const SizedBox(height: 30),

                // Row for Navigating to Sign in Screen contains text and texButton
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                        "Haven't an account?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 175, 176, 182),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to register screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Color.fromARGB(255, 53, 104, 153),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
