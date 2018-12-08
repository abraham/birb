import 'package:flutter/material.dart';

import 'post_item.dart';

class PostsList extends StatelessWidget {
  const PostsList();

  static const List<int> _items = <int>[0, 1, 2];

  @override
  Widget build(BuildContext context) {
    return ListView(children: _itemList());
  }

  List<PostItem> _itemList() {
    return _items.map((int index) => const PostItem()).toList();
  }
}
