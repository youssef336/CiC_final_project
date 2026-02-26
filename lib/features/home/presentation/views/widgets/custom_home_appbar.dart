// ignore_for_file: camel_case_types

// ignore_for_file: unchecked_use_of_nullable_value

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysterybag/core/cubits/avatar/avatar_cubit.dart';
import 'package:mysterybag/core/helper_functions/get_user.dart';
import 'package:mysterybag/core/services/shared_preferences_singletone.dart';
import 'package:mysterybag/core/utils/assets.dart';
import 'package:mysterybag/core/utils/text_styles.dart';
import 'package:mysterybag/features/home/presentation/views/widgets/custom_app_bar_points.dart';
import 'package:mysterybag/generated/l10n.dart';

import '../../../../../constant.dart';
import '../../../../../core/widgets/notification_widget.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key, this.showNotification = true});
  final bool showNotification;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AvatarCubit(),
      child: CustomHomeAppBar_body(showNotification: showNotification),
    );
  }
}

class CustomHomeAppBar_body extends StatelessWidget {
  const CustomHomeAppBar_body({super.key, required this.showNotification});

  final bool showNotification;

  @override
  Widget build(BuildContext context) {
    String avatar = Prefs.getString(Kavatar);
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: BlocBuilder<AvatarCubit, AvatarState>(
        builder: (context, state) {
          if (state is ChangeAvatar) {
            avatar = state.avatar;
          }
          return Image.asset(
            avatar.isEmpty ? AssetsData.light().images.Avatar_1_png : avatar,
          );
        },
      ),
      title: Text(
        S.of(context)!.homeViewWelcomeAppbar,

        style: AppTextStyles.cairoRegular.copyWith(
          color: const Color(0xFF949D9E),
        ),
      ),
      subtitle: Text(getUser().name, style: AppTextStyles.cairoBold),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomappBarPoints(),
          const SizedBox(width: 8),
          Visibility(
            visible: showNotification,
            child: const NotificationWidget(),
          ),
        ],
      ),
    );
  }
}
