import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:test/api/base_api.dart';
import 'package:test/api/end_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test/models/user_model.dart';
import 'package:test/view/form_table.dart';

class LoginController extends GetxController {
  late TextEditingController emailController, passwordController;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
        Get.to(() => FormTable());
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
