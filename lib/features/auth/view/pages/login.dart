import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jop_finder_app/features/auth/view/pages/shared/styled_textField.dart';
import 'package:jop_finder_app/features/auth/view/pages/signin.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();

   // Create controllers for the TextFields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                const Text(
                  "Jôbizz", 
                  style: TextStyle(
                    color: Color.fromARGB(255, 53, 104, 153),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
                const SizedBox(height: 3),
                const Text(
                  "Welcome Back 👋",
                  style: TextStyle(
                    color: Color.fromARGB(255, 13, 13, 38),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Let’s log in. Apply to jobs!",
                  style: TextStyle(
                    color: Color.fromARGB(102, 13, 13, 38),
                    fontSize: 14,
                  ),
                ),
            
                const SizedBox(height: 50),
            
                
                StyledTextField(hint: "E-mail", icon: Icons.mail_outline_outlined, controller: _emailController),
                const SizedBox(height: 16),
                StyledTextField(hint: "Password", icon: Icons.lock_outlined, isPassword: true, controller: _passwordController),
                const SizedBox(height: 30),
                
            
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_passwordController.text == "password") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login Successful!')),
                          );
                        }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                           content: Text("Password not correct"),
                           ),
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
                      "Login",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 30),


                TextButton(
                  onPressed: (){}, 
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Color.fromARGB(255, 53, 104, 153),
                        fontSize: 13,
                      ),
                    )
                  ),

                
                const SizedBox(height: 30,),


                const Row(
                  children: [
                    Expanded(child: Divider(thickness: 1.0)),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(
                          color: Color.fromARGB(255, 175, 176, 182),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(thickness: 1.0)),
                  ],
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    SvgPicture.asset(
                        'assets/images/google.svg',
                        width: 30,
                        height: 30,
                      ),
                    const Icon(Icons.facebook, color: Colors.blue, size: 38,),
                    SizedBox(),
                  ],
                ),


                const SizedBox(height: 30),


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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Registeration()));
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
