import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';
import 'package:walaa_customer/core/utils/translate_text_method.dart';
import 'package:walaa_customer/feature/profile/presentation/cubit/profile_cubit.dart';

import '../../../../core/utils/convert_numbers_method.dart';

class PaymentPackage extends StatelessWidget {
  const PaymentPackage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        ProfileCubit cubit = context.read<ProfileCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.error,
                          ),
                          child: Icon(
                            Icons.clear,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    translateText('choose_payment_package', context),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                ),
                ...List.generate(
                  cubit.packages.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 0.0),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.paymentDialog,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(color: AppColors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: replaceToArabicNumber(
                                      '${cubit.packages[index].price ?? 0}',
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
                          ),
                          OutlinedButton(
                            onPressed: () => context
                                .read<ProfileCubit>()
                                .onRechargeWallet(
                                    cubit.packages[index].price!, context),
                            child: Text(
                              translateText('request', context),
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.textBackground,
                              side: BorderSide(
                                  color: AppColors.textBackground, width: 2),
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
      },
    );
  }
}
