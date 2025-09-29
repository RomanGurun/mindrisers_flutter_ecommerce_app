import 'package:flutter/material.dart';
import 'package:flutterecommerceapp/Feature/User/Screen/user_login_screen.dart';
import 'package:flutterecommerceapp/Routes/app_routes.dart';
import '../Service/auth_service.dart';
AuthMethod authMethod = AuthMethod();

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(onPressed:
        (){
          authMethod.signOut();
NavigationHelper.pushReplacement(context,
UserLoginScreen());

        }, child:
        Text("Logout"),
        ),
      ),
    );
  }

}