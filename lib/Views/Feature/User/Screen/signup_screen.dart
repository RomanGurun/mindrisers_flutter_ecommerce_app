import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user_login_screen.dart';
import 'package:flutterecommerceapp/ViewController/Repository/Service/auth_provider.dart';
import 'package:flutterecommerceapp/ViewController/Repository/Service/auth_service.dart';
// import 'package:flutterecommerceapp/Widgets/my_button.dart';

import 'package:flutterecommerceapp/Wigdets/my_button.dart';
import 'package:flutterecommerceapp/Routes/app_routes.dart';
import 'package:flutterecommerceapp/common/Colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutterecommerceapp/Views/app_home_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends ConsumerState<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(authFormProvider);
    final formNotifier = ref.read(authFormProvider.notifier);
    final authMethod = ref.read(authMethodProvider);
    void signup() async{
      formNotifier.setLoading(true);
      final res = await authMethod.signUpUser(
          email:formState.email ,
          password: formState.password,
          name: formState.name,);
formNotifier.setLoading(false);
if(res == "success"){
  NavigationHelper.pushReplacement(context, UserLoginScreen());
  mySnackBar(
    message:"Signup Up Successful. Now turn to Login",
    context:context
  );

}else{
  mySnackBar(message:res,context:context);

}

    }
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: height / 2.4,
              width: double.maxFinite,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: shadowColor, blurRadius: 15, spreadRadius: 20),
                ],
              ),

              child: Image.asset("assets/Tipos de comércio electrónico_0.png", fit: BoxFit.cover),
            ),

            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [

                  TextField(
                    autocorrect: false,
                    onChanged: (value) =>  formNotifier.updateName(value),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Enter your name",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(15),
                      errorText: formState.nameError
                    ),
                  ),

                  SizedBox(height: 15),







                  TextField(
                    autocorrect: false,
                    onChanged: (value)=> formNotifier.updateEmail(value),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Enter your email",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(15),
                      errorText: formState.emailError
                    ),
                  ),

                  SizedBox(height: 15),
                  TextField(
                    autocorrect: false,
                    obscureText: formState.isPasswordHidden,

                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) => formNotifier.updatePassword(value),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),

                      labelText: "Enter your password",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(15),
                      errorText: formState.passwordError,
                      suffixIcon: IconButton(
                        onPressed: ()=> formNotifier.toggglePasswordVisibility(),
                        icon:Icon(
                          formState.isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,

                        ),

                      )
                    ),
                  ),
                  SizedBox(height: 20,),
                  formState.isLoading
                  ?Center(child: CircularProgressIndicator(),)
                  :

                  MyButton(onTab: formState.isFormValid ? signup :null,

                      buttonText: "Sign Up"

                  ),
                  SizedBox(height: 20,),
                  Row(children: [
                    Spacer(),

                    Text("Already have an account?"),
                    GestureDetector(
                      onTap: (){
                        NavigationHelper.push(context,UserLoginScreen());

                      },

                      child: Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),


                  ],),



                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
