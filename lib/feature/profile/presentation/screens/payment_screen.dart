import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';
import 'package:walaa_customer/core/utils/translate_text_method.dart';
import 'package:walaa_customer/feature/profile/presentation/cubit/profile_cubit.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/convert_numbers_method.dart';
import '../../../../core/widgets/circle_network_image.dart';

class PaymentPackage extends StatelessWidget {
  const PaymentPackage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        ProfileCubit cubit = context.read<ProfileCubit>();
        return Scaffold(
          body: Container(
            child: Column(

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
                        padding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
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
                              translateText(AppStrings.packgeText, context),
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
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

                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cubit.packages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      child: Container(
                        height: (MediaQuery
                            .of(context)
                            .size
                            .height / 2) - 80,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,

                        decoration: BoxDecoration(
                          color: AppColors.paymentDialog,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            ManageNetworkImage(
                              imageUrl: "https:\/\/loyalty.topbusiness.io\/storage\/uploads\/categories\/aW1hZ2VfY3JvcHBlcl8xNjc2ODc4OTY2NDU4LnBuZw==_1676878976.png",

                              height: 200,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              borderRadius: 10,
                            ),

                            RichText(
                              text: TextSpan(
                                style: TextStyle(color: AppColors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: replaceToArabicNumber(
                                      '${cubit.packages[index].price ??
                                          0}',
                                    ),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: AppColors.black),
                                  ),
                                  TextSpan(
                                    text: '  ريال',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: AppColors.textBackground,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () =>
                                  context
                                      .read<ProfileCubit>()
                                      .onRechargeWallet(
                                      cubit.packages[index].price!,
                                      context),
                              child: Text(
                                translateText('request', context),
                                style: TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: AppColors.textBackground,
                                side: BorderSide(
                                    color: AppColors.textBackground,
                                    width: 2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },

                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
