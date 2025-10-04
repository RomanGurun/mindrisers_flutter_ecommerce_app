import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterecommerceapp/Feature/User/Screen/home_screen.dart';
import 'package:flutterecommerceapp/Feature/Widgets/my_button.dart';
import 'package:flutterecommerceapp/Routes/app_routes.dart';
import 'package:flutterecommerceapp/Views/Colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutterecommerceapp/Views/app_home_screen.dart';
import 'package:flutterecommerceapp/Feature/User/Screen/signup_screen.dart';
import 'package:flutterecommerceapp/Routes/app_routes.dart';
import 'package:flutterecommerceapp/Feature/User/Service/auth_provider.dart';
import 'package:flutterecommerceapp/Feature/User/Service/auth_service.dart';
import '../../../Views/app_main_screen.dart';


class UserLoginScreen extends ConsumerStatefulWidget {
  const UserLoginScreen({super.key});

  @override
  ConsumerState<UserLoginScreen> createState() => _UserLoginScreen();
}

class _UserLoginScreen extends ConsumerState<UserLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(authFormProvider);
    final formNotifier = ref.read(authFormProvider.notifier);
    final authMethod = ref.read(authMethodProvider);
    void login() async{
      formNotifier.setLoading(true);
      final res = await authMethod.loginUser(
        email:formState.email ,
        password: formState.password,
      );
      formNotifier.setLoading(false);
      if(res == "success"){
        NavigationHelper.pushReplacement(context, AppMainScreen());
        mySnackBar(
            message:"Login Successful. Now turn to Login",
            context:context
        );

      }else{
        mySnackBar(message:res,context:context);

      }
    }

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height / 2.3,
              width: double.maxFinite,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: shadowColor, blurRadius: 15, spreadRadius: 20),
                ],
              ),
        
              child: Image.asset("assets/advertise.jpg", fit: BoxFit.cover),
            ),
        
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    autocorrect: false,
        
                    onChanged: (value) => formNotifier.updateEmail(value),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
        
                      labelText: "Enter your email",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(15),
                      errorText:formState.emailError,
        
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
                  ? Center(child: CircularProgressIndicator())
          :
          MyButton(
            onTab:
        formState.isFormValid ? login : null,
            buttonText: "Login"
        
            ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(child:
                      Container(height: 1,
                      color:Colors.black26,),),
                      Text(" or "),
                      Expanded(child:
                      Container(height: 1,
                      color: Colors.black26,),),
        
                    ],
                  ),
                  Row(children: [
                    Spacer(),
        
                    Text("Don't have an account?"),
        GestureDetector(
        onTap: (){
          NavigationHelper.push(context,SignUpScreen());
        },
        
          child: Text(
            "SignUp",
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
void mySnackBar({required String message, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}
