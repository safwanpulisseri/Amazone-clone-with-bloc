import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoping_app_with_bloc/Favourite/favourite.dart';
import 'package:shoping_app_with_bloc/model/model_class.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitial()) {
    on<FavInitializeEvent>(favInitializeEvent);

    on<FavdeleteEvent>(favdeleteEvent);
  }

  FutureOr<void> favInitializeEvent(
      FavInitializeEvent event, Emitter<FavouriteState> emit) {
    emit(FavSuccessState(products: favourites));
  }

  FutureOr<void> favdeleteEvent(
      FavdeleteEvent event, Emitter<FavouriteState> emit) {
    favourites.remove(event.product);

    emit(FavSuccessState(products: favourites));
  }
}
