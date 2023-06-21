import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/feature/home%20page/screens/cafe_page.dart';
import 'package:walaa_customer/feature/home%20page/screens/restuarnt_page.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/translate_text_method.dart';
import '../../../core/widgets/search_page.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../cubit/home_cubit.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin {
  List<String> titles = [

  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(context.read<HomeCubit>().currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    titles=[ translateText("cafe",context),
      translateText("restuarant",context)];
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          HomeCubit cubit = context.read<HomeCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: null,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageAssets.whiteWalaaLogoImage,
                            height: 70,
                            width: 70,
                          ),
                          IconButton(
                            onPressed: () {
                              showSearch(
                                context: context,
                                delegate: SearchPage(
                                    data: context.read<HomeCubit>().providerModelList,
                                    phone: ''
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.search,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...List.generate(
                        titles.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 8,
                          ),
                          child: InkWell(
                            onTap: () {

                              cubit.selectTap(index);
                              print(cubit.currentIndex);
                              _tabController.animateTo(index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: cubit.currentIndex == index
                                    ? AppColors.primary
                                    : AppColors.scaffoldBackground,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  titles[index],
                                  style: TextStyle(
                                    color: cubit.currentIndex == index
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    print(88888);
                  },
                  child: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      CafePageScreen(),
                      RestaurantPageScreen(),
                   
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
