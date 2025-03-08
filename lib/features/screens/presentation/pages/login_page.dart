import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppie_well/core/utils/common_button.dart';
import 'package:shoppie_well/features/screens/presentation/pages/signup_page.dart';
import '../services/auth_service.dart';
import 'get_start_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    var user = await _authService.signInWithEmail(
      emailController.text,
      passwordController.text,
    );
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GetStartPage()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login Failed')));
    }
  }

  void _loginWithGoogle() async {
    var user = await _authService.signInWithGoogle();
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GetStartPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Welcome \nBack!',
                style: TextStyle(
                  fontSize: 38.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                filled: true,
                hintText: 'test@gmail.com',
                hintStyle: const TextStyle(
                  color: Color(0xff6A6A6A),
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.2, color: Colors.red),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.2, color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.2, color: Colors.red),
                ),
                fillColor: const Color(0xffF7F7F9),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
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
            const SizedBox(height: 100),
            ConfirmButton(onTap: _login, text: 'Login'),

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
            Spacer(),
            _signup(context),
          ],
        ),
      ),
    );
  }
  Widget _signup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              children: [
                 TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                      color: Color(0xff6A6A6A),
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp
                  ),
                ),
                TextSpan(
                    text: "Sign Up For Free",
                    style:  TextStyle(
                        color: Color(0xff1A1D1E),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Signup()
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
