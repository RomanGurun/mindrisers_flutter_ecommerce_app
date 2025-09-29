// import 'package:ecommerceapi/pages/home_page.dart';
// import 'package:ecommerceapi/pages/home_page.dart';
// import 'package:ecommerceapi/routes/route_enum.dart';
// import 'package:go_router/go_router.dart';
// import 'package:ecommerceapi/pages/meal_page.dart';
// import 'package:ecommerceapi/pages/suggestion_page.dart';
// import 'package:ecommerceapi/pages/user_page.dart';

//
// final router = GoRouter(
//     routes:[
//       GoRoute(
//         path: '/',
//         builder: (context,state){
//           return HomePage();
//
//         },
//         // routes: [
//         //   GoRoute(path: '/meal-page',
//         //   name:AppRoute.meal.name,
//         //     builder: (context,stateok){
//         //     return MealPage(title: stateok.extra as String);
//         //     }
//         //   )
//         // ]
//         //
//
//       ),
//       GoRoute(
//           path: '/meal-page',
//           name:AppRoute.meal.name,
//           builder: (context,stateok){
//             return MealPage(title: stateok.extra as String);
//           }
//       ),
//
//
//
//       GoRoute(
//           path:'/suggestionpage',
//           name:AppRoute.ecommerce.name,
//           builder:(context,state){
//             return SuggestionPage();
//           }
//       ),
//
//       GoRoute(
//           path:'/userpage',
//           name:AppRoute.userpage.name,
//           builder: (context,state){
//             return UserPage();
//           }
//       ),
//
//     ]
// );



import 'package:flutter/material.dart';
import 'package:flutterecommerceapp/Feature/User/Screen/user_login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:ecommerceapi/pages/home_page.dart';
// import 'package:ecommerceapi/pages/meal_page.dart';
// import 'package:ecommerceapi/pages/suggestion_page.dart';
// import 'package:ecommerceapi/pages/user_page.dart';
// import 'package:ecommerceapi/routes/route_enum.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => UserLoginScreen(),
      // routes: [
      //   GoRoute(
      //     path: 'meal-page',
      //     name: AppRoute.meal.name,
      //     builder: (context, state) {
      //       final title = state.extra as String? ?? 'Meal';
      //       return MealPage(title: title);
      //     },
      //   ),
      //   GoRoute(
      //     path: 'suggestionpage',
      //     name: AppRoute.ecommerce.name,
      //     builder: (context, state) => SuggestionPage(),
      //   ),
      //   GoRoute(
      //     path: 'userpage',
      //     name: AppRoute.userpage.name,
      //     builder: (context, state) => UserPage(),
      //   ),
      // ],
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