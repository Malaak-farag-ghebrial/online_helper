import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/models/customer_model.dart';
import 'package:online_helper/models/order_model.dart';
import 'package:online_helper/models/product_model.dart';
import 'package:online_helper/orders/cubit/order_states.dart';
import 'package:online_helper/shared/component/indicator.dart';

import '../../shared/constants/app_constants.dart';
import '../cubit/order_cubit.dart';

orderCard({
required ProductModel product,
required OrderModel order,
required CustomerModel customer,
  Function()? delete,
  Function()? edit,
  Function()? call,
  Color iconColor = Colors.white,
  required BuildContext context,
}) {
  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 100,
            padding: const EdgeInsets.only(
              top: 10,
              right: 50,
              left: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppConst.curveRadius),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0 , 1),
                  color: Colors.grey,
                  spreadRadius: 0,
                  blurRadius: 2,
                ),
              ],
            ),
            child: BlocBuilder<OrderCubit,OrderStates>(
              builder: (context,ind) {
                var orderCubit = OrderCubit.get(context);

                return orderCubit.productByIdPlaced == null ? indicator() : ListTile(
                  leading: SizedBox(),
                  onTap: (){
                    print('proId${order.productId}');
                    print('custId${order.customerId}');
                    print('orderId${order.id}');
                  },
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${order.productId} -- ${customer.name} -- ${customer.id}',// '${order.productId}',
                        overflow: TextOverflow.ellipsis,
// maxLines: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Text('${product.name} -- ${order.status}',),
                      Spacer(),
                      Text('20 apr 2022',),
                      SizedBox(width: 40,),
                    ],
                  ),
                );
              }
            )),
      ),
      PositionedDirectional(
        top: 34,
        start: 4,
        height: 40,
        // width: 40,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.greenAccent,//ColorRes.homeColor,

            borderRadius:  BorderRadius.horizontal(
              right: Radius.circular(AppConst.curveRadius,),
            ),
          ),
          child: IconButton(
            onPressed: call,
            icon: Icon(
              Icons.phone,
              color: iconColor,
            ),
          ),
        ),
      ),
      PositionedDirectional(
        top: 3,
        end: 20,
        width: 40,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(
                AppConst.curveRadius,
              ),
            ),
          ),
          child: IconButton(
            onPressed: delete,
            icon: Icon(
              Icons.cancel,
              color: iconColor,
            ),
          ),
        ),
      ),
      PositionedDirectional(
          bottom: 15,
          end: 15,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: MaterialButton(
              onPressed: edit,
              child: Text(
               orderState(order.status!),
              ),
            ),
          )
      ),
    ],
  );
}

 String orderState(int st){
  String status = '';
  switch(st){
    case 0:
      status = 'PLACED';
      break;
    case 1:
      status = 'BINDING';
      break;
    case 2:
      status = 'DELIVERED';
      break;
  }
  return status;
}