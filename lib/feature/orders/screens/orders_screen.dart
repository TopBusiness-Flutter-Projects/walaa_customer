import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/feature/orders/screens/order_page.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/translate_text_method.dart';
import '../cubit/order_cubit.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  List<String> titles = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(context.read<OrderCubit>().currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    titles=[
      translateText(
          AppStrings.currentOrderText,context ),
      translateText(
          AppStrings.previousOrderText, context),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.seconedprimary,
        flexibleSpace: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            ImageAssets.whiteWalaaLogoImage,
            height: 70,
            width: 70,
          ),
        ),
        title: Center(
            child: Text(
              translateText(
                  AppStrings.myorderText, context),
          style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        )),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          OrderCubit cubit = context.read<OrderCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 8,
                      ),
                      child: InkWell(
                        onTap: () {
                          cubit.selectTap(0);
                          print(cubit.currentIndex);
                          _tabController.animateTo(0);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: cubit.currentIndex == 0
                                ? AppColors.seconedprimary
                                : AppColors.gray2,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              titles[0],
                              style: TextStyle(
                                color: cubit.currentIndex == 0
                                    ? AppColors.white
                                    : AppColors.gray1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 8,
                      ),
                      child: InkWell(
                        onTap: () {
                          cubit.selectTap(1);
                          print(cubit.currentIndex);
                          _tabController.animateTo(1);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: cubit.currentIndex == 1
                                ? AppColors.seconedprimary
                                : AppColors.gray2,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              titles[1],
                              style: TextStyle(
                                color: cubit.currentIndex == 1
                                    ? AppColors.white
                                    : AppColors.gray1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                      OrderPage(type: "current"),
                      OrderPage(type: "previous",)
                      //OrdersDataWidget(),
                      //   OrdersDataWidget(),
                      //  OrdersDataWidget(),
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
