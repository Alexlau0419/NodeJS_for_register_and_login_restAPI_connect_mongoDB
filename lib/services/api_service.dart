import 'dart:convert';

import 'package:flutter_login_register_nodejs/models/login_request_model.dart';
import 'package:flutter_login_register_nodejs/models/login_response_model.dart';
import 'package:flutter_login_register_nodejs/models/register_request_model.dart';
import 'package:flutter_login_register_nodejs/models/register_response_model.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';
import 'shared_service.dart';

class APIService {

  static var client = http.Client();

  static Future<bool> login(
    LoginRequestModel model,
  ) async {
    print('AAAAAAAAAAAAAAAAAA');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    print('QQQQQQQQQQQQQQQQQQQQQ');
    var url = Uri.http(
      Config.apiURL,
      Config.loginAPI,
    );
    print('WWWWWWWWWWWWWWWWWWWWWWW');
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(
        loginResponseJson(
          response.body,
        ),
      );
      print('BBBBBBBBBBBBBBBBB');
      return true;
    } else {
      print('CCCCCCCCCCCCCCCCC');
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
    RegisterRequestModel model,
  ) async {
    print('DDDDDDDDDDDDDDDDDDD');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.registerAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
      print('EEEEEEEEEEEEEEEEE');
    return registerResponseJson(
      response.body,
    );
  }

  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();
    print('FFFFFFFFFFFFFFFFFF');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token}'
    };

    var url = Uri.http(Config.apiURL, Config.userProfileAPI);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      print('GGGGGGGGGGGGGGGGG');
      return response.body;
    } else {
      print('HHHHHHHHHHHHHHHHH');
      return "";
    }
  }
}