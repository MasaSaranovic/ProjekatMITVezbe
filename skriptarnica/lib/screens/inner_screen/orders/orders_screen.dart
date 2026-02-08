import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skriptarnica/models/order_model.dart';
import 'package:skriptarnica/providers/order_provider.dart';
import 'package:skriptarnica/screens/inner_screen/orders/orders_widget.dart';
import 'package:skriptarnica/services/assets_manager.dart';
import 'package:skriptarnica/widgets/empty_bag.dart';
import 'package:skriptarnica/widgets/title_text.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';
  const OrdersScreen({super.key});
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const TitelesTextWidget(
            label: 'Placed orders',
          ),
        ),
        body: FutureBuilder<List<OrdersModel>>(
          future: ordersProvider.fetchOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: SelectableText(snapshot.error.toString()),
              );
            } else if (!snapshot.hasData || ordersProvider.getOrders.isEmpty) {
              return EmptyBagWidget(
                imagePath: "${AssetsManager.imagePath}/bag/checkout.png",
                title: "No orders has been placed yet",
                subtitle: "",
                buttonText: "Shop now",
              );
            }
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: OrdersWidget(
                      ordersModel: ordersProvider.getOrders[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                    // thickness: 8,
                    // color: Colors.red,
                    );
              },
            );
          },
        ));
  }
}
