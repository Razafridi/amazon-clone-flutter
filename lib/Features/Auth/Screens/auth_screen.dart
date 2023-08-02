import 'package:amazon_app/Features/Auth/Widgets/login.dart';
import 'package:amazon_app/Features/Auth/Widgets/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum Selected {
  login,
  register,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  Selected selected = Selected.login;

  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //App Bar
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Colors.black87,
              child: Text(
                "Amazon",
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),

            Container(
              color: selected == Selected.login
                  ? Colors.white
                  : Colors.grey.shade300,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Radio(
                      value: selected,
                      groupValue: Selected.login,
                      onChanged: (e) {
                        setState(() {
                          selected = Selected.login;
                        });
                      }),
                  Text(
                    "Login",
                    style: GoogleFonts.raleway(fontSize: 17),
                  ),
                ],
              ),
            ),
            //Login
            if (selected == Selected.login)
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Login(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
              ),

            ///Register
            Container(
              color: selected == Selected.register
                  ? Colors.white
                  : Colors.grey.shade300,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Radio(
                      value: selected,
                      groupValue: Selected.register,
                      onChanged: (e) {
                        setState(() {
                          selected = Selected.register;
                        });
                      }),
                  Text(
                    "Register",
                    style: GoogleFonts.raleway(fontSize: 17),
                  ),
                ],
              ),
            ),
            if (selected == Selected.register)
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: SignUp(
                    nameController: nameController,
                    emailController: emailController,
                    passwordController: passwordController),
              ),
          ]),
        ),
      ),
    );
  }
}
