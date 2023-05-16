import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';

import '../../config/routes/app_routes.dart';
import '../../feature/home page/cubit/home_cubit.dart';
import '../../feature/home page/models/providers_model.dart';
import '../../feature/menu/cubit/menu_cubit.dart';
import '../../feature/menu/screens/menu_screen.dart';
import '../../feature/menu/widget/product_widget.dart';
import '../utils/assets_manager.dart';
import 'network_image.dart';

class SearchPage extends SearchDelegate {
  final List<ProviderModel?>? data;
  final int? provider_id;

  SearchPage({this.data, this.provider_id});

  int choiceIndex = 0;
  List<String?> titleData = ['بحث بالقسم', 'بحث بالمنتج'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: AppColors.white,
        ),
        onPressed: () {
          query = '';
          // categoryController.searchedProductsh.clear();
        },
      ),
    ];
  }

  // @override
  // PreferredSizeWidget? buildBottom(BuildContext context) {
  //   return PreferredSize(
  //     preferredSize: const Size.fromHeight(60),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         const SizedBox(width: 1),
  //         ...List.generate(
  //           titleData.length,
  //           (index) => ChoiceChip(
  //             labelPadding: const EdgeInsets.all(4),
  //             label: Text(titleData[index]!),
  //             selected: categoryController.searchTypeIndex == index,
  //             selectedColor: Get.theme.primaryColor,
  //             onSelected: (value) {
  //               query = '.';
  //               query = '';
  //               index == 1 ? cartController.fetchCart() : null;
  //               categoryController.searchTypeIndex = (value ? index : null)!;
  //             },
  //           ),
  //         ),
  //         const SizedBox(width: 1),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColors.white,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return data != null ? searchCategory() : searchProduct();
  }

  Widget searchProduct() {
    // if (data!.isEmpty) return const Text('لا يوجد نتائج');

    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        MenuCubit cubit = context.read<MenuCubit>();
        return query == ''||query.length<0
            ? Column(
                children: [
                  Spacer(),
                  SizedBox(height: 40),
                  SvgPicture.asset(ImageAssets.searchPhotoIcon),
                  SizedBox(height: 25, width: double.infinity),
                  Text(
                    'لنجد ما تريد البحث عنه',
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 22,
                        fontFamily: 'Cairo'),
                  ),
                  Spacer(),
                  Spacer(),
                ],
              )
            : state is AllProductSearchLoading
                ? Column(
                    children: [
                      Spacer(),
                      SizedBox(width: MediaQuery.of(context).size.width),
                      CircularProgressIndicator(color: AppColors.primary),
                      Spacer(),
                    ],
                  )
                : ListView(
                    children: [
                      SizedBox(height: 25),
                      ...List.generate(
                        cubit.searchProductList.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.89,
                            height: MediaQuery.of(context).size.height * 0.11,

                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: ProductWidget(
                                model: cubit.searchProductList[index],
                                type: 'best',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
      },
    );
  }

  Widget searchCategory() {
    if (data!.isEmpty) return const Text('لا يوجد نتائج');

    final results = data!.where((a) => a!.name!.contains(query));

    return query == ''
        ? Column(
            children: [
              Spacer(),
              SizedBox(height: 40),
              SvgPicture.asset(ImageAssets.searchPhotoIcon),
              SizedBox(height: 25, width: double.infinity),
              Text(
                'لنجد ما تريد البحث عنه',
                style: TextStyle(
                    color: AppColors.black, fontSize: 22, fontFamily: 'Cairo'),
              ),
              Spacer(),
              Spacer(),
            ],
          )
        : ListView(
            children: results
                .map<Widget>(
                  (a) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height: 60,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          onTap: () {
                            Get.to(MenuScreen(providerModel: a));
                          },
                          minLeadingWidth: 60,
                          leading: ManageNetworkImage(
                            imageUrl: a!.image!,
                            borderRadius: 28,
                            width: 60,
                            height: 120,
                          ),
                          title: Text(
                            a.name!,
                            style: Get.textTheme.bodyMedium!.copyWith(
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (data == null) {
      context.read<MenuCubit>().searchProductList.clear();
      context.read<MenuCubit>().searchProduct(provider_id!, query);
    }

    return data != null ? searchCategory() : searchProduct();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: AppColors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      appBarTheme: AppBarTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(18),
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: AppColors.textBackground,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
        titleTextStyle: TextStyle(color: AppColors.white),
        toolbarTextStyle: TextStyle(color: AppColors.error),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: AppColors.white),
        labelStyle: TextStyle(color: AppColors.white),
        border: InputBorder.none,
      ),
    );
  }
}
