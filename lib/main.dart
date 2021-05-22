import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => MainPage()),
        GetPage(name: '/signin', page: () => SignInPage()),
        GetPage(name: '/signup', page: () => SignUpPage()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(name: '/detail', page: () => DetailPage()),
        GetPage(name: '/checkout', page: () => CheckoutPage()),
        GetPage(name: '/admin', page: () => AdminPage()),
        GetPage(name: '/detailUser', page: () => DetailUserPage()),
        GetPage(name: '/detailProduct', page: () => DetailProductPage()),
        GetPage(name: '/detailOrder', page: () => DetailOrderPage()),
        GetPage(name: '/addProduct', page: () => AddProductPage()),
        GetPage(name: '/companyProfile', page: () => CompanyProfilePage()),
      ],
      initialRoute: '/',
      defaultTransition: Transition.fadeIn,
    );
  }
}
