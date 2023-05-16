import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/utils/app_strings.dart';
import 'package:walaa_customer/core/utils/translate_text_method.dart';
import 'package:walaa_customer/feature/menu/widget/product_widget.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/no_item_page.dart';
import '../../home page/models/providers_model.dart';
import '../cubit/menu_cubit.dart';
import '../models/product_data_model.dart';
import '../models/product_model.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key, required this.providerModel}) : super(key: key);
  final ProviderModel providerModel;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
    context.read<MenuCubit>().getProduct(
          widget.providerModel.categories!.first.id!,
        );
    context.read<MenuCubit>().categoryModel =
        widget.providerModel.categories!.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        MenuCubit menuCubit = context.read<MenuCubit>();
        List<ProductItemModel> list = [];
        if (menuCubit.productList.isNotEmpty) {
          list = menuCubit.productList;
        }
        if (menuCubit.productLength > 0)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                list.length > 0 ? list.length : menuCubit.productLength,
                (index) => Container(
                  child: state is AllProductLoading
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : state is AllProductError
                          ? Center(
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.refresh),
                              ),
                            )
                          : menuCubit.productList.isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        title: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          child: Center(
                                              child: Text(menuCubit
                                                  .categoryModel!
                                                  .categoryName!)),
                                        ),
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: menuCubit
                                                    .productList[index].image!,
                                                imageBuilder:
                                                    (context, imageProvider) {
                                                  return CircleAvatar(
                                                      backgroundImage:
                                                          imageProvider);
                                                },
                                                width: 100.0,
                                                height: 100.0,
                                                fit: BoxFit.cover,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 5,
                                                      ),
                                                      child: Text(
                                                        menuCubit
                                                            .productList[index]
                                                            .name!,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 5,
                                                      ),
                                                      child: Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          color: AppColors
                                                              .onBoardingColor,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            menuCubit
                                                                .productList[
                                                                    index]
                                                                .price
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(
                                              translateText(
                                                AppStrings.cancelBtn,
                                                context,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      ProductWidget(
                                        model: context
                                            .read<MenuCubit>()
                                            .productList
                                            .elementAt(index),
                                        type: 'products',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Visibility(
                                          visible: index !=
                                              menuCubit.productList.length - 1,
                                          child: Divider(
                                            thickness: 2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                ),
                ),
              ),
            ],
          );
        else {
          return NoItemPage();
        }
      },
    );
  }
}
