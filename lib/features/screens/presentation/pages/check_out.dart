import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shoppie_well/core/utils/common_button.dart';
import 'package:shoppie_well/core/utils/svgs.dart';
import '../providers/cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment() async {
    try {
      final response = await http.post(
        Uri.parse('http://your-server-ip:3000/create-payment-intent'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'amount': 1000, 'currency': 'usd'}),
      );

      final jsonResponse = jsonDecode(response.body);
      paymentIntent = jsonResponse;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['clientSecret'],
          merchantDisplayName: 'Your Business Name',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      setState(() {
        paymentIntent = null;
      });
      _showSuccessDialog();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment Successful")),
      );
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment Failed, Try Again with Another Payment Method")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title:  Text("Checkout",
        style: TextStyle(fontSize: 18.sp,color: Colors.black, fontWeight: FontWeight.w600),),
      centerTitle: true,
      leading: GestureDetector(onTap: () => Navigator.pop(context),child: Icon(Icons.arrow_back_ios, color: Colors.black,)),
      backgroundColor: Colors.white,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500
                ),),
                Text("\$${cartProvider.totalAmount.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                  ),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Shipping",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                  ),),
                Text("0",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                  ),),
              ],
            ),
          ),
          Divider(thickness: 1,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w800,
                      fontSize: 16.sp,
                  ),),
                Text("\$${cartProvider.totalAmount.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 16.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.w800,
                  ),),
              ],
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              cartProvider.clearCart();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Order placed successfully!')),
              );
              _showSuccessDialog();
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              margin: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.red
                ),
                borderRadius: BorderRadius.circular(5)
              ),
                child: Center(child: Text("Pay on Delivery",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp
                ),))),
          ),
          SizedBox(height: 10,),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 15),
            child: ConfirmButton(
              onTap: () async {
                await makePayment();
              },
              text:"Pay with Stripe",
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.string(ShoppieSvgs.order),
              SizedBox(height: 10),
              Text("Order Successfully Placed!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

}
