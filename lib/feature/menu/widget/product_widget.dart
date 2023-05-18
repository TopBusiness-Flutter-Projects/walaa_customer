import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/feature/navigation_bottom/cubit/navigator_bottom_cubit.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/translate_text_method.dart';
import '../../../core/widgets/circle_network_image.dart';
import '../../../core/widgets/outline_button_widget.dart';
import '../cubit/menu_cubit.dart';
import '../models/product_data_model.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key? key,
    required this.model,
    required this.type,
    required this.phone,
  }) : super(key: key);
  final ProductItemModel model;
  final String type;
  final String phone;

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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                style: TextStyle(color: AppColors.textBackground),
              ),
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
                          color:
                              type == 'best' ? AppColors.white : AppColors.gray,
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

  openDialog(ProductItemModel model, BuildContext context) {
    print(phone);

    MenuCubit cubit = context.read<MenuCubit>();
    cubit.itemPrice = model.priceAfterDiscount == 0
        ? model.price! as int
        : model.priceAfterDiscount as int;
    cubit.itemCount = 1;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        titlePadding: EdgeInsets.zero,
        content: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: CachedNetworkImage(
                            imageUrl: model.image!,
                            imageBuilder: (context, imageProvider) {
                              return CircleAvatar(
                                  backgroundImage: imageProvider);
                            },
                            width: 60.0,
                            height: 60.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Text(
                                model.name!,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${cubit.itemPrice} ' +
                                    translateText(AppStrings.SARText, context),
                                style: TextStyle(color: AppColors.primary),
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: null,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () => cubit.changeItemCount(
                                              '+',
                                              model.priceAfterDiscount == 0
                                                  ? model.price!
                                                  : model.priceAfterDiscount!),
                                          child: Icon(
                                            Icons.add,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Text(
                                          '${cubit.itemCount}',
                                          style:
                                              TextStyle(color: AppColors.white),
                                        ),
                                        SizedBox(width: 16),
                                        InkWell(
                                          onTap: () => cubit.changeItemCount(
                                            '-',
                                            model.priceAfterDiscount == 0
                                                ? model.price!
                                                : model.priceAfterDiscount!,
                                          ),
                                          child: Icon(
                                            Icons.remove,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Spacer(),
                        OutLineButtonWidget(
                          text: translateText(AppStrings.confirmBtn, context),
                          borderColor: AppColors.success,
                          onclick: () {
                            Navigator.pop(context);
                            Preferences.instance.addItemToCart(
                                model, cubit.itemCount, phone, context);
                          },
                        ),
                        Spacer(),
                        OutLineButtonWidget(
                          text: translateText(AppStrings.cancelBtn, context),
                          borderColor: AppColors.error,
                          onclick: () {
                            Navigator.pop(context);
                          },
                        ),
                        Spacer(),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
