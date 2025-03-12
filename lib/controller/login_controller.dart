import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:test/api/base_api.dart';
import 'package:test/api/end_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test/models/user_model.dart';
import 'package:test/view/earthing_table_view.dart';

class LoginController extends GetxController {
  late TextEditingController emailController, passwordController;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void loginWithGetx() async {
    loading.value = true;
    try {
      var url = Uri.parse(BaseApi.baseURL + EndPoints.login);
      var response = await http.post(url, body: {
        'email': emailController.value.text,
        'password': passwordController.value.text
      });
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        loading.value = false;
        Get.snackbar(
          'Login Sucessfull',
          'Welcome',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.to(() => EarthingTableView());
      } else {
        loading.value = false;
        print(data.toString());
        Get.snackbar(
          'Login Failed',
          data['message'],
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar(
        'Exception',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> loginWithEmail({@required formkey}) async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formkey.currentState!.save();

    var headers = {'content-Type': 'application/json'};

    try {
      var url = Uri.parse(BaseApi.baseURL + EndPoints.login);
      print(url);
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print(url);
      if (json['status'] == 200) {
        List<String> permissions = [];
        UserModel loginUser = UserModel.fromJson(json);

        emailController.clear();
        passwordController.clear();
        print(loginUser.userName);
        Get.to(() => EarthingTableView());
        //Get.off(HomeScreen());
      } else {
        // Get.to(() => LoginScreen());
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
