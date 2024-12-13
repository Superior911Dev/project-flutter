import 'package:appstore/common/routes/bloc_observer.dart';
import 'package:appstore/common/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Global {
  static late StorageService storageService;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = MyGlobalObserver();

    // Bloc.observer = MyGlobalObserver();
    await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
        );
    storageService = await StorageService().init();
  }
}
