// We use a State provider under this provider folder ........



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutterecommerceapp/Models/UserModel/auth_model.dart';
class AuthFormNotifer extends StateNotifier<AuthFormState>{

AuthFormNotifer():super(AuthFormState());
void toggglePasswordVisibility(){
  state = state.copyWith(isPasswordHidden : ! state.isPasswordHidden);

}

void updateName(String name){
  String? nameError;
  if(name.isNotEmpty && name.length <6){
    nameError ="Provide your full name";

  }
  state = state.copyWith(name:name,nameError:nameError);

}

void updateEmail(String email){
  String? emilError;
  if(email.isNotEmpty &&
  !RegExp(r'^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,4}$').hasMatch(email)){
 emilError = 'Enter a valid email';


  }
  state = state.copyWith(email:email,emailError:emilError);

}

void updatePassword(String password){
  String? passwordError;
  if(password.isNotEmpty && password.length <6){
    passwordError = 'Password must be at least 6 characters';

  }
  state = state.copyWith(password: password,passwordError: passwordError);

}
void setLoading(bool isLoading){
  state = state.copyWith(isLoading: isLoading);

}
}

final authFormProvider = StateNotifierProvider<AuthFormNotifer,AuthFormState>(
    (ref){
      return AuthFormNotifer();

    },
);