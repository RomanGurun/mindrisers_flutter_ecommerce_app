import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthMethod{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

Future<String> signUpUser({
    required String email,
  required String password,
  required String name,

})async{
  try{
    if(email.isEmpty || password.isEmpty || name.isEmpty){
      return "Please enter all fields";
    }
    UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,);

    // store created user
    await _firestore.collection("users").doc(cred.user!.uid).set({
      "name":name,
      "uid":cred.user!.uid,
      "email":email,
      "createdAt":FieldValue.serverTimestamp(),


    });

return "sucess";
  }catch(e){
    print(e.toString());
    return e.toString();

  }

}

// login
  Future<String> loginUser({
    required String email,
    required String password,

  })async{
    try{
      if(email.isEmpty || password.isEmpty){
        return "Please enter all fields";
      }
     await _auth.signInWithEmailAndPassword(
         email: email,
         password: password);

      return "success";
    }catch(e){
      print(e.toString());
      return e.toString();

    }

  }



//logout
Future<void> signOut()async{
  await _auth.signOut();
}
}
final authMethodProvider = Provider<AuthMethod>((ref){
  return AuthMethod();
});