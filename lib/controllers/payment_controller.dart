import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_app/controllers/auth_controller.dart';
import 'package:pet_app/controllers/home_controller.dart';
import 'package:pet_app/utils/snackbar_utilis.dart';


class PaymentController extends GetxController {
  
  Rx<Map<String, dynamic>?> paymentIntent = Rx<Map<String, dynamic>?>(null);
  var isLoading = false.obs;

  final AuthController userController = Get.find();
  Future<String> makePayment(String amount,) async {
    try {
      isLoading.value = true;

      paymentIntent.value = await createPaymentIntent(amount,);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent.value!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Petzy',
          primaryButtonLabel: 'Pay \$$amount',
        ),
      );

      await displayPaymentSheet();

      String paymentIntentId = paymentIntent.value!['id'];
      var detailedPaymentData = await retrievePaymentData(paymentIntentId);
      print('This is the detailed payment data: $detailedPaymentData');
      print('THis is the success status: ${detailedPaymentData['status']}');
      final String success = detailedPaymentData['status'];
      // bool success = await createPaymentBackend(detailedPaymentData);
      isLoading.value = false;
    if (success == 'succeeded') {
      // Payment successful, now call the backend API to add the payment
      // bool isPaymentAdded = await addPayment(paymentIntentId, bookingId, double.parse(amount));

      // if (isPaymentAdded) {
       
        SnackbarUtils.showCustomSnackbar(title: "Success", message: "Payment Successful & Recorded!");
        return "Payment Successful!";
      // } else {
      //   SnackbarUtils.showCustomSnackbar(title: "Error", message: "Payment was successful but could not be recorded.");
      //   return "Payment recorded failed!";
      // }
    } else {
      SnackbarUtils.showCustomSnackbar(title: "Error", message: "Payment failed!");
      return "Payment failed!";
    }
    } catch (err) {
      print('Error in makePayment: $err');
      Get.snackbar('OOPS', 'Payment was not successful');
      isLoading.value = false;
      return 'Payment failed: $err';
    } finally {
      isLoading.value = false;
    }
  }

//  Future<String> makePaymentForsubscribe(String amount,) async {
//     try {
//       isLoading.value = true;

//       paymentIntent.value = await createPaymentIntent(amount,);

//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntent.value!['client_secret'],
//           style: ThemeMode.dark,
//           merchantDisplayName: 'LineUpz',
//           primaryButtonLabel: 'Pay \$$amount',
//         ),
//       );

//       await displayPaymentSheet();

//       String paymentIntentId = paymentIntent.value!['id'];
//       var detailedPaymentData = await retrievePaymentData(paymentIntentId);
//       print('This is the detailed payment data: $detailedPaymentData');
//       print('THis is the success status: ${detailedPaymentData['status']}');
//       final String success = detailedPaymentData['status'];
//       // bool success = await createPaymentBackend(detailedPaymentData);
//       isLoading.value = false;
//     if (success == 'succeeded') {
//       // final AuthController controller=Get.isRegistered()?Get.find():Get.put(AuthController());
      
//        final userId = await getUserId();
//       // Payment successful, now call the backend API to add the payment
//       bool isPaymentAdded = await subscribe(voucherId: bookingId, userId: userId??0);

//       if (isPaymentAdded) {
       
//         SnackbarUtils.showCustomSnackbar(title: "Success", message: "Payment Successful & Recorded!");
//         return "Payment Successful!";
//       } else {
//         SnackbarUtils.showCustomSnackbar(title: "Error", message: "Payment was successful but could not be recorded.");
//         return "Payment recorded failed!";
//       }
//     } else {
//       SnackbarUtils.showCustomSnackbar(title: "Error", message: "Payment failed!");
//       return "Payment failed!";
//     }
//     } catch (err) {
//       print('Error in makePayment: $err');
//       Get.snackbar('OOPS', 'Payment was not successful');
//       isLoading.value = false;
//       return 'Payment failed: $err';
//     } finally {
//       isLoading.value = false;
//     }
//   }




  Future<void> displayPaymentSheet() async {
    try {
      isLoading.value = true;
      await Stripe.instance.presentPaymentSheet();
      isLoading.value = false;
    } on StripeException catch (e) {
      print('StripeException in displayPaymentSheet: $e');
      isLoading.value = false;
      throw Exception('Payment failed: $e');
    } catch (e) {
      print('Error in displayPaymentSheet: $e');
      isLoading.value = false;
      throw Exception('Payment failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount) async {
    try {
      isLoading.value = true;
      // Convert amount to the smallest currency unit
      int amountInSmallestUnit = (double.parse(amount) * 100).toInt();

      Map<String, dynamic> body = {
        'amount': amountInSmallestUnit.toString(),
        'currency': 'usd',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );

      print('Payment Intent Response: ${response.body}');
      isLoading.value = false;
      return json.decode(response.body);
    } catch (err) {
      print('Error in createPaymentIntent: $err');
      isLoading.value = false;
      throw Exception(err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> retrievePaymentData(
      String paymentIntentId) async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse('https://api.stripe.com/v1/payment_intents/$paymentIntentId'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        },
      );
      print('Retrieve Payment Data Response: ${jsonDecode(response.body)}');
      return json.decode(response.body);
    } catch (err) {
      print('Error in retrievePaymentData: $err');
      throw Exception('Failed to retrieve payment data: $err');
    } finally {
      isLoading.value = false;
    }
  }

  // Future<bool> createPaymentBackend(
  //   Map<String, dynamic> detailedPaymentData,
  // ) async {
  //   try {
  //     isLoading.value = true;
  //     var request = http.MultipartRequest(
  //         'PUT', Uri.parse('${baseUrl}api/v2/payment/add'));
  //     request.fields.addAll({'isSubscribed': 'true'});

  //     http.StreamedResponse response = await request.send();
  //     final res = json.decode(await response.stream.bytesToString());

  //     print('Response from Purchase API: ${res}');
  //     print("Status code: ${response.statusCode}");

  //     print('Response Data: $res');
  //     if (response.statusCode == 201 || response.statusCode == 200) {
  //       print('This is the user model that we are getting:${res['user']}');
  //       userController.user.value = UserModel.fromJson(res['user']);

  //       // await LocalStorageService.saveUserToPrefs(
  //       //     userController.userModel.value!);

  //       return res['status'] == true;
  //     } else {
  //       isLoading.value = false;
  //       return false;
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //     Get.snackbar('OOPS', e.toString());
  //     isLoading.value = false;
  //     return false;
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }



Future<int> getUserId() async {
  // final prefs = await SharedPreferences.getInstance();
 final userId= userController.userData.value?.uid;
  return int.tryParse(userId??"") ?? 0;
}




}
