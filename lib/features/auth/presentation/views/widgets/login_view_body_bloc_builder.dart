import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysterybag/core/helper_functions/build_error_bar.dart';
import 'package:mysterybag/core/widgets/custom_modal_progress_hub.dart';
import 'package:mysterybag/features/auth/presentation/manager/cubits/login/login_cubit.dart';
import 'package:mysterybag/features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:mysterybag/features/home/presentation/views/home_view.dart';

class LoginViewBodyBlocBuilder extends StatelessWidget {
  const LoginViewBodyBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        return CustomModalProgressHUD(
          inAsyncCall: state is LoginLoading,
          child: const LoginViewBody(),
        );
      },
      listener: (BuildContext context, LoginState state) {
        if (state is LoginSuccess) {
          Navigator.pushNamed(context, HomeView.routeName);
        }
        if (state is LoginError) {
          showErrorBar(context, state.message);
        }
      },
    );
  }
}
