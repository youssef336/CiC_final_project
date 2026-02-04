import 'package:flutter/material.dart';
import 'package:mysterybag/core/widgets/custom_text_feild.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
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
