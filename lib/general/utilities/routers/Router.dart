part of 'RouterImports.dart';


@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    //general routes
    AutoRoute(page: AnimatedSplash, initial: true,),
    AutoRoute(page: Login),
    AutoRoute(page: Register),
    AutoRoute(page: RegisterComplete),
    AutoRoute(page: ForgetPassword),
    AutoRoute(page: ActiveAccount),
    AutoRoute(page: ResetPassword),
    AutoRoute(page: RemotePage),
    AutoRoute(page: Terms),
    AutoRoute(page: ContactUs),

    //customer routes
    AutoRoute(page: Home),
    AutoRoute(page: AddOffers),
    AutoRoute(page: OfferSwearing),
    AutoRoute(page: AddOfferLocation),
    AutoRoute(page: LocationAddress),
    AutoRoute(page: AddOfferDetails),
    AutoRoute(page: AddOfferImages),
    AutoRoute(page: AddOfferSuccess),
    AutoRoute(page: ProductDetails),
    AutoRoute<List<CommentModel>>(page: ProductComments),
    AutoRoute(page: UserProducts),
    AutoRoute(page: UserComments),
    AutoRoute(page: Chat),
    AutoRoute(page: MyProducts),
    AutoRoute(page: EditOfferImages),
    AutoRoute(page: EditOfferLocation),
    AutoRoute(page: EditOfferDetails),
    AutoRoute(page: EditOfferSuccess),
    AutoRoute(page: Followers),
    AutoRoute(page: AddCarFollower),
    AutoRoute(page: Profile),
    AutoRoute(page: EditProfile),
    AutoRoute(page: ChangePassword),
    AutoRoute(page: ImageZoom),
    AutoRoute(page: AdminBanks),
    AutoRoute(page: BankPayment),
    AutoRoute(page: CallUs),
    AutoRoute(page: FilterLocation),


  ],
)
class $AppRouter {}