import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:base_flutter/general/models/TabModel.dart';

part 'tabs_state.dart';

class TabsCubit extends Cubit<TabsState> {
  TabsCubit() : super(TabsInitial());

  onSetTabsData(List<TabModel> tabs){
    emit(TabsUpdatedState(tabs));
  }

}
