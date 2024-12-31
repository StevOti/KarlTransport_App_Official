import 'package:firebase_auth/firebase_auth.dart';
import 'package:karltransportapp/data/firestore.dart';

abstract class AuthenticationDataSource {
  Future<void> register(String email, String password, String passwordConfirm);
  Future<void> login(String email, String password);
}

class AuthenticationRemote extends AuthenticationDataSource{
  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
  }

  @override
  Future<void> register(String email, String password, String passwordConfirm) async{
    if(passwordConfirm == password) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.trim(), password: password.trim()).then((value) => {
        FirestoreDatasource().createUser(email),
      });
    } else {
      throw Exception('Passwords do not match');
    }
  }

}