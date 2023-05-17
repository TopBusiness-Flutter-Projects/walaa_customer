import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/menu_cubit.dart';
import '../widget/product_widget.dart';

class TheBestProductWidget extends StatelessWidget {
  const TheBestProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        print('object');
        MenuCubit menuCubit = context.read<MenuCubit>();
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.89,
          height: MediaQuery.of(context).size.height * 0.18,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  menuCubit.bestProductList.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.89,
                      height: MediaQuery.of(context).size.height * 0.14,
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: ProductWidget(
                          model: menuCubit.bestProductList[index],
                          type: 'best',
                          phone: menuCubit.phone!,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
