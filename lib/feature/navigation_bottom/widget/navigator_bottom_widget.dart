import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
          iconSize: 40.0,
          backgroundColor: AppColors.textFormFieldColor,
          strokeColor: AppColors.white,
          currentIndex: _page,
          items: [
            CustomNavigationBarItem(
              icon: Center(
                child: Image.asset(
                  ImageAssets.homeImage,
                  color: _page == 0
                      ? AppColors.iconBackgroundColor
                      : AppColors.navigationBarIconColor,
                ),
              ),
            ),
            CustomNavigationBarItem(
              icon: Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              ImageAssets.cartIcon,
                              width: 30,
                              height: 30,
                              color: _page == 1
                                  ? AppColors.iconBackgroundColor
                                  : AppColors.navigationBarIconColor,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.white, shape: BoxShape.circle),
                          width: 18,
                          height: 18,
                          child: Center(
                            child: Text(
                              bottomCubit.size,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBackground,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomNavigationBarItem(
              icon: Center(
                child: SvgPicture.asset(
                  ImageAssets.profileIcon,
                  color: _page == 2
                      ? AppColors.iconBackgroundColor
                      : AppColors.navigationBarIconColor,
                ),
              ),
            ),
          ],
          onTap: (index) {
            bottomCubit.changePage(
              index,
            );
          },
        );
      },
    );
  }
}
