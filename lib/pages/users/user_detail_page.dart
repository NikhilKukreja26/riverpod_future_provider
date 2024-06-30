import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:future_provider/pages/users/users_providers.dart';

class UserDetailPage extends ConsumerWidget {
  const UserDetailPage({
    super.key,
    required this.userId,
  });
  final int userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetail = ref.watch(userDetailProvider(userId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: userDetail.when(
        data: (user) {
          return RefreshIndicator(
            onRefresh: () async => ref.refresh(userDetailProvider(userId)),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 40.0,
              ),
              children: [
                Text(
                  user.name ?? '',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Divider(),
                UserInfo(
                  iconData: Icons.account_circle,
                  userInfo: user.username ?? '',
                ),
                const SizedBox(height: 10.0),
                UserInfo(
                  iconData: Icons.email_rounded,
                  userInfo: user.email ?? '',
                ),
                const SizedBox(height: 10.0),
                UserInfo(
                  iconData: Icons.phone_enabled,
                  userInfo: user.phone ?? '',
                ),
                const SizedBox(height: 10.0),
                UserInfo(
                  iconData: Icons.web_rounded,
                  userInfo: user.website ?? '',
                ),
              ],
            ),
          );
        },
        error: (e, _) => Center(
          child: Text(
            e.toString(),
            style: const TextStyle(
              color: Colors.red,
              fontSize: 20.0,
            ),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.iconData,
    required this.userInfo,
  });

  final IconData iconData;
  final String userInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData),
        const SizedBox(width: 10.0),
        Text(
          userInfo,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
