import 'package:flutter/material.dart';

class StyledTextField extends StatefulWidget {

  

  const StyledTextField({
    required this.hint,
    required this.icon,
    this.isPassword,
    this.controller,
    super.key});


  final String hint;
  final IconData icon;
  final bool? isPassword;
  final TextEditingController? controller;

  @override
  State<StyledTextField> createState() => _StyledTextFieldState();
}

class _StyledTextFieldState extends State<StyledTextField> {

  bool? isPasswordChecker;

  final _formKey = GlobalKey<FormState>();

  void validation(){
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context);
      }
   }

  @override
  Widget build(BuildContext context) {

    isPasswordChecker = isPasswordChecker ?? (widget.isPassword == true? true : false);

    return TextFormField(
    
      controller: widget.controller,
  
    
       validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ${widget.hint}';
            }
            else if (value.length < 3) {
              return 'Please enter at least 3 in ${widget.hint}';
            }
            else if(widget.hint == "E-mail" && !value.contains('.com')){
              return "Invalid Email";
            }
            else if(widget.hint == "Password" && value.length < 8){
              return "${widget.hint} must be more than 8 letters";
            }
            else if(widget.hint == "Confirm Password" && value.length < 8){
              return ("Doesn't match");
            }
            return null;
          },
    
      obscureText: isPasswordChecker!,
      
      decoration: InputDecoration(
    
        hintText: widget.hint,
    
        labelStyle: const TextStyle(color: Color.fromARGB(255, 13, 13, 38), fontSize: 14),
    
    
        hintStyle: const TextStyle(color: Color.fromARGB(255, 175, 176, 182), fontSize: 14),
    
    
        prefixIcon: Icon(widget.icon),
    
    
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color:Color.fromARGB(102, 175, 176, 182)),
          ),
        
        
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color.fromARGB(255, 13, 13, 38)),
          ),
        
        suffixIcon: widget.isPassword == true ? IconButton(
          icon: Icon(
            isPasswordChecker! ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: (){
            setState(() {isPasswordChecker = !isPasswordChecker!;});
          }
        ):const SizedBox(),
    
    
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    
    
        ),
    
      );
  }
}