import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/utils/assets_manager.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:walaa_customer/core/utils/is_language_methods.dart';
import 'package:walaa_customer/core/widgets/show_loading_indicator.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../cubit/settings_cubit.dart';

class PrivacyAndTermsScreen extends StatelessWidget {
  PrivacyAndTermsScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  String text = 'NO Data';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          SettingsCubit cubit = context.read<SettingsCubit>();
          if (state is SettingsLoading) {
            return ShowLoadingIndicator();
          }
          if (state is SettingsLoaded) {
            title == AppStrings.termsText
                ? IsLanguage.isEnLanguage(context)
                    ? text = cubit.termsEn
                    : text = cubit.termsAr
                : IsLanguage.isEnLanguage(context)
                    ? text = cubit.privacyEn
                    : text = cubit.privacyAr;
          }
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),),
                ),
                width: double.infinity,
                child: Card(
                  elevation: 8,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25)),
                  ),
                  color: AppColors.textBackground,
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageAssets.whiteWalaaLogoImage,
                            height: 70,
                            width: 70,
                          ),
                          Text(
                            translateText(title, context),
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: ()=>Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_forward,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      title == AppStrings.termsText
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              height: MediaQuery.of(context).size.height / 3 - 80,
                              child: Image.asset(ImageAssets.walaaLogoImage),
                            )
                          : SizedBox(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HtmlWidget(
                          text,
                          textStyle: TextStyle(color: AppColors.textBackground),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
