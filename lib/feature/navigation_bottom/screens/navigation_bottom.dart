import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/widgets/no_login_page.dart';
import '../../../core/models/login_model.dart';
import '../../home page/screens/home_page.dart';
import '../../profile/presentation/screens/profile.dart';
import '../cubit/navigator_bottom_cubit.dart';
import '../widget/navigator_bottom_widget.dart';

class NavigationBottom extends StatefulWidget {
  NavigationBottom({Key? key, required this.loginModel}) : super(key: key);

  final LoginModel loginModel;

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBottomCubit, NavigatorBottomState>(
        builder: (context, state) {
      NavigatorBottomCubit bottomCubit = context.read<NavigatorBottomCubit>();
      return Scaffold(
          bottomNavigationBar: SizedBox(
            height: 60,
            child: NavigatorBottomWidget(),
          ),
          body: BlocBuilder<NavigatorBottomCubit, NavigatorBottomState>(
            builder: (context, state) {
              if (bottomCubit.page == 1) {
                return widget.loginModel.data != null
                    ? ProfileScreen()
                    : NotLoginPage();
              } else {
                return HomePageScreen();
              }
            },
          ));
    });
  }
}
