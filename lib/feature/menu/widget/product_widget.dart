import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/circle_network_image.dart';
import '../models/product_data_model.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key? key, required this.model, required this.type})
      : super(key: key);
  final ProductItemModel model;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircleAvatar(
              backgroundColor: AppColors.white,
              child: ManageNetworkImage(
                imageUrl: model.image!,
                width: 60,
                height: 60,
                borderRadius: 10,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name!,style: TextStyle(color: AppColors.textBackground),),
                Row(
                  children: [
                    Stack(
                      children: [
                        Text(
                          '${model.price!}  ريال ',
                          style: TextStyle(
                            fontSize: 14,
                            color: model.priceAfterDiscount != null
                                ? AppColors.error
                                : AppColors.textBackground,
                          ),
                        ),
                        Visibility(
                          visible: model.priceAfterDiscount != null,
                          child: Positioned(
                            top: 0,
                            left: 0,
                            bottom: 0,
                            right: 0,
                            child: Row(
                              children: [
                                Container(
                                  width: 42,
                                  height: 1,
                                  color: AppColors.error,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 12),
                    Visibility(
                      visible: model.priceAfterDiscount != null,
                      child: Text(
                        '${model.priceAfterDiscount ?? 0}  ريال ',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textBackground,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    print('00000000033333000000000000003333');
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: type == 'best'
                              ? AppColors.white
                              : AppColors.gray,
                          width: 1),
                      color: type == 'best'
                          ? AppColors.textBackground
                          : AppColors.white,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_shopping_cart_outlined,
                          size: 18,
                          color: type == 'best'
                              ? AppColors.white
                              : AppColors.black,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'اضف الى السلة',
                          style: TextStyle(
                            fontSize: 12,
                            color: type == 'best'
                                ? AppColors.white
                                : AppColors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
