
import 'package:flutter/material.dart';
import 'package:flutterecommerceapp/Views/Feature/Cart/orders_screen.dart';
import 'package:flutterecommerceapp/Views/Feature/User/Screen/user_login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => UserLoginScreen(),


    ),




  ],
);


class NavigationHelper{
  static void push(BuildContext context,Widget screen){
    Navigator.push(context,MaterialPageRoute(builder:
    (context) => screen));
  }

  static void pushNamed(
      BuildContext context,
      String routeName,{
        Object? arguments,

  }
  ){
    Navigator.pushNamed(context, routeName,
    arguments: arguments);

  }
//   Replace current screen
static void pushReplacement(BuildContext context,Widget screen){
    Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) =>
    screen),

    );
}

// Pop the current Screen
  static void pop(BuildContext context,{dynamic result}){
Navigator.pop(context,result);

  }

// Push and remove all previous screen
static void pushAndRemoveUntil(BuildContext context,Widget screen){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder:(
      context
      ) => screen),
        (route) => false,

    );

}


}