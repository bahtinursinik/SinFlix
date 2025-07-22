import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:one_path/core/constants/image_paths.dart';
import 'package:one_path/core/constants/text_styles.dart';
import 'package:one_path/core/services/token_service.dart';
import 'package:one_path/localizations/app_localizations.dart';
import 'package:one_path/presentation/blocs/login/login_bloc.dart';
import 'package:one_path/presentation/blocs/login/login_event.dart';
import 'package:one_path/presentation/blocs/login/login_state.dart';
import 'package:one_path/presentation/widgets/custom_button.dart';
import 'package:one_path/presentation/widgets/custom_text_field.dart';
import 'package:one_path/presentation/widgets/social_icons_row.dart';

import '../../core/services/navigation_service.dart';
import '../routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  void showSuccessAnimation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: Lottie.asset(ImagePaths.success, repeat: false),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: screenHeight),
                      child: IntrinsicHeight(
                        child: BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) async {
                            if (state is LoginSuccess) {
                              final user = state.user;
                              await TokenStorage.saveToken(state.token);
                              await TokenStorage.saveUser(user);

                              showSuccessAnimation(context);

                              await Future.delayed(const Duration(seconds: 2));
                              if (user.photoUrl.trim().isEmpty) {
                                NavigationService.navigateTo(
                                    AppRoutes.uploadPhoto);
                              } else {
                                NavigationService.clearAndPush(AppRoutes.main);
                              }
                            } else if (state is LoginFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.error)),
                              );
                            }
                          },
                          builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: screenHeight * 0.35),
                                Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).hello,
                                      style: AppTextStyles.semiBold18White,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      AppLocalizations.of(context).welcomeApp,
                                      style:
                                          AppTextStyles.regular13WhiteCentered,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      AppLocalizations.of(context).pleaseLogin,
                                      style:
                                          AppTextStyles.regular13WhiteCentered,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 40),
                                CustomTextField(
                                  controller: emailController,
                                  hintText: AppLocalizations.of(context).email,
                                  prefixImagePath: ImagePaths.message,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  controller: passwordController,
                                  hintText:
                                      AppLocalizations.of(context).password,
                                  prefixImagePath: ImagePaths.unlock,
                                  isPassword: true,
                                  obscureText: _obscurePassword,
                                  onToggleVisibility: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                const SizedBox(height: 30),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppLocalizations.of(context).forgotPassword,
                                    style:
                                        AppTextStyles.regular12WhiteUnderline,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                state is LoginLoading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : CustomButton(
                                        text:
                                            AppLocalizations.of(context).login,
                                        onTap: () {
                                          context.read<LoginBloc>().add(
                                                LoginRequested(
                                                  email: emailController.text
                                                      .trim(),
                                                  password: passwordController
                                                      .text
                                                      .trim(),
                                                ),
                                              );
                                        },
                                      ),
                                const SizedBox(height: 30),
                                SocialIconsRow(),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: GestureDetector(
                    onTap: () {
                      NavigationService.navigateTo(AppRoutes.register);
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: AppLocalizations.of(context).noAccount,
                        style: AppTextStyles.regular12White50,
                        children: [
                          TextSpan(
                            text: " ${AppLocalizations.of(context).register}",
                            style: AppTextStyles.regular12White,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
