import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';
import 'package:walaa_customer/core/utils/app_strings.dart';
import 'package:walaa_customer/core/utils/translate_text_method.dart';
import 'package:walaa_customer/core/widgets/brown_line_widget.dart';
import '../../../core/widgets/network_image.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../../menu/screens/menu_screen.dart';
import '../cubit/home_cubit.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

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
                      translateText(AppStrings.homeText, context),
                      style: TextStyle(color: AppColors.textBackground),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              translateText(AppStrings.perfectDayText, context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              translateText(AppStrings.chooseCoffeeText, context),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  HomeCubit cubit = context.read<HomeCubit>();
                  if (state is HomeProvidersLoading) {
                    return ShowLoadingIndicator();
                  }
                  if (state is HomeProvidersError) {
                    return RefreshIndicator(
                      onRefresh: () async => cubit.getAllProviders(),
                      child: ListView(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Text('There is An Error !!!'),
                                SizedBox(height: 20),
                                IconButton(
                                  onPressed: () => cubit.getAllProviders(),
                                  icon: Icon(
                                    Icons.refresh,
                                    color: AppColors.buttonBackground,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async => cubit.getAllProviders(),
                    child: ListView(
                      children: [
                        // TypeAheadField(
                        //   textFieldConfiguration: TextFieldConfiguration(
                        //       autofocus: true,
                        //       style: DefaultTextStyle.of(context).style.copyWith(
                        //           fontStyle: FontStyle.italic
                        //       ),
                        //       decoration: InputDecoration(
                        //           border: OutlineInputBorder()
                        //       )
                        //   ),
                        //   suggestionsCallback: (pattern) async {
                        //     return await BackendService.getSuggestions(pattern);
                        //   },
                        //   itemBuilder: (context, suggestion) {
                        //     return ListTile(
                        //       leading: Icon(Icons.shopping_cart),
                        //       title: Text(suggestion['name']),
                        //       subtitle: Text('\$${suggestion['price']}'),
                        //     );
                        //   },
                        //   onSuggestionSelected: (suggestion) {
                        //     // Navigator.of(context).push(MaterialPageRoute(
                        //     //     builder: (context) => ProductPage(product: suggestion)
                        //     // ));
                        //   },
                        // ),
                        ...List.generate(
                            cubit.providerModelList.length,
                            (index) => Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MenuScreen(
                                              providerModel: cubit
                                                  .providerModelList[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 90,
                                              height: 90,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    AppColors.white,
                                                child: ClipOval(
                                                  child: ManageNetworkImage(
                                                    imageUrl: cubit
                                                            .providerModelList[
                                                                index]
                                                            .image ??
                                                        'https://product-image.juniqe-production.juniqe.com/media/catalog/product/seo-cache/x800/34/83/34-83-101P/Stay-Cool-Balazs-Solti-Poster.jpg',
                                                    width: 90,
                                                    height: 90,
                                                    borderRadius: 140,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            Text(cubit.providerModelList[index]
                                                    .name ??
                                                'No Name'),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    BrownLineWidget(),
                                    SizedBox(height: 12),
                                  ],
                                ))
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
