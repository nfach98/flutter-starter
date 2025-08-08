import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/app/data/repositories/post_repository.dart';
import 'package:starter/app/routes/app_pages.dart';
import 'package:starter/app/themes/app_theme.dart';
import 'package:starter/services/network/dio_client.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Starter',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => DioClient());
        Get.lazyPut(() => PostRepository(dio: DioClient.to));
      }),
    );
  }
}
