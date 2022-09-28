import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/orders/cubit/order_cubit.dart';
import 'package:online_helper/orders/cubit/order_states.dart';
import 'package:online_helper/shared/component/no_data.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var orderCubit = OrderCubit.get(context);
          return Scaffold(
            body: orderCubit.orders.length == 0
                ? noData()
                : ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Text('data');
                    },
                  ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              label: Text(
                'Add order',
              ),
            ),
          );
        });
  }
}
