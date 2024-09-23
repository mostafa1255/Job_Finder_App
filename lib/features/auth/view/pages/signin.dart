import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jop_finder_app/features/auth/view/pages/login.dart';
import 'package:jop_finder_app/features/auth/view/pages/shared/styled_textField.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blue, // Change the cursor color to blue
          selectionColor: Colors.blue.withOpacity(0.4), // Text selection color (highlight)
          selectionHandleColor: Colors.blue, // The tear drop color
          ),
        ),
      home: const Login(),
    );
  }
}

class Registeration extends StatefulWidget {
  const Registeration({super.key});

  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {

  final _formKey = GlobalKey<FormState>();

   // Create controllers for the TextFields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void validation(){
    
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
                  "Registration 👍",
                  style: TextStyle(
                    color: Color.fromARGB(255, 13, 13, 38),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Let’s Register. Apply to jobs!",
                  style: TextStyle(
                    color: Color.fromARGB(102, 13, 13, 38),
                    fontSize: 14,
                  ),
                ),
            
                const SizedBox(height: 30),
            
                StyledTextField(hint: "Full Name", icon: Icons.person_outlined, controller: _fullNameController),
                const SizedBox(height: 16),
                StyledTextField(hint: "E-mail", icon: Icons.mail_outline_outlined, controller: _emailController),
                const SizedBox(height: 16),
                StyledTextField(hint: "Password", icon: Icons.lock_outlined, isPassword: true, controller: _passwordController),
                const SizedBox(height: 16),
                StyledTextField(hint: "Confirm Password", icon: Icons.lock_outlined, isPassword: true, controller: _confirmPasswordController),
                const SizedBox(height: 30),
            
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_confirmPasswordController.text == _passwordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Registration Successful!')),
                          );
                        }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                           content: Text("Password doesn't match"),
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
                      "Register",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),


                const SizedBox(height: 30),


                


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
                const SizedBox(height: 30),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
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
                        "Have an account?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 175, 176, 182),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to login screen
                        Navigator.pop(context, MaterialPageRoute(builder: (context) => const Login()));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        "Log in",
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
