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
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.only(right: 16, left: 16),
            icon: Icon(
              Icons.arrow_forward_outlined,
              color: AppColors.textBackground,
              size: 35,
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Text(
            translateText(title, context),
            style: TextStyle(
              color: AppColors.textBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.containerBackgroundColor,
      ),
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
          return SingleChildScrollView(
            child: Column(
              children: [
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
          );
        },
      ),
    );
  }
}
