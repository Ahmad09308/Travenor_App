import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor_app/Auth/view/pages/Splash.dart';
import 'package:travenor_app/core/bloc/bloc/favorite_bloc.dart';
import 'package:travenor_app/core/config/bloc_observ.dart';
import 'package:travenor_app/core/config/favorite_repository.dart';
import 'package:travenor_app/core/services/AirportApi.dart';
import 'package:travenor_app/core/bloc/bloc/airport_bloc_bloc.dart';
import 'package:travenor_app/core/theme/theme_cubit.dart'; // Import ThemeCubit
import 'package:travenor_app/core/services/auth_service.dart'; // Import AuthService
import 'package:travenor_app/core/bloc/auth_bloc/auth_bloc.dart'; // Import AuthBloc
import 'package:travenor_app/Auth/view/pages/home_page.dart'; // Import HomePage
import 'package:travenor_app/core/services/notification_service.dart'; // Import NotificationService

Future<void> main() async { // Make main async
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  Bloc.observer = MyBlocObserver();

  // Initialize services
  final AuthService authService = AuthService();
  final NotificationService notificationService = NotificationService();
  await notificationService.initialize(); // Initialize notifications

  runApp(MyApp(authService: authService, notificationService: notificationService));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final NotificationService notificationService; // Add NotificationService
  const MyApp({super.key, required this.authService, required this.notificationService}); // Update constructor

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          // Pass NotificationService to AuthBloc
          create: (context) => AuthBloc(authService: authService, notificationService: notificationService)..add(AppStarted()),
        ),
        BlocProvider(
          create: (context) =>
              FavoriteBloc(favoriteRepository: FavoriteRepository())
                ..add(LoadFavoritesEvent()),
        ),
        BlocProvider(
          create: (context) => AirportBlocBloc(
            airportService: AirportServiceImp(),
          )..add(FetchAirportsEvent()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeState.themeData,
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                if (authState is AuthAuthenticated) {
                  return const HomePage(); // Navigate to HomePage if authenticated
                }
                if (authState is AuthUnauthenticated || authState is AuthFailure || authState is AuthInitial ) {
                   // If AuthInitial, it will quickly transition via AppStarted.
                   // Showing Splash until a definitive state (AuthAuthenticated or AuthUnauthenticated) is reached.
                  return const Scaffold(body: Splash()); // Show Splash then Onboarding or SignIn
                }
                // AuthLoading or other initial states can also show Splash or a loading indicator
                return const Scaffold(body: Splash()); // Default fallback to Splash
              },
            ),
          );
        },
      ),
    );
  }
}
