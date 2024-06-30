import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:future_provider/pages/users/users_providers.dart';

class FamilyDisposePage extends ConsumerWidget {
  const FamilyDisposePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userDetailProvider(1));
    ref.watch(userDetailProvider(2));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Dispose'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(30.0),
          children: [
            OutlinedButton(
              onPressed: () {
                ref.invalidate(userDetailProvider);
              },
              child: const Text('invalidate'),
            ),
            const SizedBox(height: 20.0),
            OutlinedButton(
              onPressed: () {
                return ref.refresh(userDetailProvider(1));
              },
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
