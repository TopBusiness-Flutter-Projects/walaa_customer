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

    _tabController = TabController(length: 2, vsync: this);
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
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          OrderCubit cubit = context.read<OrderCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),),
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
                          Text(
                            translateText(AppStrings.myorderText, context),
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: ()=>Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_forward,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
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
