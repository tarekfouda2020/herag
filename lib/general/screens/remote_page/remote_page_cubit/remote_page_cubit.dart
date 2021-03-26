import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:base_flutter/general/resources/GeneralRepository.dart';

part 'remote_page_state.dart';

class RemotePageCubit extends Cubit<RemotePageState> {
  RemotePageCubit() : super(RemotePageInitial());

  onUpdatePageContent(String content){
    emit(RemotePageUpdated(content));
  }

  fetchPageContent(BuildContext context , int pageId,{bool refresh = true})async{
    String text= await GeneralRepository(context).aboutApp(pageId,refresh);
    onUpdatePageContent(text);
  }

}
