

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

var categoryController = TextEditingController();
var nameController = TextEditingController();
var customerNameController = TextEditingController();
var customerAddressController = TextEditingController();
var customerPhoneController = TextEditingController();
var priceController = TextEditingController();
var costController = TextEditingController();
var taxController = TextEditingController();
var amountController = TextEditingController();
var descriptionController = TextEditingController();
var imageController = TextEditingController();

late Database database;

class GlobalFunction{

  static errorPrint(error,String msg){
    print('XXXXXX ${msg.toUpperCase()} ${error.toString().toUpperCase()}');
  }
}
