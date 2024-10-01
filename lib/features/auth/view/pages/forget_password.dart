import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/auth/view/pages/shared/styled_textField.dart';
import 'package:jop_finder_app/features/auth/view/pages/shared/welcome_text.dart';
import 'package:jop_finder_app/features/auth/viewmodel/cubit/auth_cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool validation() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email sent if Exists!')),
      );
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
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AuthError) {
                  return Center(
                    child: Text(state.errorMessage),
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
                      Expanded(child: SizedBox()),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 242, 246, 253),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: FilledButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.white)),
                            onPressed: () {},
                            child: Text(
                              "E-mail",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 13, 13, 38)),
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      StyledTextField(
                          hint: "E-mail",
                          icon: Icons.mail_outline_outlined,
                          controller: _resetController),
                      Expanded(child: SizedBox()),
                      Expanded(child: SizedBox()),
                      Container(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            if (validation()) {
                              BlocProvider.of<AuthCubit>(context)
                                  .resetPassword(email: _resetController.text);
                            }
                          },
                          style: const ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                                Color.fromARGB(255, 53, 104, 153)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Send Code",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
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
