import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/utils/translate_text_method.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../cubit/navigator_bottom_cubit.dart';

class NavigatorBottomWidget extends StatelessWidget {
  NavigatorBottomWidget({Key? key}) : super(key: key);
  late int _page = 2;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBottomCubit, NavigatorBottomState>(
      builder: (context, state) {
        NavigatorBottomCubit bottomCubit = context.read<NavigatorBottomCubit>();

        _page = bottomCubit.page;
        return CustomNavigationBar(
          iconSize: 30.0,
          backgroundColor: AppColors.containerBackgroundColor,
          strokeColor: AppColors.white,
          currentIndex: _page,
          items: [
            CustomNavigationBarItem(
              icon: Image.asset(
                ImageAssets.homeImage,
                color: _page == 0
                    ? AppColors.iconBackgroundColor
                    : AppColors.white,
              ),
            ),
            CustomNavigationBarItem(
              icon: Image.asset(
                ImageAssets.profileImage,
                color: _page == 1
                    ? AppColors.iconBackgroundColor
                    : AppColors.white,
              ),
            ),
          ],
          onTap: (index) {
            bottomCubit.changePage(
              index,
              translateText(['home', 'profile'].elementAt(index), context),
            );
          },
        );
      },
    );
  }
}
