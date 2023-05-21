import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';
import 'package:walaa_customer/core/utils/translate_text_method.dart';
import 'package:walaa_customer/feature/home%20page/cubit/home_cubit.dart';
import 'package:walaa_customer/feature/profile/presentation/cubit/profile_cubit.dart';

import '../../../../core/utils/convert_numbers_method.dart';
import '../models/providers_model.dart';

class AdvantagesScreen extends StatelessWidget {
  const AdvantagesScreen({Key? key, required this.model}) : super(key: key);

  final ProviderModel model ;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
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
                    translateText('advantages_desc', context),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                ),
                ...List.generate(
                  model.advantages!.length,
                  (index) => Stack(
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.paymentDialog,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Text(
                                    model.advantages![index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.textBackground,
                            shape: BoxShape.circle,
                          ),
                          child: Center(child: Text('${index + 1}',style: TextStyle(color: AppColors.white,fontSize: 12,fontWeight: FontWeight.bold),)),
                        ),
                      )
                    ],
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
