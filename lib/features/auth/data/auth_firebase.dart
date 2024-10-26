import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  // Đăng nhập với Google
  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);

          final DatabaseReference userRef = _database.ref().child('users/${user.uid}');
          final DataSnapshot snapshot = await userRef.get();

          if (!snapshot.exists) {
            await userRef.set({
              'email': user.email,
              'createdAt': DateTime.now().toIso8601String(),
            });

            return {'user': user, 'isNewUser': true};
          } else {
            return {'user': user, 'isNewUser': false};
          }
        }
      }
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
    return null;
  }

  // Đăng xuất
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    // Xóa trạng thái đăng nhập
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  // Kiểm tra trạng thái đăng nhập
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // Lấy thông tin người dùng hiện tại
  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }
}
