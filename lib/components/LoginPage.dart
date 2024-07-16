import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/components/MapSample.dart';
import 'package:provider/components/RegisterPage.dart';
import 'package:provider/components/SearchLocation.dart';

class LoginPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: 50,
              height: 50,
              child: Icon(Icons.menu),
            ),
          ),
          const Text(
            ".Login \n Login para \nter acesso ao app",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: nameController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Name',
            ),
          ),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: emailController,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'Email',
            ),
          ),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: passwordController,
            decoration: const InputDecoration(
              icon: Icon(Icons.visibility),
              labelText: 'Password',
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                //cadastro
                cadastraUser(context);
              },
              child: Container(
                color: Colors.white,
                width: 200,
                height: 50,
                child: Center(
                  child: Text("cadastrar"),
                ),
              ),
            ),
          ),
          Center(
              child: Text("ja tem conta?Login",
                  style: TextStyle(color: Colors.white)))
        ],
      ),
    );
  }

  cadastraUser(context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //entrar
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MapSample()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("password smaller"),
        ));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
