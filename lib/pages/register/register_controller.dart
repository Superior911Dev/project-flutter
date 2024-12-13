import 'package:appstore/common/values/constant.dart';
import 'package:appstore/pages/register/bloc/register_blocs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appstore/common/widgets/flutter_toast.dart';

class RegisterController {
  final BuildContext context;
  const RegisterController({required this.context});

  Future<void> handleEmailRegister() async {
    final state = context.read<RegisterBlocs>().state;
    String userName = state.userName;
    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;

    if (userName.isEmpty) {
      toastInfo(msg: "กรุณากรอกชื่อผู้ใช้");
      return;
    }
    if (email.isEmpty) {
      toastInfo(msg: "กรุณากรอกอีเมล");
      return;
    }
    if (password.isEmpty) {
      toastInfo(msg: "กรุณากรอกรหัสผ่าน");
      return;
    }
    if (rePassword.isEmpty) {
      toastInfo(msg: "กรุณากรอกยืนยันรหัสผ่าน");
      return;
    }

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(userName);
        String photoUrl = "uploads/user2.png";
        await credential.user?.updatePhotoURL(photoUrl);
        toastInfo(msg: "อีเมลได้ถูกส่งไปยังอีเมลที่ลงทะเบียนของคุณแล้ว");
        //Navigator.of(context).pushNamed("register");
        RegisterController(context: context).handleEmailRegister();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'รหัสผ่านของคุณมีความปลอดภัยน้อย') {
        toastInfo(msg: "รหัสผ่านที่ให้ไว้ไม่รัดกุมเกินไป");
      } else if (e.code == 'อีเมลมีการใช้งานแล้ว') {
        toastInfo(msg: "อีเมลนี้มีการใช้งานแล้ว");
      } else if (e.code == 'อีเมลไม่ถูกต้อง') {
        toastInfo(msg: "รหัสอีเมลของคุณไม่ถูกต้อง");
      }
    }
  }
}
