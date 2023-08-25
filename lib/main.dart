import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_yatra/users_menu/contactus.dart';
import 'package:sajilo_yatra/users_menu/help.dart';
import 'package:sajilo_yatra/bottom_bar/home.dart';
import 'package:sajilo_yatra/users/meeting.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%202.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%203.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%204.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%205.dart';
import 'package:sajilo_yatra/offers/offerone%20copy.dart';
import 'package:sajilo_yatra/offers/offerone.dart';

import 'package:get/get.dart';
import 'package:sajilo_yatra/users/payment.dart';

import 'package:sajilo_yatra/users/profile.dart';
import 'package:sajilo_yatra/users/ride.dart';
import 'package:sajilo_yatra/users/ridesearch.dart';
import 'package:sajilo_yatra/users/search.dart';

import 'package:sajilo_yatra/users/tickets.dart';
import 'package:sajilo_yatra/users_menu/useraboutus.dart';
import 'package:sajilo_yatra/vehicle_owners/userdetails.dart';
import 'package:flutter/services.dart';

import 'package:sajilo_yatra/users/userhome.dart';
import 'package:sajilo_yatra/users_login/userregister.dart';
import 'package:sajilo_yatra/vehicle_owners/userrentaldetails.dart';
import 'package:sajilo_yatra/users/userrentals.dart';
import 'package:sajilo_yatra/vehicle_owners_menu/vcontactus.dart';
import 'package:sajilo_yatra/vehicle_owners/vehcileprofile.dart';
import 'package:sajilo_yatra/vehicle_owners/vehicle_editprofile.dart';
import 'package:sajilo_yatra/vehicle_owners/vehicle_payment.dart';
import 'package:sajilo_yatra/vehicle_owners/vehiclegoing.dart';
import 'package:sajilo_yatra/vehicle_owners/vehicleleaving.dart';
import 'package:sajilo_yatra/vehicle_owners_menu/vehiclemenu.dart';
import 'package:sajilo_yatra/vehicle_owners_login/vehicleownerforgotpassword.dart';
import 'package:sajilo_yatra/vehicle_owners/vehicleownerhome.dart';
import 'package:sajilo_yatra/vehicle_owners_login/vehicleownerlogin.dart';
import 'package:sajilo_yatra/vehicle_owners_login/vehicleownerregister.dart';
import 'package:sajilo_yatra/vehicle_owners/vehicleride.dart';
import 'package:sajilo_yatra/vehicle_owners/vehicletickets.dart';
import 'package:sajilo_yatra/vehicle_owners_menu/vfeedbacks.dart';
import 'package:sajilo_yatra/vehicle_owners_menu/vhelp.dart';
import 'users_menu/aboutus.dart';
import 'users/city.dart';
import 'users/editprofile.dart';
import 'users_menu/feedbacks.dart';
import 'users_login/forgotpassword.dart';
import 'users/going.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'bottom_bar/homepage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'users/leaving.dart';

import 'users_menu/menu.dart';
import 'users_login/userlogin.dart';
import 'start_screen/loginas.dart';
import 'start_screen/splashscreen.dart';

late SharedPreferences sharedPreferences;

Future<void> main() async {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController1 = TextEditingController();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();
  await dotenv.load(fileName: ".env");

  runApp(Theme(
      data: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
        useMaterial3: true,
      ),
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // Start the app with the "/" named route. In this case, the app starts
            // on the FirstScreen widget.
            initialRoute: '/',
            getPages: [
              GetPage(
                name: '/',
                page: () => const MyHomePage(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/second',
                page: () => const FirstScreen(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/third3',
                page: () => const UsersScreen(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/third2',
                page: () => const HomePage(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/third4',
                page: () => const OfferTwo(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/third5',
                page: () => const OfferOne(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/third6',
                page: () => const OfferThree(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/third7',
                page: () => const OfferFour(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/third8',
                page: () => const OfferFive(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/third9',
                page: () => const OfferSix(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/tenth',
                page: () => const EighthScreen(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/seventh',
                page: () => const ThirdRoute(
                  userId: '',
                ),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/hun1',
                page: () => const Home(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/eighth',
                page: () => const Home(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/line20',
                page: () => const VEdit(
                  userId: '',
                ),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/line21',
                page: () => const AboutUs(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/line22',
                page: () => const UAboutUs(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/line23',
                page: () => const Contact(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/line24',
                page: () => const NinethScreen(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/third',
                page: () => const FifthScreen(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/fourth',
                page: () => const FifthRoute(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/line6',
                page: () => const PasswordScreen(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/line25',
                page: () => const VLocation(
                  going: '',
                  leaving: '',
                  location: '',
                ),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/line7',
                page: () => const VehicleHome(
                  userId: '',
                  going: '',
                  leaving: '',
                  location: '',
                ),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/line13',
                page: () => const Profile(
                  userId: '',
                ),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/line26',
                page: () => const VehicleRide(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/line27',
                page: () => const VFeedbacksScreen(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/line28',
                page: () => const VContact(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/line29',
                page: () => const VPayment(
                  userId: '',
                ),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/line30',
                page: () => const UEighthRoute(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
              GetPage(
                name: '/line31',
                page: () => const RUsersScreen(),
                transitionDuration: const Duration(milliseconds: 600),
                transition: Transition.cupertino,
              ),
            ],
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.

              '/fifth': (context) => const SixthScreen(),
              '/sixth': (context) => const SixthRoute(),

              '/eleventh': (context) => const NinethRoute(),
              '/tweleventh': (context) => const TenthScreen(),

              '/fourteenth': (context) => const FourthRoute(
                    userId: '',
                  ),
              '/fifteenth': (context) => const ForgotPasswordScreen(),

              '/seventeenth': (context) => const Menu(),
              '/eighteenth': (context) => const Ride(),
              '/ninetenth': (context) => const FeedbacksScreen(),
              '/twenty': (context) => const SearchScreen(),

              '/line2': (context) => const Payment(
                    userId: '',
                  ),

              '/line5': (context) => const City(),

              '/line8': (context) => const VehicleLeaving(),
              '/line9': (context) => const VehicleGoing(),
              '/line10': (context) => const VehicleTickets(),
              '/line11': (context) => const Edit(
                    userId: '',
                  ),
              '/line12': (context) => const OutSearchScreen(),

              '/line14': ((context) => const VMenu()),
              '/line15': ((context) => const VHelp())
            },
          );
        },
        maxTabletWidth: 900, // Optional),
      )));
}
