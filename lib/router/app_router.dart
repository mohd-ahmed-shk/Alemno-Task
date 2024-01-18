import 'package:auto_route/auto_route.dart';


import '../ui/book_apoinment/book_appoinment_page.dart';
import '../ui/lab_test/lab_test_page.dart';
import '../ui/my_cart/my_cart_page.dart';
import '../ui/success/success_page.dart';


part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)

class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: LabTestRoute.page,initial: true,path: '/' ),
    AutoRoute(page: MyCartRoute.page,),
    AutoRoute(page: BookAppointmentRoute.page,),
    AutoRoute(page: SuccessRoute.page,),

  ];
}
