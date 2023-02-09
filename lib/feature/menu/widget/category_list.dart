import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home page/models/providers_model.dart';
import '../cubit/menu_cubit.dart';
import 'category_widget.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key, required this.providerModel}) : super(key: key);
  final ProviderModel providerModel;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        MenuCubit menuCubit = context.read<MenuCubit>();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                widget.providerModel.categories!.length,
                (index) => InkWell(
                  onTap: () {
                    menuCubit.getProduct(
                      widget.providerModel.categories![index].id!,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CategoryWidget(
                      model: widget.providerModel.categories![index],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
