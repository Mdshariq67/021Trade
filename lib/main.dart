import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/watchlist_bloc.dart';
import 'data/stock_repository.dart';
import 'screens/watchlist_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => StockRepository(),
      child: BlocProvider(
        create: (context) => WatchlistBloc(
          repository: context.read<StockRepository>(),
        )..add(const WatchlistLoaded()),
        child: MaterialApp(
          title: '021 Trade',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const WatchlistScreen(),
        ),
      ),
    );
  }
}
