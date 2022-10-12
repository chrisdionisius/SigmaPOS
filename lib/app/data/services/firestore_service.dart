import 'package:firebase_auth/firebase_auth.dart';

Future signInWithEmail(email, password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return 'success';
  } catch (e) {
    return e;
  }
}

// final FirebaseAuth _auth = FirebaseAuth.instance;
// String? name;
// String? email;

// Future<String> signIn(String email, String password) async {
//   await Firebase.initializeApp();
//   try {
//     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email, password: password);
//     final User user = userCredential.user!;
//     final uid = user.uid;
//     return '$uid';
//     // return "Signed in";
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'user-not-found') {
//       return 'No user found for that email.';
//     } else if (e.code == 'wrong-password') {
//       return 'Wrong password provided for that user.';
//     }
//     return e.message!;
//   }
// }

// Future<String> signInEmail(String emailInput, String password) async {
//   await Firebase.initializeApp();
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: emailInput, password: password);

//     final User? user = userCredential.user;

//     if (user != null) {
//       assert(user.email != null);
//       name = null;
//       email = user.email;
//       assert(!user.isAnonymous);
//       assert(await user.getIdToken() != null);
//       final User currentUser = _auth.currentUser!;
//       assert(user.uid == currentUser.uid);
//       // print('signInWithGoogle succeeded: $user');
//       return '$user';
//     }
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'user-not-found') {
//       return 'Failed to sign in with Email & Password: No user found for that email.';
//     } else if (e.code == 'wrong-password') {
//       // print('Wrong password provided for that user.');
//       return 'Failed to sign in with Email & Password: Wrong password provided for that user.';
//     }
//   }
//   return 'Failed to sign in with Email & Password';
// }

// Future<String> signUpEmail(String emailInput, String password) async {
//   try {
//     await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: emailInput, password: password);
//     return 'done';
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       // print('The password provided is too weak.');
//       return 'weak';
//     } else if (e.code == 'email-already-in-use') {
//       // print('The account already exists for that email.');
//       return 'exists';
//     }
//   } catch (e) {
//     return 'error';
//   }
//   return 'error';
// }
