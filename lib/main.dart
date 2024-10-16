import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_sharing/data/repository/firebase_repository.dart';
import 'package:post_sharing/presentation/home_page.dart';

import 'business/cubit/post_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => FirebaseRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostCubit(
              firebaseRepository: RepositoryProvider.of<FirebaseRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Post Sharing App',
          home: HomePage(),
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}