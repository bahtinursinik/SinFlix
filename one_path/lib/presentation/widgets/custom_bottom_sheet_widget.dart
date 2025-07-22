import 'package:flutter/material.dart';
import 'package:one_path/core/constants/app_colors.dart';
import 'package:one_path/core/constants/image_paths.dart';
import 'package:one_path/core/constants/text_styles.dart';
import 'package:one_path/localizations/app_localizations.dart';
import 'package:one_path/presentation/widgets/custom_button.dart';
import 'package:one_path/presentation/widgets/inner_shadow_circle.dart';

class JetonBottomSheet extends StatelessWidget {
  const JetonBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 500,
            child: Container(
              decoration:
                  buildRadialGradientDecoration(center: Alignment.topCenter),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            height: 500,
            child: Container(
              decoration:
                  buildRadialGradientDecoration(center: Alignment.bottomCenter),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            local.limitedOffer,
                            style: AppTextStyles.semiBold20WhiteCentered,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            local.bonusText,
                            style: AppTextStyles.regular12White,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: const RadialGradient(
                              center: Alignment.center,
                              radius: 1.2,
                              colors: [
                                AppColors.white10,
                                AppColors.white3,
                              ],
                            ),
                            border: Border.all(
                              color: AppColors.white10,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                local.bonusesYouWillReceive,
                                style: AppTextStyles.medium15White,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildBonusIcon(
                                      ImagePaths.premium, local.premiumAccount),
                                  _buildBonusIcon(
                                      ImagePaths.match, local.moreMatches),
                                  _buildBonusIcon(
                                      ImagePaths.highlight, local.highlight),
                                  _buildBonusIcon(
                                      ImagePaths.like, local.moreLikes),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),
                        Center(
                          child: Text(
                            local.selectCoin,
                            style: AppTextStyles.medium15White,
                          ),
                        ),
                        const SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildPackage(
                              context: context,
                              startColor: AppColors.darkRed,
                              endColor: AppColors.red,
                              bonusColor: AppColors.darkRed,
                              bonus: '+10%',
                              jetonValue: '330',
                              old: '200',
                              price: '₺99,99',
                            ),
                            _buildPackage(
                              context: context,
                              startColor: AppColors.purple,
                              endColor: AppColors.red,
                              bonusColor: AppColors.purple,
                              bonus: '+70%',
                              jetonValue: '3.375',
                              old: '2000',
                              price: '₺799,99',
                            ),
                            _buildPackage(
                              context: context,
                              startColor: AppColors.darkRed,
                              endColor: AppColors.red,
                              bonusColor: AppColors.darkRed,
                              bonus: '+35%',
                              jetonValue: '1350',
                              old: '1000',
                              price: '₺399,99',
                            ),
                          ],
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  text: local.seeAllTokens,
                  onTap: () {},
                  verticalPadding: 16,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBonusIcon(String asset, String label) {
    return Column(
      children: [
        InnerShadowCircle(
          child: Image.asset(asset, width: 38, height: 38),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.regular12White,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  BoxDecoration buildRadialGradientDecoration({
    required Alignment center,
  }) {
    return BoxDecoration(
      gradient: RadialGradient(
        colors: [
          AppColors.red.withValues(alpha: 0.5),
          AppColors.red.withValues(alpha: 0.4),
          AppColors.darkRed.withValues(alpha: 0.5),
          const Color(0xFF6F060B).withValues(alpha: 0.3),
          Colors.transparent,
        ],
        radius: 0.6,
        center: center,
      ),
    );
  }

  Widget _buildPackage({
    required BuildContext context,
    required Color startColor,
    required Color endColor,
    required String bonus,
    required Color bonusColor,
    required String jetonValue,
    required String old,
    required String price,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 120,
          height: 220,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [startColor, endColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.white.withValues(alpha: 0.4)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(
                flex: 2,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 7.5,
                    child: Container(
                      width: 40,
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    old,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.medium15White,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                jetonValue,
                textAlign: TextAlign.center,
                style: AppTextStyles.black25WhiteCentered,
              ),
              SizedBox(height: 8),
              Text(
                AppLocalizations.of(context).token,
                textAlign: TextAlign.center,
                style: AppTextStyles.medium15White,
              ),
              Spacer(),
              Divider(color: AppColors.white10),
              SizedBox(height: 5),
              Text(
                price,
                textAlign: TextAlign.center,
                style: AppTextStyles.black15WhiteCentered,
              ),
              Text(
                AppLocalizations.of(context).perWeek,
                textAlign: TextAlign.center,
                style: AppTextStyles.regular12White,
              ),
            ],
          ),
        ),
        Positioned(
          top: -14,
          left: 25,
          right: 25,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.white.withValues(alpha: 0.3),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    decoration: BoxDecoration(
                      color: bonusColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.3)),
                    ),
                    child: Center(
                      child: Text(
                        bonus,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.regular12White,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
