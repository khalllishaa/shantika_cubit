import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../config/constant.dart';
import '../firebase_options.dart';
import 'firebase_database.dart';

class FirebaseGoogleAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseDatabaseSender _firebaseDatabaseSender = FirebaseDatabaseSender();
  Future<void> signInWithGoogle({
    required Function(String uid, String email, String firstName, String lastName) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      try {
        _googleSignIn.signOut();
      } catch (e) {
        null;
        print(e);
        onError(e.toString());
      }

      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount == null) {
        onError("");
        _firebaseDatabaseSender.sendErrorMessageLog(message: "tidak memilih email", stackTrace: "tidak memilih email");
        return;
      }
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      if (userCredential.user?.uid == null) {
        onError('User id is empty');
        _firebaseDatabaseSender.sendErrorMessageLog(message: "empty user id", stackTrace: "empty user id");
        return;
      }

      final displayName = userCredential.user?.displayName ?? "";
      final nameParts = displayName.split(' ');
      final firstName = nameParts.first;
      final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : "";

      onSuccess(userCredential.user!.uid, googleSignInAccount.email, firstName, lastName);
    } catch (error) {
      if (error is FirebaseAuthException) {
        _firebaseDatabaseSender.sendErrorMessageLog(
          message: error.message ?? "",
          stackTrace: error.stackTrace.toString(),
        );
      }
      print(error.toString());
      onError(error.toString());
    }
  }

  Future<GoogleSignInAccount?> getGoogleAccount() async {
    try {
      try {
        _googleSignIn.signOut();
      } catch (e) {
        null;
      }

      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      return googleSignInAccount;
    } catch (error) {
      if (error is FirebaseAuthException) {
        _firebaseDatabaseSender.sendErrorMessageLog(
            message: error.message ?? "", stackTrace: error.stackTrace.toString());
      }
      return null;
    }
  }

  Future<void> linkWithGoogle(
      {required Function(String email) onSuccess,
      required Function(String message) onError,
      required GoogleSignInAccount account}) async {
    try {
      final GoogleSignInAuthentication googleSignInAuthentication = await account.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final userCredential = await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
        if (userCredential != null) {
          onSuccess(account.email);
        }
      } on FirebaseAuthException catch (e) {
        _firebaseDatabaseSender.sendErrorMessageLog(message: e.message ?? "", stackTrace: e.stackTrace.toString());
        switch (e.code) {
          case "provider-already-linked":
            {
              await FirebaseAuth.instance.currentUser?.unlink("google.com");
              linkWithGoogle(onSuccess: onSuccess, onError: onError, account: account);
            }
            return;
          case "invalid-credential":
            onError("The provider's credential is not valid.");
            break;
          case "credential-already-in-use":
            try {
              final secondaryApp = await Firebase.initializeApp(
                  name: firebaseSecondaryApp, options: DefaultFirebaseOptions.currentPlatform);
              final secondaryAuth = FirebaseAuth.instanceFor(app: secondaryApp);
              final GoogleSignInAuthentication googleSignInAuthentication = await account.authentication;
              GoogleAuthProvider.credential(
                accessToken: googleSignInAuthentication.accessToken,
                idToken: googleSignInAuthentication.idToken,
              );
              await secondaryAuth.currentUser?.delete();
              linkWithGoogle(onSuccess: onSuccess, onError: onError, account: account);
            } catch (e) {
              onError(e.toString());
            }

            break;
          // See the API reference for the full list of error codes.
          default:
            onError("Unknown error.");
        }
      }
    } catch (error) {
      if (error is FirebaseAuthException) {
        _firebaseDatabaseSender.sendErrorMessageLog(
          message: error.message ?? "",
          stackTrace: error.stackTrace.toString(),
        );
      }
      onError(error.toString());
    }
  }
}
