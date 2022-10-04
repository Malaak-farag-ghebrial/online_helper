import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/customer/cubit/customer_cubit.dart';
import 'package:online_helper/customer/cubit/customer_states.dart';
import 'package:online_helper/customer/widget/customer_card.dart';
import 'package:online_helper/customer/widget/pop_up_add_customer.dart';
import 'package:online_helper/shared/component/custom_navigator.dart';
import 'package:online_helper/shared/component/no_data.dart';
import 'package:online_helper/shared/constants/app_constants.dart';
import 'package:online_helper/shared/global_variable.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var customerCubit = CustomerCubit.get(context);
          return Scaffold(
            body: Container(
              padding:  EdgeInsets.only(top: AppConst.paddingDistance,),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: customerCubit.customers.length - 1 == 0? noData() : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: customerCubit.customers.length - 1,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(color: Colors.green),
                      child: const Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                    ),
                    secondaryBackground: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerRight,
                      decoration: const BoxDecoration(color: Colors.red),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        /// call
                        customerCubit
                            .callCustomer(customerCubit.customers[index + 1].phone!);
                      }
                      if (direction == DismissDirection.endToStart) {
                        customerCubit
                            .deleteCustomer(customerCubit.customers[index +1].id!,index +1,context);
                      }
                    },
                    child: customerCard(
                       customer: customerCubit.customers[index +1],
                        call: () {
                          customerCubit.callCustomer(
                              customerCubit.customers[index +1].phone!,
                          );
                        },
                        edit: () async{
                          customerNameController.text =
                          customerCubit.customers[index +1].name!;
                          customerPhoneController.text =
                          customerCubit.customers[index +1].phone!;
                          customerAddressController.text =
                          customerCubit.customers[index +1].address!;
                          await showDialog(
                              context: context,
                              builder: (ctx) {
                                return addCustomerPopUp(
                                  context,
                                  action: () {
                                    customerCubit.updateCustomer(
                                      id: customerCubit.customers[index +1].id!,
                                      name: customerNameController.text,
                                      phone: customerPhoneController.text,
                                      address: customerAddressController.text,
                                    );
                                    pop(context);
                                    customerNameController.clear();
                                    customerPhoneController.clear();
                                    customerAddressController.clear();
                                  },
                                  update: true,
                                );
                              },
                          );
                        },
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return addCustomerPopUp(
                          context,
                          action: () {
                        customerCubit.addCustomer(
                          name: customerNameController.text,
                          phone: customerPhoneController.text,
                          address: customerAddressController.text,
                        );
                        pop(context);
                        customerNameController.clear();
                        customerPhoneController.clear();
                        customerAddressController.clear();
                      });
                    });
              },
              label: const Text('Add customer'),
            ),
          );
        });
  }
}
