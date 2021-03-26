import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_flutter/general/models/PageModel.dart';
import 'package:base_flutter/general/screens/remote_page/remote_page_cubit/remote_page_cubit.dart';
import 'package:base_flutter/general/widgets/DefaultAppBar.dart';
import 'package:base_flutter/general/widgets/HeaderLogo.dart';

class RemotePage extends StatefulWidget {
  final PageModel page;
  const RemotePage({@required this.page});
  @override
  _RemotePageState createState() => _RemotePageState();
}

class _RemotePageState extends State<RemotePage> {

  final RemotePageCubit remotePageCubit =new RemotePageCubit();

  @override
  void initState() {
    remotePageCubit.fetchPageContent(context, widget.page.id,refresh: false);
    remotePageCubit.fetchPageContent(context, widget.page.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: widget.page.name, //"عن التطبيق"
        con: context,
      ),
      body: BlocBuilder<RemotePageCubit,RemotePageState>(
        bloc: remotePageCubit,
        builder: (context,state){
          if(state is RemotePageUpdated){
            return ListView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
              children: [
                HeaderLogo(),
                Html(
                  data: state.content,
                  style: {
                    "p": Style(
                      fontFamily: GoogleFonts.cairo().fontFamily,
                      fontSize: FontSize.larger,
                    )
                  },
                ),
              ],
            );
          }else{
            return Center(
              child: LoadingDialog.showLoadingView(),
            );
          }
        },
      ),
    );
  }

}
