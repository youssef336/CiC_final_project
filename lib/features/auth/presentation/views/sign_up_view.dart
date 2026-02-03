import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysterybag/core/helper_functions/build_error_bar.dart';
import 'package:mysterybag/core/services/get_it_service.dart';
import 'package:mysterybag/core/widgets/custom_modal_progress_hub.dart';
import 'package:mysterybag/features/auth/domain/repo/auth_repo.dart';
import 'package:mysterybag/features/auth/presentation/manager/cubits/sign_up/sign_up_cubit.dart';
import 'package:mysterybag/features/auth/presentation/views/widgets/sign_up_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static const routeName = '/signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,

      body: SafeArea(
        child: BlocProvider(
          create: (context) => SignUpCubit(getIt<AuthRepo>()),
          child: const SignUpViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}

class SignUpViewBodyBlocConsumer extends StatelessWidget {
  const SignUpViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pop(context);
          showErrorBar(context, "Successfully Signed Up");
        } else if (state is SignUpError) {
          showErrorBar(context, state.error);
        }
      },
      builder: (context, state) {
        return CustomModalProgressHUD(
          inAsyncCall: state is SignUpLoading,
          child: const SignUpViewBody(),
        );
      },
    );
  }
}
