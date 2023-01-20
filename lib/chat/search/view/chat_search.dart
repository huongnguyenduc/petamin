import 'package:Petamin/chat/detail/view/chat_detail_page.dart';
import 'package:Petamin/chat/search/cubit/chat_search_cubit.dart';
import 'package:Petamin/shared/shared_widgets.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:petamin_repository/petamin_repository.dart';

class ChatSearchPage extends StatelessWidget {
  ChatSearchPage({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    final _cubit = ChatSearchCubit(context.read<PetaminRepository>())
      ..search('h');
    String _query = 'h';
    _scrollListener() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        print('reach the bottom');
        _cubit.search(_query);
      }
      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        print('reach the top');
      }
    }

    _scrollController.addListener(_scrollListener);
    _onSearchChanged(String query) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 800), () {
        // do something with query
        _query = query;
        print("Searching............");
        _cubit.search(query);
      });
    }

    return BlocProvider(
        create: (_) => _cubit,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppTheme.colors.green,
                ),
              ),
              elevation: 0,
              title: TextFormField(
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                autofocus: true,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  color: Colors.black,
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: BlocBuilder<ChatSearchCubit, ChatSearchState>(
                  buildWhen: (previous, current) =>
                      previous.searchResults != current.searchResults ||
                      previous.status != current.status,
                  builder: (context, state) {
                    if (state.status == ChatSearchStatus.searching) {
                      EasyLoading.show();
                    } else {
                      EasyLoading.dismiss();
                    }
                    if (state.status == ChatSearchStatus.failure) {
                      showToast(msg: "Can't load result!");
                    }
                    if (state.status == ChatSearchStatus.success ||
                        state.status == ChatSearchStatus.newQuery) {
                      if (state.searchResults.isEmpty) {
                        return Center(child: Text("No result found!"));
                      }
                    }
                    return Column(children: [
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16.0),
                          child: Text(
                              state.status == ChatSearchStatus.initial
                                  ? 'Suggestions'
                                  : 'Suggestions',
                              textAlign: TextAlign.left,
                              style: CustomTextTheme.heading4(context))),
                      Expanded(
                          child: SizedBox(
                              child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.searchResults.length,
                        itemBuilder: (context, index) {
                          final chat = state.searchResults[index];
                          return GestureDetector(
                            onTap: () async {
                              final conversationId = await _cubit
                                  .createConversations(chat.userId!);
                              if (conversationId.length >= 0) {
                                Navigator.of(context, rootNavigator: true)
                                    .push(MaterialPageRoute(
                                        builder: (context) => ChatPage(
                                            conversationId: conversationId)))
                                    .then((_) => Navigator.of(context).pop());
                              } else {
                                showToast(msg: 'User is locked!');
                              }
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(chat.avatar!),
                              ),
                              title: Text(chat.name ?? ''),
                              subtitle: Text(chat.address ?? ''),
                              trailing: Text('12:00'),
                            ),
                          );
                        },
                      )))
                    ]);
                  }),
            )));
  }
}