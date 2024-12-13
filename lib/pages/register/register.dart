import 'package:appstore/pages/register/bloc/register_blocs.dart';
import 'package:appstore/pages/register/bloc/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:appstore/pages/register/register_controller.dart';
import 'package:appstore/pages/common_widgets.dart';
import 'bloc/register_events.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBlocs, RegisterStates>(
        builder: (context, state) {
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar("ลงทะเบียน"),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(child: reusableText("กรอกรายละเอียดของคุณด้านล่าง")),
                  Container(
                    margin: EdgeInsets.only(top: 15.h),
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reusableText("ชื่อผู้ใช้"),
                        buildTextField("กรอกชื่อผู้ใช้", "name", "user",
                            (value) {
                          context
                              .read<RegisterBlocs>()
                              .add(UserNameEvent(value));
                        }),
                        reusableText("อีเมล"),
                        buildTextField(
                            "กรอกที่อยู่อีเมล์ของคุณ", "email", "email",
                            (value) {
                          context.read<RegisterBlocs>().add(EmailEvent(value));
                        }),
                        reusableText("รหัสผ่าน"),
                        buildTextField("กรอกรหัสผ่านของคุณ", "password", "lock",
                            (value) {
                          context
                              .read<RegisterBlocs>()
                              .add(PasswordEvent(value));
                        }),
                        reusableText("กรอกรหัสผ่านอีกครั้ง"),
                        buildTextField(
                            "กรอกรหัสผ่านของคุณเพื่อยืนยัน", "password", "lock",
                            (value) {
                          context
                              .read<RegisterBlocs>()
                              .add(RePasswordEvent(value));
                        })
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25.w),
                    child: reusableText(
                      "โดยการสร้างบัญชี\nคุณจะต้องยอมรับและเงื่อนไขของเรา",
                    ),
                  ),
                  buildLoginAndRegButton("ลงทะเบียน", "login", () {
                    // Navigator.of(context).pushNamed("register");
                    RegisterController(context: context).handleEmailRegister();
                  }),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
