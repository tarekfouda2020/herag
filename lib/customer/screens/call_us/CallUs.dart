part of 'CallUsImports.dart';

class CallUs extends StatefulWidget {
  @override
  _CallUsState createState() => _CallUsState();
}

class _CallUsState extends State<CallUs> with CallUsData {
  @override
  void initState() {
    callSocialCubit.fetchData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: tr(context,"contactWithUs"),
        con: context,
      ),
      key: _scaffold,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: Image(
              height: 150,
              image: AssetImage(Res.logo),
              fit: BoxFit.contain,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownTextField<DropDownModel>(
                  label: tr(context,"deptName"),
                  dropKey: reason,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  onChange: setSelectReason,
                  finData: (filter) async =>
                      await CustomerRepository(context).getContactReasons(),
                  validate: (value) =>
                      Validator(context).validateDropDown<DropDownModel>(model: value),
                ),
                RichTextFiled(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  label: "${tr(context,"message")}",
                  //"الرسالة",
                  type: TextInputType.multiline,
                  height: MediaQuery.of(context).size.height * .18,
                  max: 8,
                  controller: msg,
                  validate: (value) => Validator(context).validateEmpty(value: value),
                  action: TextInputAction.newline,
                ),
                BlocConsumer<CallImageCubit, CallImageState>(
                  bloc: callImageCubit,
                  listener: (_, state) {
                    if (state != null) {
                      callFile.text = state.file.path.split("/").last;
                    }
                  },
                  builder: (_, state) {
                    return InkWellTextField(
                      controller: callFile,
                      label: tr(context,"selectFile"),
                      type: TextInputType.text,
                      icon: Icon(Icons.attach_file),
                      onTab: showFileTypeDialog,
                    );
                  },
                ),
                DefaultButton(
                  title: tr(context,"send"), //"ارسال",
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  onTap: () => setContactUs(context),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: MyText(
                    title: tr(context,"orVia"),
                  ),
                ),
                BlocBuilder<CallSocialCubit, CallSocialState>(
                  bloc: callSocialCubit,
                  builder: (_, state) {
                    if (state is CallSocialUpdate) {
                      return Column(
                        children: [
                          callUsItem(
                              icon: Icons.location_on,
                              content: state.model.address,
                              onTap: () => state.model.lat.isNotEmpty
                                  ? Utils.navigateToMapWithDirection(
                                      lat: state.model.lat,
                                      lng: state.model.lng,
                                      title: state.model.address)
                                  : null),
                          callUsItem(
                              icon: Icons.mail,
                              content: state.model.email,
                              onTap: () => Utils.sendMail(state.model.email)),
                          callUsItem(
                              icon: Icons.call,
                              content: state.model.phone,
                              onTap: () =>
                                  Utils.callPhone(phone: state.model.phone),
                          ),
                          SizedBox(height: 50,)
                        ],
                      );
                    } else {
                      return Container(
                        height: 100,
                        child: LoadingDialog.showLoadingView(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget callUsItem({IconData icon, String content, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: MyColors.greyWhite,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(
                icon,
                color: MyColors.white,
                size: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MyText(
                title: content,
                size: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showFileTypeDialog() {
    ModalHelper.showModal(
      context: context,
      title: tr(context,"fileType"),
      expand: false,
      content: Container(
        height: 200,
        child: Column(
          children: [
            DefaultButton(
              title: tr(context,"image"),
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              onTap: ()=> setCallFile(FileType.image,context),
              borderColor: MyColors.primary,
              color: MyColors.white,
              textColor: MyColors.primary,
            ),
            DefaultButton(
              title: tr(context,"file"),
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              onTap: ()=> setCallFile(FileType.any,context),
              borderColor: MyColors.primary,
              color: MyColors.white,
              textColor: MyColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
