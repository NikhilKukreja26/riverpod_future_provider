import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:future_provider/pages/users/user_detail_page.dart';
import 'package:future_provider/pages/users/users_providers.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(userListProvider);
    print(userList);

    print(
        'isLoading: ${userList.isLoading}, isRefreshing: ${userList.isRefreshing}, isReloading: ${userList.isReloading}');
    print('hasValue: ${userList.hasValue}, hasError: ${userList.hasError}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      // body: switch (userList) {
      //   AsyncData(value: final users) => ListView.separated(
      //       itemCount: users.length,
      //       separatorBuilder: (_, int index) {
      //         return const Divider();
      //       },
      //       itemBuilder: (_, int index) {
      //         final user = users[index];
      //         return ListTile(
      //           leading: CircleAvatar(
      //             child: Text('${user.id}'),
      //           ),
      //           title: Text(user.name ?? ''),
      //         );
      //       },
      //     ),
      //   AsyncError(error: final e) => Center(
      //       child: Text(
      //         e.toString(),
      //         style: const TextStyle(
      //           color: Colors.red,
      //           fontSize: 20.0,
      //         ),
      //       ),
      //     ),
      //   _ => const Center(
      //       child: CircularProgressIndicator.adaptive(),
      //     ),
      // },
      body: userList.when(
        skipLoadingOnRefresh: false,
        // skipLoadingOnReload: false,
        data: (users) {
          return RefreshIndicator(
            color: Colors.red,
            onRefresh: () async => ref.invalidate(userListProvider),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: users.length,
              separatorBuilder: (_, int index) {
                return const Divider();
              },
              itemBuilder: (_, int index) {
                final user = users[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserDetailPage(
                          userId: user.id!,
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    child: Text('${user.id}'),
                  ),
                  title: Text(user.name ?? ''),
                );
              },
            ),
          );
        },
        error: (e, st) => Center(
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
