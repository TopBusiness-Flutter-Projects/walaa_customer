import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:walaa_customer/core/utils/assets_manager.dart';
import 'package:walaa_customer/feature/menu/cubit/menu_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/widgets/network_image.dart';
import '../../menu/screens/menu_screen.dart';
import '../models/providers_model.dart';

class CoffeeListWidget extends StatelessWidget {
  const CoffeeListWidget({Key? key, required this.coffeeModel})
      : super(key: key);

  final List<ProviderModel> coffeeModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          coffeeModel.length,
          (index) => Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuScreen(
                        providerModel: coffeeModel[index],
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: CircleAvatar(
                          backgroundColor: AppColors.white,
                          child: ManageNetworkImage(
                            imageUrl: coffeeModel[index].image!,
                            width: 90,
                            height: 90,
                            borderRadius: 10,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                SizedBox(width: 8),
                                Text(coffeeModel[index].rate.toString()),
                                SizedBox(width: 12),
                              ],
                            ),
                            // SizedBox(height: 30),
                            Text(coffeeModel[index].name!),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Visibility(
                  visible: index != coffeeModel.length - 1,
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
