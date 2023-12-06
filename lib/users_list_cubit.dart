import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:partone_architecture/user_json.dart';
import 'package:partone_architecture/users_list_state.dart';

class UsersListCubit extends Cubit<UsersListState> {
  UsersListCubit() : super(UsersListState.empty());

  Future<void> fetchUsers() async {
    emit(state.copyWith(isLoading: true));
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var response = await http.get(url);
    var list = jsonDecode(response.body) as List;
    final users = list.map((e) => UserJson.fromJson(e)).toList();
    emit(state.copyWith(users: users, isLoading: false));
  }
}
