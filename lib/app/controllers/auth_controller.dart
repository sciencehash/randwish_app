import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:randwish_app/app/core/utils/helpers/gravatar.dart';

import 'package:randwish_app/app/data/models/student.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onReady() async {
    // Note: this must be in onReady and not in onInit for
    // routing functions to find GetMaterialApp and work properly.

    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);

    firebaseUser.bindStream(watchUser);

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  handleAuthChanged(_firebaseUser) async {
    if (_firebaseUser == null) {
      //
      // Unauthenticated
      //

      // Uncomment this if you need mandatory sign in
      // Get.offAllNamed('/login');
    } else {
      //
      // Authenticated
      //

      // After sign in or sign up
      // Get.offNamed('/');
    }
  }

  // Firebase user one-time fetch
  Future<User?> get getUser async => _auth.currentUser;

  // Notifies about changes to any user updates.
  Stream<User?> get watchUser => _auth.userChanges();

  // Notifies about changes to the user's sign-in state
  // (such as sign-in or sign-out).
  Stream<User?> get watchUserState => _auth.authStateChanges();

  // Method to handle user sign in using email and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  // User registration using email and password
  Future<void> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((result) async {
      // Get photo url from gravatar if user has one
      Gravatar gravatar = Gravatar(email);
      String gravatarUrl = gravatar.imageUrl(
        size: 200,
        defaultImage: GravatarImage.retro,
        rating: GravatarRating.pg,
        fileExtension: true,
      );
      await _auth.currentUser!.updateProfile(
        displayName: name,
        photoURL: gravatarUrl,
      );
      update();
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
          scopes: ['https://www.googleapis.com/auth/userinfo.email']).signIn();

      if (googleUser != null) {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } else if (GetPlatform.isWeb) {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider.addScope('https://www.googleapis.com/auth/userinfo.email');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithPopup(googleProvider);

      // final UserCredential aa = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      // googleProvider.

      // Or use signInWithRedirect
      // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
    }
  }

  //handles updating the user when updating profile
  Future<void> updateUser(
      Student user, String oldEmail, String password) async {
    // try {
    //   // showLoadingIndicator();
    //   await _auth
    //       .signInWithEmailAndPassword(email: oldEmail, password: password)
    //       .then((_firebaseUser) {
    //     _firebaseUser.user!.updateEmail(user.email!).then(
    //       // (value) => _updateUserFirestore(user, _firebaseUser.user!),
    //       (value) {
    //         _studentProvider.update(user);
    //         update();
    //       },
    //     );
    //   });
    //   // hideLoadingIndicator();
    //   Get.snackbar('auth.updateUserSuccessNoticeTitle'.tr,
    //       'auth.updateUserSuccessNotice'.tr,
    //       snackPosition: SnackPosition.BOTTOM,
    //       duration: Duration(seconds: 5),
    //       backgroundColor: Get.theme.snackBarTheme.backgroundColor,
    //       colorText: Get.theme.snackBarTheme.actionTextColor);
    // } on PlatformException catch (error) {
    //   //List<String> errors = error.toString().split(',');
    //   // print("Error: " + errors[1]);
    //   // hideLoadingIndicator();
    //   print(error.code);
    //   String authError;
    //   switch (error.code) {
    //     case 'ERROR_WRONG_PASSWORD':
    //       authError = 'auth.wrongPasswordNotice'.tr;
    //       break;
    //     default:
    //       authError = 'auth.unknownError'.tr;
    //       break;
    //   }
    //   Get.snackbar('auth.wrongPasswordNoticeTitle'.tr, authError,
    //       snackPosition: SnackPosition.BOTTOM,
    //       duration: Duration(seconds: 10),
    //       backgroundColor: Get.theme.snackBarTheme.backgroundColor,
    //       colorText: Get.theme.snackBarTheme.actionTextColor);
    // }
  }

  //password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Sign out
  Future<void> signOut() {
    return _auth.signOut();
  }
}
