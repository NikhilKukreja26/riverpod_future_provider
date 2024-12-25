import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:future_provider/models/user.dart';
import 'package:future_provider/providers/dio_provider/dio_provider.dart';

part 'users_providers.g.dart';

// final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
//   ref.onDispose(() {
//     print('[userListProvider] disposed');
//   });
//   final response = await ref.watch(dioProvider).get('/users');
//   final List userList = response.data;
//   // final users = (response.data as List).map((e) => User.fromJson(e)).toList();
//   final users = [for (final user in userList) User.fromJson(user)];
//   // throw 'Fail to fetch user list';
//   return users;
// });

@riverpod
FutureOr<List<User>> userList(Ref ref) async {
  ref.onDispose(() {
    print('[userListProvider] disposed');
  });
  final response = await ref.watch(dioProvider).get('/users');
  final List userList = response.data;
  final users = [for (final user in userList) User.fromJson(user)];
  return users;
}

// final AutoDisposeFutureProviderFamily<User, int> userDetailProvider =
//     FutureProvider.autoDispose.family<User, int>((ref, int id) async {
//   ref.onDispose(() {
//     print('[userDetailProvider($id)] disposed');
//   });
//   final response = await ref.watch(dioProvider).get('/users/$id');
//   final userDetail = User.fromJson(response.data);
//   ref.keepAlive();
//   return userDetail;
// });

@riverpod
FutureOr<User> userDetail(Ref ref, int id) async {
  ref.onDispose(() {
    print('[userDetailProvider($id)] disposed');
  });
  final response = await ref.watch(dioProvider).get('/users/$id');
  final userDetail = User.fromJson(response.data);
  ref.keepAlive();
  return userDetail;
}
