import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/const/assets.dart';
import 'package:moreway/module/user/presentation/state/search/search_users_bloc.dart';

class SearchUsersPage extends StatefulWidget {
  const SearchUsersPage({super.key});

  @override
  State<SearchUsersPage> createState() => _SearchUsersPageState();
}

class _SearchUsersPageState extends State<SearchUsersPage> {
  final TextEditingController _searchController = TextEditingController();
  late final SearchUsersBloc _searchUsersBloc;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchUsersBloc = BlocProvider.of<SearchUsersBloc>(context);
    _searchController.addListener(_onSearchQueryChanged);
  }

  void _onSearchQueryChanged() {
    final query =
        _searchController.text.isEmpty ? null : _searchController.text;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _searchUsersBloc.add(SearchUsersByNameEvent(query: query));
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Поиск"),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: screenSize.width * 0.035,
          right: screenSize.width * 0.035,
        ),
        child: Column(
          children: [
            TextField(
              //onChanged: onChanged,
              //style: const TextStyle(fontSize: 12),
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: "Введите имя",
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
                //hintStyle: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(child: BlocBuilder<SearchUsersBloc, SearchUsersState>(
              builder: (context, state) {
                if (state.users != null && state.users!.isNotEmpty) {
                  
                  return ListView.builder(
                    itemCount: state.users!.length,
                    itemBuilder: (context, index) {
                      final user = state.users![index];
                      return ListTile(
                        title: Text(user.name),
                        leading: CircleAvatar(
                          child: ClipOval(
                            child: Image.network(user.avatarUrl),
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.person_add)),
                      );
                    },
                  );
                }
                // Если данные о пользователях есть, но возникла ошибка
                else if (state.status == LoadingStatus.failure) {
                  return const Center(child: Text("Возникла ошибка"));
                }
                // Если данных нет, но идет загрузка
                else if (state.status == LoadingStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                // Начальное состояние или данные отсутствуют
                else {
                  return const Center(
                    child: Text("Попробуйте кого-нибудь найти"),
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
