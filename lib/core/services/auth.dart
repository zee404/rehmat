import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> gmailSignIn() async {
    User user;
    final GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await _googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print('googleAuth.accessToken INSIDE gmailSignIn in auth: ' +
        googleAuth.accessToken.toString());
    print('googleAuth.idToken INSIDE gmailSignIn in auth: ' +
        googleAuth.idToken.toString());

    user = (await _auth.signInWithCredential(credential)).user;
    print("user inside gmailSignIn in auth: " + user.uid.toString());
    return user;
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> handleSignUpwithEmailAndPassword(email, password) async {
    var result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    return user;
  }
}
