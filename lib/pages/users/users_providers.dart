import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:future_provider/models/user.dart';
import 'package:future_provider/providers/dio_provider/dio_provider.dart';

final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  ref.onDispose(() {
    print('[userListProvider] disposed');
  });

  final response = await ref.watch(dioProvider).get('users');
  final List userList = response.data;
  final users = [for (final user in userList) User.fromJson(user)];
  // throw 'Fail to fetch user list';
  return users;
});

final userDetailProvider =
    FutureProvider.autoDispose.family<User, int>((ref, id) async {
  ref.onDispose(() {
    print('[userDetailProvider($id)] disposed');
  });
  final response = await ref.watch(dioProvider).get('users/$id');
  ref.keepAlive();
  return User.fromJson(response.data);
});
