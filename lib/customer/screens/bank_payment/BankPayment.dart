part of 'BankPaymentImports.dart';

class BankPayment extends StatefulWidget {
  @override
  _BankPaymentState createState() => _BankPaymentState();
}

class _BankPaymentState extends State<BankPayment> with BankPaymentData {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: tr(context, "payCommission"), con: context),
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildFormInputs(),
          DefaultButton(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            title: tr(context, "send"),
            onTap: () => addPayment(context),
          )
        ],
      ),
    );
  }

  Widget _buildFormInputs() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          BlocConsumer<PayCubit, PayState>(
              bloc: payCubit,
              listener: (_, state) {
                if (state.image != null) {
                  img.text = state.image.path.split("/").last;
                }
              },
              builder: (_, state) {
                return InkWellTextField(
                  controller: img,
                  label: tr(context, "insertTransferImg"),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  icon: Icon(Icons.image, size: 25, color: MyColors.primary),
                  onTab: setImage,
                );
              }),
          // LabelTextField(
          //   controller: bank,
          //   margin: EdgeInsets.symmetric(vertical: 10),
          //   label: "اسم البنك",
          //   type: TextInputType.text,
          //   validate: (value)=>Validator(context).validateEmpty(value: value),
          //   action: TextInputAction.next,
          // ),
          DropdownTextField<BankModel>(
            label: tr(context, "nameBank"),
            margin: EdgeInsets.symmetric(vertical: 10),
            onChange: setSelectBank,
            finData: (filter) async =>
                await CustomerRepository(context).getBanks(),
            validate: (value) =>
                Validator(context).validateDropDown<BankModel>(model: value),
          ),
          LabelTextField(
            controller: name,
            margin: EdgeInsets.symmetric(vertical: 10),
            label: tr(context, "accountName"),
            type: TextInputType.text,
            validate: (value) => Validator(context).validateEmpty(value: value),
            action: TextInputAction.next,
          ),
          LabelTextField(
            controller: number,
            margin: EdgeInsets.symmetric(vertical: 10),
            label: tr(context, "accountNumb"),
            type: TextInputType.number,
            validate: (value) => Validator(context).validateEmpty(value: value),
            action: TextInputAction.next,
          ),
          LabelTextField(
            controller: ipanNumber,
            margin: EdgeInsets.symmetric(vertical: 10),
            label: tr(context,"ibnNumb"),
            type: TextInputType.number,
            validate: (value) => Validator(context).validateEmpty(value: value),
            action: TextInputAction.next,
          ),
          LabelTextField(
            controller: adNumber,
            margin: EdgeInsets.symmetric(vertical: 10),
            label: tr(context, "adsNumb"),
            type: TextInputType.number,
            validate: (value) => Validator(context).validateEmpty(value: value),
            action: TextInputAction.next,
          ),
          LabelTextField(
            controller: price,
            margin: EdgeInsets.symmetric(vertical: 10),
            label: tr(context, "transferQuantity"),
            type: TextInputType.text,
            validate: (value) => Validator(context).validateEmpty(value: value),
            action: TextInputAction.next,
          ),
          RichTextFiled(
            controller: notes,
            margin: EdgeInsets.symmetric(vertical: 10),
            label: tr(context, "addNotes"),
            type: TextInputType.text,
            validate: (value) => Validator(context).noValidate(value: value),
            action: TextInputAction.done,
            height: 100,
            min: 6,
            max: 8,
            submit: (value) => addPayment(context),
          ),
        ],
      ),
    );
  }
}
