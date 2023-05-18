import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:walaa_customer/core/widgets/custom_button.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/cart_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/translate_text_method.dart';
import '../../../core/widgets/outline_button_widget.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../../menu/cubit/menu_cubit.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/cart_model_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartModel? cartModel;

  TextEditingController _typeAheadController = TextEditingController();

  TextEditingController _typenameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getTotalPrice();
    getAllProductInCart(context);
    context.read<CartCubit>().getUserData();
  }

  getAllProductInCart(context) async {
    cartModel = await Preferences.instance.getCart();
    Future.delayed(Duration(milliseconds: 1000), () {});
    setState(() {
      cartModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<CartCubit>().getTotalPrice();
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
            ),
            width: double.infinity,
            child: Center(
              child: Card(
                elevation: 8,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25)),
                ),
                color: AppColors.textBackground,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        child: Image.asset(
                          ImageAssets.whiteWalaaLogoImage,
                          height: 70,
                          width: 70,
                        ),
                      ),
                      Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Center(
                              child: Text(
                                translateText(
                                    AppStrings.cartText, context),
                            style:
                                TextStyle(color: AppColors.white, fontSize: 16),
                          ))),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: cartModel == null
                ? ShowLoadingIndicator()
                : RefreshIndicator(
                    onRefresh: () async {
                      getAllProductInCart(context);
                    },
                    child: cartModel!.productModel!.isNotEmpty
                        ? ListView(
                            shrinkWrap: true,
                            children: [
                              Column(
                                children: [
                                  ...List.generate(
                                    cartModel!.productModel!.length,
                                    (index) {
                                      return Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: CartModelWidget(
                                              model:
                                                  cartModel!.productModel![index],
                                            ),
                                          ),
                                          Positioned(
                                            top: 20,
                                            right: 10,
                                            child: IconButton(
                                              onPressed: () {
                                                Preferences.instance
                                                    .deleteProduct(cartModel!
                                                        .productModel![index],context);
                                                Future.delayed(
                                                    Duration(milliseconds: 250),
                                                    () {
                                                  getAllProductInCart(context);
                                                });
                                              },
                                              icon: Icon(
                                                Icons.close_sharp,
                                                color: AppColors.error,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  BlocBuilder<CartCubit, CartState>(
                                    builder: (context, state) {
                                      return cartModel!.productModel!.isNotEmpty
                                          ? Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    translateText(
                                                        AppStrings.totalPriceText, context),
                                                    style: TextStyle(
                                                        color: AppColors.gray1,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(width: 22),
                                                  Container(
                                                    width: 90,
                                                    height: 45,
                                                    child: Center(
                                                      child: Text(
                                                        '${context.read<CartCubit>().totalPrice}' +
                                                            translateText(
                                                                AppStrings.SARText, context),
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors.gray1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox();
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  cartModel!.productModel!.isNotEmpty
                                      ? CustomButton(
                                          color: AppColors.seconedprimary,
                                          paddingHorizontal: 70,
                                          text:  translateText(
                                              AppStrings.confirmBtn, context),

                                          onClick: () {
                                            if (context
                                                    .read<CartCubit>()
                                                    .userModel
                                                    .data !=
                                                null) {
                                              context.read<CartCubit>().sendorder(
                                                  this.cartModel!, this.context);
                                            }
                                            else{
                                              Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginRoute,
                                                ModalRoute.withName(
                                                  Routes.initialRoute,
                                                ),);

                                            }
                                          },
                                        )
                                      : SizedBox(),
                                  SizedBox(height: 20),
                                ],
                              )
                            ],
                          )
                        : Center(child: Text('no_data_found')),
                  ),
          ),
        ],
      ),
    );
  }

// openDialog(BuildContext context) {
//   String date =
//       '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}  ${DateTime.now().hour > 12 ? '0${DateTime.now().hour - 12}' : DateTime.now().hour}:${DateTime.now().minute}';
//   final formKey = GlobalKey<FormState>();
//   showDialog(
//     context: context,
//     builder: (ctx) => AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(20.0),
//         ),
//       ),
//       titlePadding: EdgeInsets.zero,
//       content: BlocBuilder<MenuCubit, MenuState>(
//         builder: (context, state) {
//           return SizedBox(
//             width: MediaQuery.of(context).size.width - 40,
//             height: null,
//             child: Form(
//               key: formKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text('order'),
//                         IconButton(
//                           onPressed: () => {
//                             Navigator.pop(context),
//                             this._typenameController.text = "",
//                             this._typeAheadController.text = ""
//                           },
//                           icon: Icon(
//                             Icons.close,
//                             color: AppColors.seconedprimary,
//                           ),
//                         ),
//                       ],
//                     ),
//                     TextFormField(
//                       maxLines: 1,
//                       cursorColor: AppColors.seconedprimary,
//                       keyboardType: TextInputType.text,
//                       controller: _typenameController,
//                       textInputAction: TextInputAction.next,
//                       onChanged: (data) {},
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'field_required';
//                         } else {
//                           return null;
//                         }
//                       },
//                       decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'first_name',
//                           hintStyle: TextStyle(
//                               color: AppColors.seconedprimary,
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.bold)),
//                     ),
//                     BrownLineWidget(),
//                     SizedBox(height: 8),
//                     TypeAheadFormField(
//                       textFieldConfiguration: TextFieldConfiguration(
//                           controller: this._typeAheadController,
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                               // Text field Decorations goes here
//                               hintText: 'phone',
//
//                               //   prefixIcon: Icon(Icons.edit),
//                               border: InputBorder.none)),
//                       suggestionsCallback: (pattern) {
//                         if (pattern.length > 7) {
//                           return context
//                               .read<CartCubit>()
//                               .getSuggestions(pattern);
//                         } else {
//                           return [];
//                         }
//                       },
//                       itemBuilder: (context, dynamic suggestion) {
//                         //TODO: replace <T> with your return type
//
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(suggestion['phone']),
//                         );
//                       },
//                       transitionBuilder:
//                           (context, suggestionsBox, controller) {
//                         return suggestionsBox;
//                       },
//                       onSuggestionSelected: (dynamic suggestion) {
//                         //TODO: replace <T> with your return type
//                         this._typeAheadController.text = suggestion['phone'];
//                         this._typenameController.text = suggestion['name'];
//                       },
//                       onSaved: (value) {
//                         //  _transaction.name = value;
//                       },
//                     ),
//                     BrownLineWidget(),
//                     SizedBox(height: 32),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('total_price'),
//                         SizedBox(width: 22),
//                         Container(
//                           decoration: BoxDecoration(
//                               color: AppColors.seconedprimary,
//                               borderRadius: BorderRadius.circular(8)),
//                           width: 90,
//                           height: 45,
//                           child: Center(
//                             child: Text(
//                               '${context.read<CartCubit>().totalPrice}',
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('date'),
//                         SizedBox(width: 22),
//                         Text(
//                           date,
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: AppColors.seconedprimary,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 30),
//                     OutLineButtonWidget(
//                       text: 'confirm',
//                       borderColor: AppColors.success,
//                       onclick: () {
//                         if (formKey.currentState!.validate()) {
//                           this.cartModel!.phone =
//                               this._typeAheadController.text;
//                           this._typenameController.text = "";
//                           this._typeAheadController.text = "";
//                           String lang = EasyLocalization.of(context)!
//                               .locale
//                               .languageCode;
//
//                           Navigator.pop(context);
//                           context
//                               .read<CartCubit>()
//                               .sendorder(this.cartModel!, this.context, lang);
//                         }
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     ),
//   );
// }
}
