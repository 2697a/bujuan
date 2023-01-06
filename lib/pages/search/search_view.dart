import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../widget/custom_filed.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _search = TextEditingController();


  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leadingWidth: 100.w,
          leading: IconButton(onPressed: () => AutoRouter.of(context).pop(), icon: const Icon(Icons.close)),
          title: CustomFiled(
            iconData: TablerIcons.search,
            textEditingController: _search,
            hitText: '输入邮箱/手机号',
          ),
        ),
      ),
      onHorizontalDragDown: (e){},
    );
  }
}
