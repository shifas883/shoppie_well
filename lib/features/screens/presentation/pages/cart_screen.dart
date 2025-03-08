import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shoppie_well/core/utils/common_button.dart';
import '../../../../core/utils/cart_card.dart';
import '../../../../core/utils/svgs.dart';
import '../providers/cart_provider.dart';
import 'check_out.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Cart",
        style: TextStyle(fontSize: 18.sp,color: Colors.black, fontWeight: FontWeight.w600),),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: cartProvider.items.isEmpty
          ?  Center(child: Text("Cart is Empty",
        style: TextStyle(fontSize: 18.sp,color: Colors.black, fontWeight: FontWeight.w600),))
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.string(ShoppieSvgs.location),
                    SizedBox(width: 5,),
                    Text("Delivery Address", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14.sp),),

                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 260.w,
                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 0.1),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2,
                                  offset: Offset(0, 3),
                                )
                              ]
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Address",style: TextStyle(fontSize: 14.sp,color: Colors.black,),),
                                Text("216 St Paul's Rd, London N1 2LL, UK Contact :  +44-784232",style: TextStyle(fontSize: 14.sp,color: Colors.black,),),
                              ],
                            )),
                        Positioned(
                          right: 2,top: 2,
                            height: 15.h,width: 15.w,
                            child: SvgPicture.string(ShoppieSvgs.edit))
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 27),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 0.1),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                offset: Offset(0, 3),
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(Icons.add_box_sharp)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Shopping List", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14.sp),),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                var cartItem = cartProvider.items.values.toList()[index];
                return CartCard(
                  onTap: (){
                    cartProvider.removeFromCart(cartItem.id);
                  },
                  item: cartItem,
                );

              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConfirmButton(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutScreen())),
              text: "Proceed to Checkout",
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
