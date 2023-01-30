import 'package:flutter/material.dart';
import 'package:walaa_customer/core/utils/assets_manager.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/translate_text_method.dart';

class PrivacyAndTermsScreen extends StatelessWidget {
  PrivacyAndTermsScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  String text =
      '/ <p>It is important to take care of the patient, to be followed by the doctor, but it is a time of great pain and suffering. For to come to the smallest detail, no one should practice any kind of work unless he derives some benefit from it. Do not be angry with the pain in the reprimand in the pleasure he wants to be a hair from the pain in the hope that there is no breeding. Unless they are blinded by lust, they do not come out; they are in fault who abandon their duties and soften their hearts, that is toil.</p>';

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
      body: Column(
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
  }
}
