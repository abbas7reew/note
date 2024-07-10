import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/views/login_page.dart';
import 'package:notes/views/widgets/custom_button.dart';
import 'package:notes/views/widgets/custom_text_field.dart';
import 'package:notes/views/widgets/show_snack_bar.dart';




class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.brown,
        body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Form(
    key: formKey,
    child: ListView(
    children: [
    SizedBox(
    height: 75,
    ),

    Row(
    children: [
    Text(
    'Regester',
    style: TextStyle(
    fontSize: 24,
    color: Colors.white,
    ),
    ),
    ],
    ),
    const SizedBox(
    height: 20,
    ),
    CustomFormTextField(
    onChanged: (data) {
    email = data;
    },

    hintText: 'Email',
    ),
    SizedBox(
    height: 10,
    ),
    CustomFormTextField(

    obscureText: true,
    onChanged: (data) {
    password = data;
    },
    hintText: 'Password',
    ),
    SizedBox(
    height: 20,
    ),
              CustomButon(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});
                    try {
                      await loginUser(email,password);

                      Navigator.pushNamed(context, LoginPage.id);
                    } on FirebaseAuthException catch (ex) {
                      if (ex.code == 'weak-password') {
                        showSnackBar(context, 'weak password');
                      } else if (ex.code == 'email-already-in-use') {
                        showSnackBar(context, 'email already exists');
                      }
                    } catch (ex) {
                      showSnackBar(context, 'there was an error');
                    }

                    isLoading = false;
                    setState(() {});
                  } else {}
                },
                text: 'REGISTER',
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'already have an account?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context,LoginPage.id);
                    },
                    child: Text(
                      '  Login',
                      style: TextStyle(
                        color: Color(0xffC7EDE6),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),);
  }

  // Future<void> loginUser() async {
  //   UserCredential user = await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: email!, password: password!);
  // }

  Future<void> loginUser(email,password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}