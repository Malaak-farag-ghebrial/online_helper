
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:online_helper/customer/cubit/customer_states.dart';
import 'package:online_helper/models/customer_model.dart';
import 'package:online_helper/shared/global_variable.dart';
import 'package:sqflite/sqflite.dart';
import '../../shared/constants/app_constants.dart';
import '../../shared/network/locale/cached_helper.dart';

class CustomerCubit extends Cubit<CustomerStates>{
  CustomerCubit() : super(InitialCustomerState());

  static CustomerCubit get(context) => BlocProvider.of(context);

  List<String> custId = [];
  List<CustomerModel> customers = [];

  void addCustomer({
  required String name,
    required String phone,
    required String address,
})async{
    Batch batch = database.batch();
    batch.insert(
        AppConst.customer_table,
        CustomerModel(
      name: name,
      phone: phone,
      address: address,
    ).toJson(),
    );
    await batch.commit().then((value)async{

      CacheHelper.getDataList(key: AppConst.customer_id).then((value){
        custId = value;
        print('cashed helper${value}');
      }).catchError((error){
        GlobalFunction.errorPrint(error, 'get custId customer');
      });
      custId.add('0');
      await CacheHelper.putData(key: '${AppConst.category_id}', value: custId);

      print('CUSTOMER +++++ INSERTED');
      emit(AddCustomerState());
      getCustomer();
    }).catchError((error){
      GlobalFunction.errorPrint(error, 'add customer');
    });

  }

  void updateCustomer({
    required int id,
    required String name,
    required String phone,
    required String address,
})async{
    Batch batch = database.batch();
    batch.update(
      AppConst.customer_table,
    CustomerModel(
      name: name ,
      phone: phone,
      address: address,
    ).toJson(),
      where: '${AppConst.id}=?',
      whereArgs: [id],
    );
    await batch.commit().then((value){
      print('CUSTOMER +++++ UPDATED');
      emit(UpdateCustomerState());
      getCustomer();
    }).catchError((error){
      GlobalFunction.errorPrint(error, 'update customer');
    });
  }

  void deleteCustomer(int id,int index){
    database.delete(AppConst.customer_table,
    where: '${AppConst.id}=?',
      whereArgs: [id],
    ).then((value){
      customers.removeAt(index);
      print('CUSTOMER ----- DELETED');
      emit(DeleteCustomerState());
      getCustomer();
    }).catchError((error){
      GlobalFunction.errorPrint(error, 'delete customer');
    });
  }

  void getCustomer(){
    customers = [
      CustomerModel(id: 0,name: ' + add customer',phone: '',address: ''),
    ];
    database.query(AppConst.customer_table,).then((value) {
      for(int i=0;i<value.length; i++){
        customers.add(CustomerModel.fromJson(value[i]));
      }
      emit(GetCustomerState());
    }).catchError((error){
      GlobalFunction.errorPrint(error, 'get customer');
    });
  }

  void callCustomer(String phone)async{
    bool res = await FlutterPhoneDirectCaller.callNumber('+2$phone')?? false;
    emit(CallCustomerState());
  }
}