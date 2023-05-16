import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:walaa_customer/core/widgets/brown_line_widget.dart';

import '../../../../core/utils/app_colors.dart';

class ProfileListTailWidget extends StatelessWidget {
  const ProfileListTailWidget({
    Key? key,
    required this.title,
    required this.onclick,
    required this.image,
    required this.imageColor,
    this.widget,
  }) : super(key: key);

  final String title;
  final VoidCallback onclick;
  final String image;
  final Color imageColor;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 8,
                child: InkWell(
                  onTap: onclick,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          image,
                          color: imageColor,
                          height: 26,
                          width: 26,
                        ),
                        SizedBox(width: 22),
                        Text(
                          title,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: widget??SizedBox(),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
