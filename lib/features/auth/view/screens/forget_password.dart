import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/forget_password_column.dart';
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
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 250, 250, 253),
        appBar: AppBar(),
        body: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 40),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AuthError) {
                  return ForgetPasswordColumn(
                    errorMessage: state.errorMessage,
                  );
                } else {
                  return Column(
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
                      const Expanded(child: SizedBox()),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 242, 246, 253),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: FilledButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.white)),
                            onPressed: () {},
                            child: const Text(
                              "E-mail",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 13, 13, 38)),
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      StyledTextField(
                          hint: "E-mail",
                          icon: Icons.mail_outline_outlined,
                          controller: _resetController),
                      const Expanded(child: SizedBox()),
                      const Expanded(child: SizedBox()),
                      SizedBox(
                          width: double.infinity,
                          child: StyledButton(
                            onPressed: () {
                              if (validation()) {
                                BlocProvider.of<AuthCubit>(context)
                                    .resetPassword(
                                        email: _resetController.text,
                                        context: context);
                              }
                            },
                            text: "Send Code",
                          )),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
