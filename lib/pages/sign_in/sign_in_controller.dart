import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_blocs.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  Future<void> handleSignIn(String type) async{
    try{
      if(type == "email"){
        //BlocProvider.of<SignInBloc>(context).state
        final state = context.read<SignInBloc>().state;
        String emailAddress =state.email;
        String password = state.password;
        if(emailAddress.isEmpty){
          //
          print("email empty");
        }
        if(password.isEmpty){
          //
          print("password empty");
        }
        try{
          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailAddress, password: password);
          if(credential.user == null){
            //
            print("user does not exist");
          }
          if(!credential.user!.emailVerified){
            //
            print("email not verified");
          }

          var user = credential.user;
          if(user != null){
            // we got verified user from firebase
            print("user exist");
          }
          else{
            // we have error getting user from firebase
            print("no user");
          }
        }on FirebaseAuthException catch(e){
          // if(e.code == 'user-not-found'){
          //   print("No user found for that email");
          // }
          // else if(e.code == 'wrong-password'){
          //   print('Wrong password provided for that user');
          // }
          // if(e.code == 'invalid-email'){
          //   print("Your email format is wrong");
          // }
          print("The occouring error is : ${e.toString()}");
        }
      }
    }catch(e){
      print("The error message $e");
    }
  }
}
