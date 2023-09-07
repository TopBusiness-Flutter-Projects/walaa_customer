import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';
import 'package:walaa_customer/core/utils/translate_text_method.dart';

import '../../../core/widgets/network_image.dart';
import '../../menu/screens/menu_screen.dart';
import '../models/providers_model.dart';
import '../screens/advantages_screen.dart';

class TheBestCoffeeWidget extends StatelessWidget {
  const TheBestCoffeeWidget({Key? key, required this.bestModel})
      : super(key: key);

  final List<ProviderModel> bestModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 20),
            ...List.generate(
              bestModel.length,
              (index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuScreen(
                          providerModel: bestModel[index],
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 150,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ManageNetworkImage(
                              imageUrl: bestModel[index].image!,
                              width: 120,
                              height: 120,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
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
                                      Text(bestModel[index].rate.toString()),
                                      SizedBox(width: 12),
                                    ],
                                  ),
                                  Text(
                                    bestModel[index].name!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Expanded(
                                    child: Text(
                                      bestModel[index].description ?? '',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.dialog(
                                            AlertDialog(
                                              actionsPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 4),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 8, vertical: 4),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16)),
                                              backgroundColor:
                                                  AppColors.dialogBackgroundColor,
                                              content: AdvantagesScreen(
                                                model: bestModel[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          translateText('advantages', context),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.textBackground,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
