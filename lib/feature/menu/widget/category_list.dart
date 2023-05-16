import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';

import '../../../core/widgets/circle_network_image.dart';
import '../../home page/models/providers_model.dart';
import '../cubit/menu_cubit.dart';
import 'category_widget.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key, required this.providerModel}) : super(key: key);
  final ProviderModel providerModel;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        MenuCubit menuCubit = context.read<MenuCubit>();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                widget.providerModel.categories!.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        color: menuCubit.selectItem == index
                            ? AppColors.buttonBackground
                            : AppColors.menuTapColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: InkWell(
                      onTap: () {
                        menuCubit.getProduct(
                          widget.providerModel.categories![index].id!,
                        );
                        menuCubit.categoryModel =
                            widget.providerModel.categories![index];
                        menuCubit.selectItem = index;
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white,
                              ),
                              child: ManageNetworkImage(
                                imageUrl: widget
                                    .providerModel.categories![index].image!,
                                height: 25,
                                width: 25,
                                borderRadius: 25,
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              widget.providerModel.categories![index]
                                  .categoryName!,
                              style: TextStyle(
                                fontSize: 16,
                                color: menuCubit.selectItem == index
                                    ? AppColors.white
                                    : AppColors.textBackground,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
