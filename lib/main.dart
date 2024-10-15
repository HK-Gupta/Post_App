import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_sharing/data/repository/firebase_repository.dart';
import 'package:post_sharing/presentation/home_page.dart';
import 'package:share_plus/share_plus.dart';

import 'business/cubit/post_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post Sharing App',
      home: BlocProvider(
          create:(context) => PostCubit(firebaseRepository: FirebaseRepository()),
        child: HomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


