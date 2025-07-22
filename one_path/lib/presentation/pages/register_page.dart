import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_path/core/constants/app_colors.dart';
import 'package:one_path/core/constants/image_paths.dart';
import 'package:one_path/core/constants/text_styles.dart';
import 'package:one_path/localizations/app_localizations.dart';
import 'package:one_path/presentation/blocs/register/register_bloc.dart';
import 'package:one_path/presentation/blocs/register/register_event.dart';
import 'package:one_path/presentation/blocs/register/register_state.dart';
import 'package:one_path/presentation/widgets/custom_button.dart';
import 'package:one_path/presentation/widgets/custom_text_field.dart';
import 'package:one_path/presentation/widgets/social_icons_row.dart';

import '../../core/services/navigation_service.dart';
import '../routes/app_routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscurePasswordAgain = true;

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegex.hasMatch(email);
  }

  void _handleRegister() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final passwordAgain = passwordAgainController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        passwordAgain.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).fillAllFields)),
      );
      return;
    }

    if (!isEmailValid(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).enterValidEmail)),
      );
      return;
    }

    if (password != passwordAgain) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context).passwordsDoNotMatch)),
      );
      return;
    }

    context.read<RegisterBloc>().add(
          RegisterSubmitted(name: name, email: email, password: password),
        );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: BlocConsumer<RegisterBloc, RegisterState>(
                          listener: (context, state) {
                            if (state is RegisterSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(local.registrationSuccess)),
                              );
                              NavigationService.navigateTo(AppRoutes.login);
                            } else if (state is RegisterFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }
                          },
                          builder: (context, state) {
                            final screenHeight = constraints.maxHeight;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: screenHeight * 0.15),
                                Center(
                                  child: Column(
                                    children: [
                                      Text(local.welcome,
                                          style: AppTextStyles.semiBold18White),
                                      const SizedBox(height: 10),
                                      Text(
                                        "${local.comeOn}\n"
                                        "${local.discoverMore}",
                                        style: AppTextStyles
                                            .regular13WhiteCentered,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 50),
                                CustomTextField(
                                  controller: nameController,
                                  hintText: local.fullName,
                                  prefixImagePath: ImagePaths.user,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  controller: emailController,
                                  hintText: local.email,
                                  prefixImagePath: ImagePaths.message,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  controller: passwordController,
                                  hintText: local.password,
                                  prefixImagePath: ImagePaths.unlock,
                                  isPassword: true,
                                  obscureText: _obscurePassword,
                                  onToggleVisibility: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  controller: passwordAgainController,
                                  hintText: local.passwordRepeat,
                                  prefixImagePath: ImagePaths.unlock,
                                  isPassword: true,
                                  obscureText: _obscurePasswordAgain,
                                  onToggleVisibility: () {
                                    setState(() {
                                      _obscurePasswordAgain =
                                          !_obscurePasswordAgain;
                                    });
                                  },
                                ),
                                const SizedBox(height: 20),
                                RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: local.agreementTextPart1,
                                        style: AppTextStyles.regular12White50,
                                      ),
                                      TextSpan(
                                        text: local.agreementTextPart2,
                                        style: AppTextStyles
                                            .regular12WhiteUnderline,
                                      ),
                                      TextSpan(
                                        text: local.agreementTextPart3,
                                        style: AppTextStyles.regular12White50,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                state is RegisterLoading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : CustomButton(
                                        text: local.registerNow,
                                        onTap: _handleRegister,
                                        backgroundColor: AppColors.red,
                                        verticalPadding: 16,
                                        borderRadius: 12,
                                      ),
                                const SizedBox(height: 45),
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
                      NavigationService.navigateTo(AppRoutes.login);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          local.alreadyHaveAccount,
                          style: AppTextStyles.regular12White50,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          local.login,
                          style: AppTextStyles.regular12White,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
