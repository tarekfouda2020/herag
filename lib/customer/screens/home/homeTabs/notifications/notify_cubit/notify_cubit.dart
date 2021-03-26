import 'package:base_flutter/general/blocs/lang_cubit/lang_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:base_flutter/customer/models/NotifyModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
part 'notify_state.dart';

class NotifyCubit extends Cubit<NotifyState> {
  NotifyCubit() : super(NotifyInitial());

  onNotifyListUpdated(List<NotifyModel> lst){
    emit(NotifyUpdated(lst, !state.changed));
  }

  Future<void> fetchData(BuildContext context,{bool refresh = true})async{
    if(state.notifies.length==0){
      String lang = context.read<LangCubit>().state.locale.languageCode;
      var data = await CustomerRepository(context).getNotifications(lang,refresh);
      onNotifyListUpdated(data);
    }
  }

  Future<void> setRefreshData(BuildContext context,RefreshController controller,{bool refresh = true})async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    var data = await CustomerRepository(context).getNotifications(lang,refresh);
    onNotifyListUpdated(data);
    controller.refreshCompleted();
  }

  Future<void> removeNotify(BuildContext context,NotifyModel model)async{
    var result = await CustomerRepository(context).removeNotification(model.id);
    if(result){
      state.notifies.remove(model);
      onNotifyListUpdated(state.notifies);
      Navigator.pop(context);
    }
  }

  Future<void> removeNotifications(BuildContext context)async{
    var result = await CustomerRepository(context).removeNotifications();
    if(result){
      onNotifyListUpdated([]);
      Navigator.pop(context);
    }
  }


}
