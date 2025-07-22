import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_path/core/constants/app_colors.dart';
import 'package:one_path/core/constants/text_styles.dart';
import 'package:one_path/core/utils/auth_helper.dart';
import 'package:one_path/localizations/app_localizations.dart';
import 'package:one_path/presentation/blocs/locale/locale_cubit.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context).settings,
              style: AppTextStyles.medium15White),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context).pleaseSelectLanguage,
              style: AppTextStyles.regular12White50,
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: Text('🇹🇷', style: AppTextStyles.medium18White),
            title: Text(AppLocalizations.of(context).turkish,
                style: AppTextStyles.medium12White),
            onTap: () {
              context.read<LocaleCubit>().setLocale(const Locale('tr'));
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Text('🇺🇸', style: AppTextStyles.medium18White),
            title: Text(AppLocalizations.of(context).english,
                style: AppTextStyles.medium12White),
            onTap: () {
              context.read<LocaleCubit>().setLocale(const Locale('en'));
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: 24),
          ListTile(
            tileColor: AppColors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 20,
            ),
            title: Text(
              AppLocalizations.of(context).logout,
              style: AppTextStyles.medium12White,
            ),
            onTap: () async {
              Navigator.of(context).pop();
              await AuthHelper.logout(context);
            },
          ),
        ],
      ),
    );
  }
}
