import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppie_well/features/screens/presentation/pages/login_page.dart';

import '../../../../core/utils/common_button.dart';
import '../services/auth_service.dart';
import 'main_home_page.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  void _loginWithGoogle() async {
    var user = await _authService.signInWithGoogle();
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: _signin(context),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 50,
          leading: Icon(Icons.arrow_back_ios, color: Colors.black,),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Text(
                        'Create An Account',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 32.sp
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80,),
                _emailAddress(),
                const SizedBox(height: 20,),
                _password(),
                const SizedBox(height: 100),
                _signup(context),
                const SizedBox(height: 50),
                Text("- OR Continue with -"),
                SizedBox(height: 10),
                InkWell(
                  onTap: _loginWithGoogle,
                  child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.red.shade50,
                      child: Image.network("https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png")
                  ),
                ),
              ],
            ),

          ),
        )
    );
  }

  Widget _emailAddress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            filled: true,
            hintText: 'test@gmail.com',
            hintStyle: const TextStyle(
              color: Color(0xff6A6A6A),
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            fillColor: const Color(0xffF7F7F9),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.2, color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.2, color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.2, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  Widget _password() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            filled: true,
            hintText: 'ABC!@#123',
            hintStyle: const TextStyle(
              color: Color(0xff6A6A6A),
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            fillColor: const Color(0xffF7F7F9),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.2, color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.2, color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.2, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  Widget _signup(BuildContext context) {
    return ConfirmButton(
      onTap: () async {
        await AuthService().signup(
            email: _emailController.text,
            password: _passwordController.text,
            context: context
        );
      },
      text: "Sign Up",
    );
  }

  Widget _signin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              children: [
                 TextSpan(
                  text: "Already Have Account? ",
                  style: TextStyle(
                      color: Color(0xff6A6A6A),
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp
                  ),
                ),
                TextSpan(
                    text: "Log In",
                    style:  TextStyle(
                        color: Color(0xff1A1D1E),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()
                        ),
                      );
                    }
                ),
              ]
          )
      ),
    );
  }
}