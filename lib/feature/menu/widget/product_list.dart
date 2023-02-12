import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/utils/app_strings.dart';
import 'package:walaa_customer/core/utils/translate_text_method.dart';
import 'package:walaa_customer/feature/menu/widget/product_widget.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/no_item_page.dart';
import '../../home page/models/providers_model.dart';
import '../cubit/menu_cubit.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        MenuCubit menuCubit = context.read<MenuCubit>();
        List<ProductModel> list = [];
        if (menuCubit.productList.isNotEmpty) {
          list = menuCubit.productList;
        }
        if (menuCubit.productLength > 0)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  translateText(AppStrings.chooseCoffeeText, context),
                  style: TextStyle(
                    color: AppColors.iconBackgroundColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .8,
                  mainAxisSpacing: 1,
                  crossAxisCount: 2,
                ),
                itemCount: list.length > 0 ? list.length : menuCubit.productLength,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: state is AllProductLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
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
                                ? Padding(
                                    padding: EdgeInsets.all(25.0),
                                    child: ProductWidget(
                                      model: context
                                          .read<MenuCubit>()
                                          .productList
                                          .elementAt(index),
                                    ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primary,
                                    ),
                                  ),
                  );
                },
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
