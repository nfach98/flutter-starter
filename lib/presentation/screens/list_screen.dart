import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter/presentation/router/app_router.gr.dart';

@RoutePage()
class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home'),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.pushRoute(const DetailRoute());
          },
          child: const Text('Detail'),
        ),
      ),
    );
  }
}
