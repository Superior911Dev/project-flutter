import 'dart:convert';

import 'package:appstore/common/apis/user_api.dart';
import 'package:appstore/common/entities/entities.dart';
import 'package:appstore/global.dart';
import 'package:appstore/common/values/constant.dart';
import 'package:appstore/common/widgets/flutter_toast.dart';
import 'package:appstore/pages/Sign_in/bloc/sign_in_bloc.dart';
import 'package:appstore/pages/home/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignInController {
  final BuildContext context;
  const SignInController({required this.context});

  Future<void> handleSignIn(String type) async {
    try {
      if (type == "email") {
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;

        if (emailAddress.isEmpty) {
          //
          toastInfo(msg: "คุณต้องกรอกที่อยู่อีเมล");
          return;
        } else {
          print("อีเมลคือ $emailAddress");
        }
        if (password.isEmpty) {
          //
          toastInfo(msg: "คุณต้องกรอกรหัสผ่าน");
          return;
        }

        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAddress, password: password);
          if (credential.user == null) {
            //
            toastInfo(msg: "ไม่มีอีเมลของคุณ");
            return;
          }
          if (!credential.user!.emailVerified) {
            toastInfo(msg: "คุณต้องยืนยันบัญชีอีเมลของคุณ");
            return;
          }

          var user = credential.user;
          if (user != null) {
            String? displayName = user.displayName;
            String? email = user.email;
            String? id = user.uid;
            String? photoUrl = user.photoURL;
            print("my url is ${photoUrl}");
            LoginRequestEntity loginRequestEntity = LoginRequestEntity();
            loginRequestEntity.avatar = photoUrl;
            loginRequestEntity.name = displayName;
            loginRequestEntity.email = email;
            loginRequestEntity.open_id = id;

            loginRequestEntity.type = 1;

            print("มีผู้ใช้อยู่แล้ว");
            asyncPostAllData(loginRequestEntity);
            if (context.mounted) {
              await HomeController(context: context).init();
            }
          } else {
            toastInfo(msg: "ขณะนี้คุณไม่ใช่ผู้ใช้แอปนี้");
            return;
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'ไม่พบชื่อผู้ใช้') {
            print('ไม่พบผู้ใช้สำหรับอีเมลนั้น');
            toastInfo(msg: "ไม่พบผู้ใช้สำหรับอีเมลนั้น");
            return;
          } else if (e.code == 'รหัสผ่านผิด') {
            print('ระบุรหัสผ่านผิดสำหรับผู้ใช้รายนั้น');
            toastInfo(msg: "ระบุรหัสผ่านผิดสำหรับผู้ใช้รายนั้น");
            return;
          } else if (e.code == 'อีเมลไม่ถูกต้อง') {
            print('รูปแบบอีเมลของคุณไม่ถูกต้อง');
            toastInfo(msg: "รูปแบบอีเมลของคุณไม่ถูกต้อง");
            return;
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    var result = await UserApi.login(params: loginRequestEntity);
    if (result.code == 200) {
      try {
        Global.storageService.setString(
            AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.data!));
        print("...........my token is ${result.data!.access_token!}........");
        Global.storageService.setString(
            AppConstants.STORAGE_USER_TOKEN_KEY, result.data!.access_token!);
        EasyLoading.dismiss();

        if (context.mounted) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/application", (route) => false);
        }
      } catch (e) {
        print("saving local storage error ${e.toString()}");
      }
    } else {
      EasyLoading.dismiss();
      toastInfo(msg: "unKnown error");
    }
  }
}
