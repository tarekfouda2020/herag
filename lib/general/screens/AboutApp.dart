import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_flutter/general/models/PageModel.dart';
import 'package:base_flutter/general/resources/GeneralRepository.dart';
import 'package:base_flutter/general/widgets/DefaultAppBar.dart';
import 'package:base_flutter/general/widgets/HeaderLogo.dart';


class AboutApp extends StatefulWidget {
  final PageModel page;

  const AboutApp({@required this.page});
  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {


  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: widget.page.name, //"عن التطبيق"
        con: context,
      ),
      key: _scaffold,
      body: FutureBuilder<String>(
        future: GeneralRepository(context).aboutApp(widget.page.id,true),
        builder: (co,snapshot){
          if(snapshot.hasData){
            return ListView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
              children: [
                HeaderLogo(),
                Html(
                  data: snapshot.data,
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
