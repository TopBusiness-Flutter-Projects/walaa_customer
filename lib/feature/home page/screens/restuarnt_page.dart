import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';
import 'package:walaa_customer/core/utils/app_strings.dart';
import 'package:walaa_customer/core/utils/assets_manager.dart';
import '../../../core/widgets/banner.dart';
import '../../../core/widgets/search_page.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../cubit/home_cubit.dart';
import '../widget/coffee_list_widget.dart';
import '../widget/the_best_widget.dart';

class RestaurantPageScreen extends StatelessWidget {
  const RestaurantPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                HomeCubit cubit = context.read<HomeCubit>();
                if (state is HomeProvidersLoading) {
                  return ShowLoadingIndicator();
                }
                if (state is HomeProvidersError) {
                  return RefreshIndicator(
                    onRefresh: () async => cubit.getHomeData(),
                    child: ListView(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text('There is An Error !!!'),
                              SizedBox(height: 20),
                              IconButton(
                                onPressed: () => cubit.getHomeData(),
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
                  onRefresh: () async => cubit.getHomeData(),
                  child: ListView(
                    children: [
                      BannerWidget(sliderData: cubit.sliderList),
                      TitleWithCircleBackgroundWidget(title: 'best_provider'),
                      TheBestCoffeeWidget(
                        bestModel: cubit.bestProviderModelList,
                      ),
                      TitleWithCircleBackgroundWidget(
                        title: AppStrings.chooseCoffeeText,
                      ),
                      CoffeeListWidget(coffeeModel: cubit.providerModelList),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
