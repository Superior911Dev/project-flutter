import 'package:appstore/pages/Sign_in/bloc/sign_in_bloc.dart';
import 'package:appstore/pages/Sign_in/bloc/sign_in_events.dart';
import 'package:appstore/pages/Sign_in/bloc/signin_states.dart';
import 'package:appstore/pages/Sign_in/sign_in_controller.dart';
import 'package:appstore/pages/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar("เข้าสู่ระบบ"),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 36.h),
                  padding: EdgeInsets.only(left: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText("อีเมล"),
                      SizedBox(
                        height: 5.h,
                      ),
                      buildTextField("กรอกที่อยู่อีเมล์ของคุณ", "email", "user",
                          (value) {
                        context.read<SignInBloc>().add(EmailEvent(value));
                      }),
                      reusableText("รหัสผ่าน"),
                      SizedBox(
                        height: 5.h,
                      ),
                      buildTextField("ใส่รหัสผ่านของคุณ", "password", "lock",
                          (value) {
                        context.read<SignInBloc>().add(PasswordEvent(value));
                      })
                    ],
                  ),
                ),
                forgotPassword(),
                SizedBox(
                  height: 70.h,
                ),
                buildLoginAndRegButton("เข้าสู่ระบบ", "login", () {
                  SignInController(context: context).handleSignIn("email");
                }),
                buildLoginAndRegButton("ลงทะเบียน", "register", () {
                  Navigator.of(context).pushNamed("/register");
                }),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 15.w),
                    child:
                        reusableText("หรือใช้บัญชีอีเมลของคุณเพื่อเข้าสู่ระบบ"),
                  ),
                ),
                buildThirdPartyLogin(context),
              ],
            ),
          ),
        )),
      );
    });
  }
}
