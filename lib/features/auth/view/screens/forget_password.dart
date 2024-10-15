//forgetpassword

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_button.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_textField.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/welcome_text.dart';
import 'package:jop_finder_app/features/auth/viewmodel/cubit/auth_cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool validation() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _resetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Container(
        color: AppColors.primaryBlue,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            backgroundColor: AppColors.myWhiteBackground,
            body: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Email password reset link sent!')));
                  GoRouter.of(context).pushReplacementNamed(AppRouter.login);
                }
              },
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 20, right: 20, bottom: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const WelcomeText(
                            title: "Jôbizz",
                            headline: "Forgot Password",
                            text:
                                "Enter your email or phone number, we will send you verification code",
                            crossAxisAlignment: "center",
                            innerPadding: 30,
                          ),
                          const SizedBox(height: 30),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 242, 246, 253),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: FilledButton(
                                style: const ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        AppColors.myWhite)),
                                onPressed: () {},
                                child: const Text(
                                  "E-mail",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.primaryText),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          StyledTextField(
                              hint: "E-mail",
                              icon: Icons.mail_outline_outlined,
                              controller: _resetController),
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
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      state.errorMessage.toString(),
                                      style: const TextStyle(
                                          color: AppColors.myRed),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  StyledButton(
                                    onPressed: () {
                                      if (validation()) {
                                        BlocProvider.of<AuthCubit>(context)
                                            .resetPassword(
                                          email: _resetController.text,
                                        );
                                      }
                                    },
                                    text: "Send Code",
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  const SizedBox(height: 30),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: StyledButton(
                                          onPressed: () {
                                            if (validation()) {
                                              BlocProvider.of<AuthCubit>(
                                                      context)
                                                  .resetPassword(
                                                email: _resetController.text,
                                              );
                                            }
                                          },
                                          text: "Send Code",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                          }),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
