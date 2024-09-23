import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor_app/Auth/view/pages/Splash.dart';
import 'package:travenor_app/core/bloc/bloc/favorite_bloc.dart';
import 'package:travenor_app/core/config/bloc_observ.dart';
import 'package:travenor_app/core/config/favorite_repository.dart';
import 'package:travenor_app/core/config/service_locater.dart';

void main() {
  // setup();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              FavoriteBloc(favoriteRepository: FavoriteRepository())
                ..add(LoadFavoritesEvent()), // تحميل المفضلات عند بدء التطبيق
        ),
        // يمكنك إضافة المزيد من BlocProviders هنا إذا كنت تحتاج لبلوكات أخرى
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Splash(),
        ),
      ),
    );
  }
}
