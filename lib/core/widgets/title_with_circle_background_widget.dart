import 'package:flutter/material.dart';
import 'package:walaa_customer/core/utils/translate_text_method.dart';

import '../utils/app_colors.dart';

class TitleWithCircleBackgroundWidget extends StatelessWidget {
  const TitleWithCircleBackgroundWidget({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width / 2,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,

              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: AppColors.buttonBackground,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Container(
                      width: 50,
                      height: 1,
                      color: AppColors.blueLineColor,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
             
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        translateText(title, context),
                        style: TextStyle(
                          // color: AppColors.secondPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
