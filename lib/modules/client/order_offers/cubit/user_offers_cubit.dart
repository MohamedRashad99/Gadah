import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:gadha/comman/models/offer.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/comman/services/offers_repo.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'user_offers_state.dart';

class UserOffersCubit extends Cubit<UserOffersState> {
  final _offersRepo = OffersRepo();
  UserOffersCubit(this.order) : super(UserOffersInitial()) {
    refresh();
  }

  factory UserOffersCubit.of(BuildContext context) {
    return BlocProvider.of(context, listen: false);
  }
  final _offers = <OfferEntity>[];
  final OrderEntity order;
  Future<void> refresh() async {
    try {
      _offers.clear();
      emit(UserOffersLoading());
      _offers.addAll(await _offersRepo.loadUseerIncOffers(order.id));
      emit(_offers.isEmpty ? UserOffersIsEmpty() : UserOffersLoaded(_offers));
    } catch (e) {
      emit(UserOffersError(msg: e.toString()));
    }
  }
}
