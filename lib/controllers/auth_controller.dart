
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pet_app/models/user_model_firebase.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/snackbar_utilis.dart';
import 'package:pet_app/views/home_screens/home_screen.dart';
import 'package:pet_app/views/home_screens/nav_bar_screen.dart';
import 'package:pet_app/views/onboarding_screens.dart/login_screen.dart';

class AuthController extends GetxController {
  var userData = Rx<UserModel?>(null);
  //login
  TextEditingController loginemailController=TextEditingController();
  TextEditingController loginpasswordController=TextEditingController();
  //Login
    TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   TextEditingController confirmpasswordController = TextEditingController();
  var isChecked = false.obs;

  void toggleCheckbox(bool? value) {
    if (value != null) {
      isChecked.value = value;
    }
  }

  var isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (!validateFieldsSignin()) return;
    final email = loginemailController.text.trim();
    final password = loginpasswordController.text.trim();

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      SnackbarUtils.showCustomSnackbar(
          title: "Validation Error!",
          message: "Enter a valid email address",
          backgroundColor: primaryColor);

      return;
    }

    if (password.isEmpty || password.length < 6) {
      SnackbarUtils.showCustomSnackbar(
          title: "Validation Error!",
          message: "Password must be at least 6 characters",
          backgroundColor: primaryColor);

      return;
    }

    try {
        EasyLoading.show(status: 'Login Account...');

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await _firestore.collection("users").doc(userCredential.user?.uid).update({
          "image":"assets/images/pet1.png",
          "lastMessage":"hello",
          "unreadMessageCount":3,
          "time": "2 min ago",
          "isOnline":true,
        });
        Get.snackbar(
          "Login Success",
          "Successfully logged in",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          colorText:blackColor,
        );
      }
      Get.offAll(NavBarScreen());
       EasyLoading.showSuccess("Signup Success");
    } on FirebaseAuthException catch (e) {
         EasyLoading.showError(e.message ?? "Signup Failed");
      SnackbarUtils.showCustomSnackbar(
          title: "Login Failed",
          message: e.message ?? "An error occurred",
          backgroundColor: primaryColor);
    } catch (e) {
        EasyLoading.showError("Something went wrong");
      SnackbarUtils.showCustomSnackbar(
          title: "Error",
          message: "Something went wrong",
          backgroundColor:primaryColor);
    } finally {
        EasyLoading.dismiss();
      isLoading.value = false;
    }
  }




Future<void> signUp() async {
  if (!validateFieldsSignUp()) return;

  final name = nameController.text.trim();
  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  // Validation
  if (name.isEmpty) {
    EasyLoading.showError("Name cannot be empty");
    return;
  }

  if (email.isEmpty || !GetUtils.isEmail(email)) {
    EasyLoading.showError("Enter a valid email address");
    return;
  }

  if (password.isEmpty || password.length < 6) {
    EasyLoading.showError("Password must be at least 6 characters");
    return;
  }

  try {
    EasyLoading.show(status: 'Creating Account...');

    // Firebase Authentication
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;
    if (user != null) {
      // Store User Data in Firestore
      await _firestore.collection("users").doc(user.uid).set({
        "uid": user.uid,
        "name": name,
        "email": email,
        "createdAt": DateTime.now(),
      });
    await  fetchUserData(user.uid);
Get.to(LoginScreen());
      EasyLoading.showSuccess("Signup Success");
    }
  } on FirebaseAuthException catch (e) {
    EasyLoading.showError(e.message ?? "Signup Failed");
  } catch (e) {
    EasyLoading.showError("Something went wrong");
  } finally {
    EasyLoading.dismiss();
  }
}




  bool validateFieldsSignUp() {
    if (emailController.text.trim().isEmpty) {
      Get.snackbar("Oops!", "Email is required.");
      return false;
    }
    if (passwordController.text.trim().isEmpty) {
      Get.snackbar("Oops!", "Password is required.");
      return false;
    }
    if (nameController.text.trim().isEmpty) {
      Get.snackbar("Oops!", "name is required.");
      return false;
    }
     if (passwordController.text != confirmpasswordController.text) {
      Get.snackbar("Oops!", "password donot match");
      return false;
    }

    return true;
  }




  bool validateFieldsSignin() {
    if (loginemailController.text.trim().isEmpty) {
      Get.snackbar("Oops!", "Email is required.");
      return false;
    }
    if (loginpasswordController.text.trim().isEmpty) {
      Get.snackbar("Oops!", "Password is required.");
      return false;
    }
   

    return true;
  }


Future<bool> checkIfUserExists(String email) async {
  try {
    
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: 'temporary_password', // Use a dummy password
    );

  
    await credential.user?.delete();

    return false;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
   
      return true;
    } else {
    
      SnackbarUtils.showCustomSnackbar(
        title: "Error",
        message: "Failed to check user existence: ${e.message}",
        backgroundColor:primaryColor,
      );
      return false;
    }
  } catch (e) {
   
    SnackbarUtils.showCustomSnackbar(
      title: "Error",
      message: "Failed to check user existence: $e",
      backgroundColor:primaryColor,
    );
    return false;
  }
}

  // Future<void> handleUserAuth() async {
  //   if (!validateFieldsSignin()) return;
  //   final email = loginemailController.text.trim();

  //   try {
  //     isLoading.value = true;

  //     // Check if the user exists
  //     bool userExists = await checkIfUserExists(email);
  //     print("the email is exist is :$userExists");

  //     if (userExists) {
  //       await login();
  //     } else {
  //       await signUp();
  //     }
  //   } catch (e) {
  //     SnackbarUtils.showCustomSnackbar(
  //       title: "Error",
  //       message: "Something went wrong",
  //       backgroundColor: primaryColor,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }



  // Future<void> signOut() async {
  //   try {
  //     await _auth.signOut();
  //     Get.snackbar("Success", "You have been signed out",
  //         snackPosition: SnackPosition.TOP,
  //         backgroundColor: Themecolor.primary);

  //     Get.offAll(const GetStartedScreen());
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to sign out",
  //         snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
  //   }
  // }

  // Future<ChildModel?> getMyData() async {
  //   try {
  //     // Get the current logged-in user
  //     User? childUser = _auth.currentUser;
  //     if (childUser == null) {
  //       throw Exception("No logged-in child found");
  //     }

  //     // Fetch child's document from Firestore
  //     DocumentSnapshot childSnapshot =
  //         await _firestore.collection('users').doc(childUser.uid).get();

  //     if (!childSnapshot.exists) {
  //       throw Exception("Child data not found in Firestore");
  //     }

  //     // Convert the Firestore document into a ChildModel instance
  //     return ChildModel.fromMap(childSnapshot.data() as Map<String, dynamic>);
  //   } catch (e) {
  //     print("Error fetching child data: $e");
  //     return null;
  //   }
  // }



  Future<void> fetchUserData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        userData.value = UserModel.fromFirestore(snapshot.data()!);
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }


}
