import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/feature/menu/cubit/menu_cubit.dart';
import 'package:walaa_customer/feature/menu/screens/the_best_product_widget.dart';
import 'package:walaa_customer/feature/navigation_bottom/cubit/navigator_bottom_cubit.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/translate_text_method.dart';
import '../../../core/widgets/circle_network_image.dart';
import '../../../core/widgets/no_item_page.dart';
import '../../../core/widgets/search_page.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../home page/cubit/home_cubit.dart';
import '../../home page/models/providers_model.dart';
import '../widget/category_list.dart';
import '../widget/product_list.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key, required this.providerModel}) : super(key: key);

  final ProviderModel providerModel;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MenuCubit>().selectItem = 0;
    context.read<MenuCubit>().phone=widget.providerModel.phone!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            width: double.infinity,
            child: Card(
              elevation: 8,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
              ),
              color: AppColors.textBackground,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              showSearch(
                                context: context,
                                delegate: SearchPage(
                                  provider_id: widget.providerModel.id,
                                  phone:widget.providerModel.phone!
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.search,
                              color: AppColors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_forward,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Row(
                          children: [
                            ManageNetworkImage(
                              imageUrl: widget.providerModel.image!,
                              height: 50,
                              width: 50,
                            ),
                            SizedBox(width: 8),
                            RichText(
                              text: TextSpan(
                                // text: 'Hello ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Cairo',
                                ),
                                children: <TextSpan>[
                                  TextSpan(text:translateText("welcome_you",context) ),
                                  TextSpan(
                                    text: widget.providerModel.name!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (widget.providerModel.categories!.length > 0) ...{
            BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                MenuCubit cubit = context.read<MenuCubit>();
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ListView(
                      children: [
                        TitleWithCircleBackgroundWidget(title: 'categories'),
                        CategoryList(providerModel: widget.providerModel),
                        Visibility(
                          visible: cubit.bestProductList.isNotEmpty,
                          child: TitleWithCircleBackgroundWidget(
                            title: 'best_provider',
                          ),
                        ),
                        Visibility(
                          visible: cubit.bestProductList.isNotEmpty,
                          child: TheBestProductWidget(),
                        ),
                        TitleWithCircleBackgroundWidget(title: 'drinks'),
                        ProductList(providerModel: widget.providerModel)
                      ],
                    ),
                  ),
                );
              },
            ),
          } else ...{
            Expanded(
              child: NoItemPage(),
            )
          },
        ],
      ),
      floatingActionButton:
      FloatingActionButton(
        backgroundColor: AppColors.primary,
        child:Icon(Icons.shopping_cart,color: AppColors.white,), onPressed: () {
        context.read<NavigatorBottomCubit>().changePage(1);
        Navigator.pop(context);
      },),
    );
  }
}
