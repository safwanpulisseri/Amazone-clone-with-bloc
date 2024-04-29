import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoping_app_with_bloc/cart/cart.dart';
import 'package:shoping_app_with_bloc/model/model_class.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartinitialEvent>(cartinitialEvent);

    on<CartRemoveEvent>(cartRemoveEvent);
  }

  FutureOr<void> cartinitialEvent(
      CartinitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessstate(products: carts));
  }

  FutureOr<void> cartRemoveEvent(
      CartRemoveEvent event, Emitter<CartState> emit) {
    carts.remove(event.product);

    emit(CartSuccessstate(products: carts));
  }
}
