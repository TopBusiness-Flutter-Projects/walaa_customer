import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/translate_text_method.dart';
import '../../../core/widgets/no_item_page.dart';
import '../../home page/models/providers_model.dart';
import '../widget/category_list.dart';
import '../widget/product_list.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key, required this.providerModel}) : super(key: key);

  final ProviderModel providerModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            child: Card(
              elevation: 8,
              margin: EdgeInsets.zero,
              color: AppColors.containerBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      translateText(AppStrings.menuText, context),
                      style: TextStyle(color: AppColors.textBackground),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          if (providerModel.categories!.length > 0) ...{
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(translateText(AppStrings.perfectDayText, context)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView(
                  children: [
                    CategoryList(providerModel: providerModel),
                    ProductList(
                      providerModel: providerModel,
                    )
                  ],
                ),
              ),
            ),
          } else ...{
            Expanded(child: NoItemPage(),)

          },
        ],
      ),
    );
  }
}
