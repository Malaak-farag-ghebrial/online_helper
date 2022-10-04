import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/customer/cubit/customer_cubit.dart';
import 'package:online_helper/orders/cubit/order_cubit.dart';
import 'package:online_helper/orders/cubit/order_states.dart';
import 'package:online_helper/orders/widgets/order_card.dart';
import 'package:online_helper/orders/widgets/pop_up_add_order.dart';
import 'package:online_helper/product/cubit/product_cubit.dart';
import 'package:online_helper/shared/component/indicator.dart';
import 'package:online_helper/shared/component/no_data.dart';
import 'package:online_helper/shared/global_variable.dart';

import '../../shared/component/custom_navigator.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var orderCubit = OrderCubit.get(context);
          return DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 0,
                backgroundColor: Colors.white,
                elevation: 0,
                bottom: const TabBar(
                  physics: BouncingScrollPhysics(),
                    indicatorColor: Colors.grey,
                     labelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                  Tab(
                    text: 'PLACED',
                  ),
                  Tab(
                    text: 'BINDING',
                  ),
                  Tab(
                    text: 'DELIVERED',
                  ),
                ],
                ),
              ),
              body: TabBarView(
                physics: BouncingScrollPhysics(),
                    children: [
                      orderCubit.ordersPlaced.length == 0
                          ? noData()
                          : orderCubit.orders.length != orderCubit.productById.length
                          ? indicator()
                          :  ListView.builder(
                physics: const BouncingScrollPhysics(),
                          itemCount: orderCubit.ordersPlaced.length,
                          itemBuilder: (context, index) {
                            return orderCard(
                              product: orderCubit.productByIdPlaced[index],
                              order: orderCubit.ordersPlaced[index],
                              customer: orderCubit.customerByIdPlaced[index],
                              call: (){
                                CustomerCubit.get(context).callCustomer(orderCubit.customerByIdPlaced[index].phone!);
                              },
                                delete: (){
                                orderCubit.deleteOrder(orderCubit.ordersPlaced[index].id!, index,0);
                                },
                              edit: (){
                                if(orderCubit.ordersPlaced[index].status! < 2){
                                orderCubit.updateOrder(
                                   id: orderCubit.ordersPlaced[index].id!,
                                    status: orderCubit.ordersPlaced[index].status!,
                                  productId: orderCubit.ordersPlaced[index].productId,
                                  customerId: orderCubit.ordersPlaced[index].customerId,
                                  notes: orderCubit.ordersPlaced[index].notes,
                                );
                                }
                              },
                              context: context,
                            );
                          },
                        ),
                      orderCubit.ordersBinding.length == 0
                          ? noData()
                          : orderCubit.orders.length != orderCubit.productById.length
                          ? indicator()
                          :  ListView.builder(
                physics: const BouncingScrollPhysics(),
                          itemCount: orderCubit.ordersBinding.length,
                          itemBuilder: (context, index) {
                            return orderCard(
                              product: orderCubit.productByIdBinding[index],
                              order: orderCubit.ordersBinding[index],
                              customer: orderCubit.customerByIdBinding[index],
                              call: (){
                                CustomerCubit.get(context).callCustomer(orderCubit.customerByIdBinding[index].phone!);
                              },
                                delete: (){
                                orderCubit.deleteOrder(orderCubit.ordersBinding[index].id!, index,1);
                                },
                              edit: (){
                                if(orderCubit.ordersBinding[index].status! < 2){
                                orderCubit.updateOrder(
                                   id: orderCubit.ordersBinding[index].id!,
                                    status: orderCubit.ordersBinding[index].status!,
                                  productId: orderCubit.ordersBinding[index].productId,
                                  customerId: orderCubit.ordersBinding[index].customerId,
                                  notes: orderCubit.ordersBinding[index].notes,
                                );
                                }
                              },
                              context: context,
                            );
                          },
                        ),
                      orderCubit.ordersDelivered.length == 0
                          ? noData()
                          : orderCubit.orders.length != orderCubit.productById.length
                          ? indicator()
                          :  ListView.builder(
                physics: const BouncingScrollPhysics(),
                          itemCount: orderCubit.ordersDelivered.length,
                          itemBuilder: (context, index) {
                            return orderCard(
                              product: orderCubit.productByIdDelivered[index],
                              order: orderCubit.ordersDelivered[index],
                              customer: orderCubit.customerByIdDelivered[index],
                              call: (){
                                CustomerCubit.get(context).callCustomer(orderCubit.customerByIdDelivered[index].phone!);
                              },
                                delete: (){
                                orderCubit.deleteOrder(orderCubit.ordersDelivered[index].id!, index,1);
                                },
                              edit: (){
                                if(orderCubit.ordersDelivered[index].status! < 2){
                                orderCubit.updateOrder(
                                   id: orderCubit.ordersDelivered[index].id!,
                                    status: orderCubit.ordersDelivered[index].status!,
                                  productId: orderCubit.ordersDelivered[index].productId,
                                  customerId: orderCubit.ordersDelivered[index].customerId,
                                  notes: orderCubit.ordersDelivered[index].notes,
                                );
                                }
                              },
                              context: context,
                            );
                          },
                        ),
                    ],
                  ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx){
                    return addOrderPopUp(
                        notes: '',
                        context: context,
                      action: (){
                           orderCubit.addOrder(
                               productId: orderCubit.productId,
                               status: 0,
                               context: context,
                             custName: customerNameController.text,
                             custPhone: customerPhoneController.text,
                             custAddress: customerAddressController.text,
                             notes: notesController.text,
                           );
                           pop(context);
                           customerNameController.clear();
                           customerPhoneController.clear();
                           customerAddressController.clear();
                           notesController.clear();
                      }
                    );
                  },
                  );
                },
                label: const Text(
                  'Add order',
                ),
              ),
            ),
          );
        },
    );
  }
}
