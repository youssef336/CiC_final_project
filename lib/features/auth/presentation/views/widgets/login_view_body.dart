import 'package:flutter/material.dart';
import 'package:mysterybag/core/widgets/custom_text_feild.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormFeild(
          hintText: "Name",
          textInputType: TextInputType.text,
        ),
        CustomTextFormFeild(
          hintText: "Email",
          textInputType: TextInputType.emailAddress,
        ),
        CustomTextFormFeild(
          hintText: "Password",
          textInputType: TextInputType.text,
          obscureText: true,
        ),
      ],
    );
  }
}
