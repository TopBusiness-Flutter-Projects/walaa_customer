import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';
import 'package:walaa_customer/core/utils/assets_manager.dart';
import 'package:walaa_customer/core/utils/translate_text_method.dart';
import 'package:walaa_customer/core/widgets/custom_button.dart';
import 'package:walaa_customer/core/widgets/custom_textfield.dart';
import 'package:walaa_customer/feature/home%20page/cubit/home_cubit.dart';
import 'package:walaa_customer/feature/home%20page/cubit/home_cubit.dart';
import 'package:walaa_customer/feature/home%20page/models/providers_model.dart';

class RateWidget extends StatefulWidget {
  RateWidget(this.myRate, {Key? key}) : super(key: key);

  final MyRate? myRate;

  @override
  State<RateWidget> createState() => _RateWidgetState();
}

class _RateWidgetState extends State<RateWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if(widget.myRate!=null){
      context.read<HomeCubit>().rating = double.parse(widget.myRate!.value!);
      context.read<HomeCubit>().rateController.text = widget.myRate!.comment!;
    }else{
      context.read<HomeCubit>().rating = 0.0;
      context.read<HomeCubit>().rateController.clear();

    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
        return Form(
          key: formKey,
          child: Container(
            color: AppColors.dialogBackgroundColor,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close,
                          color: AppColors.error,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  RatingBar.builder(
                    initialRating: cubit.rating,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: AppColors.buttonBackground,
                    ),
                    glowColor: AppColors.dialogBackgroundColor,
                    unratedColor: AppColors.white,
                    onRatingUpdate: (rating) {
                      cubit.rating = rating;
                      print(rating);
                    },
                  ),
                  SizedBox(
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.90,
                  ),
                  CustomTextField(
                    image: ImageAssets.writeCommentIcon,

                    title: translateText('add_rating', context),
                    textInputType: TextInputType.text,
                    backgroundColor: AppColors.white,
                    minLine: 5,
                    horizontalPadding: 1,
                    controller: cubit.rateController,
                    validatorMessage: translateText('rate_validation', context),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomButton(
                    text: translateText('add', context),
                    color: AppColors.buttonBackground,
                    onClick: () {
                      if (formKey.currentState!.validate()) {
                        print('gghghhgghghghgh');
                        print(cubit.rateController.text);
                        print(cubit.rating);
                        cubit.rateProvider(context,cubit.rateController.text,cubit.rating,widget.myRate!.providerId.toString());
                      }
                    },
                    paddingHorizontal: MediaQuery.of(context).size.width * 0.15,
                    borderRadius: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
