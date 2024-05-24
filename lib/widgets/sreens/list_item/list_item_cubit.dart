import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:money_manager/common/enum/load_status.dart';

import '../../../common/enum/screen_size.dart';
import '../../../models/transaction.dart';
import '../../../repositories/api.dart';

part 'list_item_state.dart';

class ListItemCubit extends Cubit<ListItemState> {
  Api api;

  ListItemCubit(this.api) : super(const ListItemState.init());

  void loadData(int monthIdx) async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading, selectedMoth: monthIdx));
    try {
      var months = await api.getMonths();
      emit(state.copyWith(months: months));
      var total = await api.getTotal();
      emit(state.copyWith(total: total));
      List<Transaction> trans = months.isEmpty ? [] : await api.getTransactions(state.months[state.selectedMoth]);
      emit(state.copyWith(trans: trans, loadStatus: LoadStatus.Done));
    } catch (ex) {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }
  }

  Future<void> removeItem(String dateTime) async {
    emit(state.copyWith(
      loadStatus: LoadStatus.Loading,
    ));
    try {
      await api.deleteTransaction(dateTime);
       loadData(state.selectedMoth);
    } catch (ex) {
      emit(state.copyWith(
        loadStatus: LoadStatus.Error,
      ));
    }
  }

  void SetScreenSize(ScreenSize screenSize){
    emit(state.copyWith(screenSize: screenSize));
  }

  void setSelectedIdx(int selectedIdx){
    emit(state.copyWith(selectedIdx: selectedIdx));
  }
}
