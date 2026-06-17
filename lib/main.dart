import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasources/local_data_source.dart';
import 'data/datasources/remote_data_source.dart';
import 'data/repositories/product_repository.dart';
import 'viewmodels/product_viewmodel.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/favorites_viewmodel.dart';
import 'views/home_page.dart';
import 'views/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final authViewModel = AuthViewModel();
  await authViewModel.checkSession();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authViewModel),
        ChangeNotifierProvider(create: (_) => ProductViewModel(
          ProductRepository(remoteDataSource: RemoteDataSource(), localDataSource: LocalDataSource())
        )),
        ChangeNotifierProvider(create: (_) => FavoritesViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arquitetura App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: context.watch<AuthViewModel>().currentUser == null 
          ? const LoginPage() 
          : const HomePage(), 
    );
  }
}