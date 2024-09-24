import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/auth/view/pages/shared/styled_textField.dart';
import 'package:jop_finder_app/features/auth/view/pages/shared/welcome_text.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 253),
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const WelcomeText(title: "Jôbizz", headline: "Forgot Password", text: "Enter your email or phone number, we will send you verification code", crossAxisAlignment: "center", innerPadding: 30,),
              
              Expanded(child: SizedBox()),

              Container(
                padding: const EdgeInsets.symmetric(vertical: 3,  horizontal: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 242, 246, 253),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: FilledButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white)
                  ),
                  onPressed: (){} , 
                  child: Text("E-mail", style: TextStyle(fontSize: 13 ,color: Color.fromARGB(255, 13, 13, 38) ),)),
              ),
              SizedBox(height: 30,),
          
              
              StyledTextField(hint: "E-mail", icon: Icons.mail_outline_outlined, controller: _emailController),



              Expanded(child: SizedBox()),
              Expanded(child: SizedBox()),


              Container(
                width: double.infinity,
                child: FilledButton(
                  
                  onPressed: () {
                    
                        if (_formKey.currentState!.validate()) {
                        if (_emailController.text.contains(".com")) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Email sent if Exists!')),
                            );
                          }
                        }
                      
                      
                  },
                  style: const ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 53, 104, 153)),
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
          ),
        ),
      ),
    );
  }
}