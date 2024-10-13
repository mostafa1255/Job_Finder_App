//signup

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/google_facebook_sign.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_button.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_textField.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_text_navigation_to_from_signin.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/text_between_divider.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/welcome_text.dart';
import 'package:jop_finder_app/features/auth/viewmodel/cubit/auth_cubit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //Key for validation
  final _formKey = GlobalKey<FormState>();

  // Create controllers for the TextFields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //Register button onpressed
  bool registerCheck() {
    //condition to check the validation of textfields
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 250, 250, 253),
          body: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("User signed up successfully")));
                GoRouter.of(context).pushReplacementNamed(AppRouter.pageViewModel);
              }
            },
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //First three Rows of Text presentation of the title headline and text
                      const WelcomeText(
                          title: "Jôbizz",
                          headline: "Registration 👍",
                          text: "Let’s Register. Apply to jobs!"),
                      const SizedBox(height: 30),

                      //TextFileds for name email password and confirm pass
                      StyledTextField(
                          hint: "Full Name",
                          icon: Icons.person_outlined,
                          controller: _fullNameController),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 16),
                      StyledTextField(
                        hint: "Confirm Password",
                        icon: Icons.lock_outlined,
                        isPassword: true,
                        controller: _confirmPasswordController,
                        password: _passwordController,
                      ),
                      const SizedBox(height: 15),

                      //cubit
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 15.0),
                                child: Center(
                                  child: LinearProgressIndicator(
                                    color: Color.fromARGB(255, 53, 104, 153),
                                  ),
                                ),
                              ),
                            );
                          } else if (state is AuthError) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    state.errorMessage.toString(),
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                //Button to Register
                                StyledButton(
                                    onPressed: () {
                                      if (registerCheck()) {
                                        BlocProvider.of<AuthCubit>(context)
                                            .signUp(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          fullName: _fullNameController.text,
                                        );
                                      }
                                    },
                                    text: "Register")
                              ],
                            );
                          } else {
                            return //Button to Register
                                StyledButton(
                                    onPressed: () {
                                      if (registerCheck()) {
                                        BlocProvider.of<AuthCubit>(context)
                                            .signUp(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          fullName: _fullNameController.text,
                                        );
                                      }
                                    },
                                    text: "Register");
                          }
                        },
                      ),

                      const SizedBox(height: 30),

                      //Text between two lines
                      const TextBetweenDivider(text: "Or continue with"),
                      const SizedBox(height: 30),

                      //Row for the Google and facebook Login
                      const GoogleFacebookSign(),
                      const SizedBox(height: 50),

                      //Row with Text and TextButton for navigation to Login screen
                      const StyledTextNavigationToFromSignin(
                          headText: "Haven an account?", tailText: 'Log in'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
