
abstract class OrderStates{}

class InitialOrderState extends OrderStates{}
class AddOrderState extends OrderStates{}
class UpdateOrderState extends OrderStates{}
class SetCustomerOrderState extends OrderStates{}
class SetProductOrderState extends OrderStates{}
class GetOrderState extends OrderStates{}
class GetOrderProductByIdState extends OrderStates{}
class GetOrderCustomerByIdState extends OrderStates{}
class LoadingGetOrderProductByIdState extends OrderStates{}
class DeleteOrderState extends OrderStates{}