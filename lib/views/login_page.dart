

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubits/mode_cubit/mode_cubit.dart';
import 'package:notes/views/notes_view.dart';
import 'package:notes/views/resgister_page.dart';
import 'package:notes/views/widgets/custom_button.dart';
import 'package:notes/views/widgets/custom_text_field.dart';
import 'package:notes/views/widgets/show_snack_bar.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  static String id = 'login page';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailCon=TextEditingController();
  TextEditingController passwordCon=TextEditingController();
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  String? email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(onPressed: (){
            return BlocProvider.of<ModeCubit>(context).changeMode();
          },
            icon: Icon(Icons.ac_unit_sharp),
            label: Text("Mode") ,
          )
        ],
      ),
      //backgroundColor: Colors.brown,,
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
                    'LOGIN',
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
                controller:emailCon ,
                onChanged: (data) {
                  email = data;
                },

                hintText: 'Email',
              ),
              SizedBox(
                height: 10,
              ),
              CustomFormTextField(

                controller:passwordCon ,
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
                      await loginUser(email, password);
                      Navigator.pushNamed(context, NotesView.id,
                          arguments: email);
                    } on FirebaseAuthException catch (ex) {
                      if (ex.code == 'user-not-found') {
                        showSnackBar(context, 'user not found');
                      } else if (ex.code == 'wrong-password') {
                        showSnackBar(context, 'wrong password');
                      }
                    } catch (ex) {
                      print(ex);
                      showSnackBar(context, 'there was an error');
                    }

                    isLoading = false;
                    setState(() {});
                  } else {}
                },
                text: 'LOGIN',
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'dont\'t have an account?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                    child: Text(
                      '  Register',

                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> loginUser() async {
  //   UserCredential user = await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: email!, password: password!);
  // }
  Future<void> loginUser( emailAddress, password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
