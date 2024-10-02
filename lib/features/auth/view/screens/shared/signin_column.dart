import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_Button.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_textField.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/text_between_Divider.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/welcome_text.dart';
import 'package:jop_finder_app/features/auth/viewmodel/cubit/auth_cubit.dart';

class SignInColumn extends StatefulWidget {
  final String? errorMessage;
  const SignInColumn({
    this.errorMessage,
    super.key,
  });

  @override
  State<SignInColumn> createState() => _SigninColumnState();
}

class _SigninColumnState extends State<SignInColumn> {
  final _formKey = GlobalKey<FormState>();

  // Create controllers for the TextFields
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool validation() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
          const SizedBox(height: 15),

          (widget.errorMessage != null)
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    widget.errorMessage.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 15),

          //Button to Login
          StyledButton(
              onPressed: () {
                if (validation()) {
                  BlocProvider.of<AuthCubit>(context).signIn(
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context);
                }
              },
              text: "Login"),
          const SizedBox(height: 30),

          //Forgetpassword Text button
          TextButton(
              onPressed: () {
                GoRouter.of(context).pushNamed(AppRouter.forgetPassword);
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
                  GoRouter.of(context).pushReplacementNamed(AppRouter.signUp);
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
    );
  }
}
