part of 'OfferSwearingImports.dart';

class OfferSwearing extends StatelessWidget with OfferSwearingData {
  final OffersHeaderModel model;

  OfferSwearing({@required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        con: context,
        title: tr(context, "commissionAgreement"),
      ),
      backgroundColor: MyColors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            color: MyColors.greyWhite,
            child: Column(
              children: [
                MyText(
                  title: " بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ",
                  size: 12,
                  color: MyColors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                MyText(
                  title:
                      "﴿ وَأَوْفُوا بِعَهْدِ اللَّهِ إِذَا عَاهَدْتُمْ وَلَا تَنْقُضُوا الْأَيْمَانَ بَعْدَ تَوْكِيدِهَا وَقَدْ جَعَلْتُمُ اللَّهَ عَلَيْكُمْ كَفِيلًا إِنَّ اللَّهَ يَعْلَمُ مَا تَفْعَلُونَ ﴾",
                  size: 11,
                  color: MyColors.black,
                  alien: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<SwearingCubit, SwearingState>(
                bloc: swearingCubit,
                builder: (context, state) {
                  return Checkbox(
                      value: state.accepted, onChanged: setChangeAcceptSate);
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: MyText(
                  title: tr(context, "agreeToCommitment"),
                  size: 10,
                  color: MyColors.blackOpacity,
                ),
              )
            ],
          ),
          Spacer(),
          DefaultButton(
              margin: EdgeInsets.all(20),
              title: tr(context, "continue"),
              onTap: () => navigateToAddOfferImages(context, model)),
        ],
      ),
    );
  }
}
