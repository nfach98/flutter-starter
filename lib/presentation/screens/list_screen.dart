import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:starter/presentation/router/app_router.dart';

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
            context.pushNamed(AppRouter.detail);
          },
          child: const Text('Detail'),
        ),
      ),
    );
  }
}
