// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/foundation.dart';
import 'package:mysterybag/assets.dart';

import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/utils/text_styles.dart';
import 'package:mysterybag/core/widgets/custom_buttom.dart';
import 'package:mysterybag/core/widgets/custom_text_feild.dart';
import 'package:mysterybag/features/auth/presentation/views/widgets/dont_have_an_acoount_widget.dart';
import 'package:mysterybag/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:mysterybag/features/auth/presentation/views/widgets/social_text_buttom.dart';
import 'package:mysterybag/generated/l10n.dart';
import '../../../../../core/services/build_passward_state.dart';
import '../../manager/cubits/sign_in_cubit/sign_in_cubit.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KhorzontalPadding),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            children: [
              const SizedBox(height: 24),
              CustomTextFormFeild(
                onSaved: (value) {
                  email = value!;
                },
                hintText: S.of(context).on_Login_email,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              BiludPasswordState(
                onSaved: (value) {
                  password = value!;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).on_Login_forgot_password,
                    style: AppTextStyles.bodySmallSemibold.copyWith(
                      color: KprimaryColorLight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 33),
              CustomButtom(
                text: S.of(context).on_Login_login,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.read<SignInCubit>().signInWithEmailAndPassword(
                      email: email!,
                      password: password!,
                    );
                  } else {
                    setState(() {
                      autoValidateMode = AutovalidateMode.always;
                    });
                  }
                },
              ),
              const SizedBox(height: 33),
              DontHaveAnAcoountWidget(context),
              const SizedBox(height: 33),
              const OrDivider(),
              const SizedBox(height: 16),

              SocialTextButtom(
                image: Assets.images.google_icon_svg,
                text: S.of(context).on_Login_login_with_google,
                onPressed: () {
                  context.read<SignInCubit>().signInWithGoogle();
                },
              ),
              const SizedBox(height: 16),
              !kIsWeb
                  ? Column(
                      children: [
                        SocialTextButtom(
                          image: Assets.images.google_icon_svg,
                          text: S.of(context).on_Login_login_with_apple,
                          onPressed: () {},
                        ),
                        const SizedBox(height: 16),
                      ],
                    )
                  : const SizedBox(),

              SocialTextButtom(
                image: Assets.images.facebook_icon_svg,
                text: S.of(context).on_Login_login_with_facebook,
                onPressed: () {
                  context.read<SignInCubit>().signInWithFacebook();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
