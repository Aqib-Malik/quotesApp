import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:positify_project/notifications/notificationhelper.dart';
import 'package:positify_project/pages/add_review.dart';
import 'package:positify_project/pages/category_page/categories_screen.dart';
import 'package:positify_project/pages/change_password.dart';
import 'package:positify_project/pages/daily_quote_reminder.dart';
import 'package:positify_project/pages/favourite_quote.dart';
import 'package:positify_project/pages/Get_started_page/get_started_screen.dart';
import 'package:positify_project/pages/help.dart';
import 'package:positify_project/pages/illustration_screen.dart';
import 'package:positify_project/pages/privacy_policy.dart';
import 'package:positify_project/pages/profile_screen.dart';
import 'package:positify_project/pages/quotes_share.dart';
import 'package:positify_project/pages/settings.dart';
import 'package:positify_project/pages/splash_screen.dart';
import 'package:positify_project/pages/stage_of_life.dart';
import 'package:positify_project/pages/support.dart';
import 'package:positify_project/pages/terms_conditions.dart';
import 'package:positify_project/services/key.dart';
import 'package:workmanager/workmanager.dart';
import 'pages/forum_main.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51LjKcuBKgMvxmN7mEmxI3Z7ippyJsioZiDJY8owWBOSitRlLVHJ14ZaguzL7kSmV4ymVxNAspCKBQczweIDGZJC400TEz1Qbau';

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  NotificationHelper().initializeNotification();
  await Firebase.initializeApp();
  await Workmanager().initialize(callbackDispatcher);
  await AndroidAlarmManager.initialize();

  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // QuoteByCategories o = new QuoteByCategories();
    // print(QuoteByCategories.categoriesAndQuotes);
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) =>
            // AddQuote(),
            // CatTwo(),
            // const DailyReminder(),
            //GetStartedScreen(),
       SplashScreen(),
        '/get_started': (context) => GetStartedScreen(),
        '/daily_reminder': (context) => const DailyReminder(),
        '/stage_of_life': (context) => const Stage_of_life(nextpageaddress: ""),
        '/categories_screen': (context) => const CategoriesScreen(),
        '/profile_screen': (context) => const ProfileScreen(),
        '/quotes_share': (context) => const QuotesShare(),
        '/favourite_quote': (context) => const FavourateQuotes(),
        '/settings': (context) => const Settings(),
        '/add_review': (context) => const AddReview(),
        '/privacy_policy': (context) => const PrivacyPolicy(),
        '/terms_conditions': (context) => const TermsCondition(),
        '/change_password': (context) => const ChangePassword(),
        '/help': (context) => const Help(),
        '/illustration_screen': (context) => const IllustrationScreen(
              bg: '',
              name: '',
            ),
        '/support': (context) => const Support(),
        // '/quote_screen': (context) => QuotesScreen(
        //       '',
        //       illustration_: '',
        //     ),
        '/forum_main': (context) => const ForumMain(
              illustration: '',
            ),
      },
      // home: const Stage_of_life(),
    );
  }
}
