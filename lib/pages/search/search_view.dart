import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/widget/my_get_view.dart';
import 'package:bujuan/widget/request_widget/request_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/api/search/bean.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';
import '../../widget/app_bar.dart';
import '../../widget/custom_filed.dart';
import '../../widget/mobile/flashy_navbar.dart';
import '../../widget/request_widget/request_loadmore_view.dart';
import '../play_list/playlist_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with SingleTickerProviderStateMixin {
  final TextEditingController _search = TextEditingController();
  final PageController _pageController = PageController();
  List<FlashyNavbarItem> items = [
    FlashyNavbarItem(icon: const Icon(TablerIcons.brand_tiktok)),
    FlashyNavbarItem(icon: const Icon(TablerIcons.playlist)),
    FlashyNavbarItem(icon: const Icon(TablerIcons.disc)),
    FlashyNavbarItem(icon: const Icon(TablerIcons.users)),
  ];
  final List<Tab> tabs = [
    const Tab(
      text: '单曲',
    ),
    const Tab(
      text: '歌单',
    ),
    const Tab(
      text: '专辑',
    ),
    const Tab(
      text: '歌手',
    ),
  ];
  TabController? _tabController;

  String searchContent = '';

  DioMetaData searchSongDioMetaData(String keyword, int type, {bool cloudSearch = true, int offset = 0, int limit = 30}) {
    var params = {'s': keyword, 'type': type, 'limit': limit, 'offset': offset};
    return DioMetaData(_searchUrl(cloudSearch), data: params, options: joinOptions());
  }

  DioMetaData searchHotKeyDioMetaData() {
    return DioMetaData(joinUri('/weapi/search/hot'), data: {'type': 1111}, options: joinOptions(userAgent: UserAgent.Mobile));
  }

  Uri _searchUrl(bool cloudSearch) => cloudSearch ? joinUri('/weapi/cloudsearch/pc') : joinUri('/weapi/search/get');

  @override
  void initState() {
    super.initState();
    _search.addListener(listener);
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  listener() {
    if (_search.text.isEmpty) {
      setState(() {
        searchContent = '';
      });
    }
  }

  @override
  void dispose() {
    _search.removeListener(listener);
    _search.dispose();
    _pageController.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyGetView(child: Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 0.w,
        leading: const SizedBox.shrink(),
        title: CustomFiled(
          iconData: TablerIcons.search,
          textEditingController: _search,
          hitText: '输入歌曲、歌手、歌单...',
          textInputAction: TextInputAction.search,
          onSubmitted: (String value) {
            if (value.isNotEmpty) {
              searchContent = value;
              setState(() {});
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              AutoRouter.of(context).pop();
            },
            icon: const Icon(TablerIcons.x),
            iconSize: 54.w,
          )
        ],
      ),
      body: Visibility(
          visible: searchContent.isNotEmpty,
          replacement: RequestWidget<SearchKeyWrapX>(
              dioMetaData: searchHotKeyDioMetaData(),
              childBuilder: (data) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
                child: Wrap(
                  children: data.result.hots
                      .map((e) => InkWell(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 15.w),
                      padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary, borderRadius: BorderRadius.circular(30.w)),
                      child: Text(
                        e.first ?? '',
                        style: TextStyle(fontSize: 26.sp),
                      ),
                    ),
                    onTap: () {
                      _search.text = e.first ?? '';
                      searchContent = _search.text;
                      setState(() {});
                    },
                  ))
                      .toList(),
                ),
              )),
          child: Column(
            children: [
              TabBar(
                tabs: tabs,
                controller: _tabController,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).iconTheme.color,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Theme.of(context).primaryColor,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0),
              ),
              Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildSongSearchView(),
                      _buildPlayListSearchView(),
                      _buildAlbumSearchView(),
                      _buildArtistsSearchView(),
                    ],
                  )),
            ],
          )),
    ));
  }

  Widget _buildSongSearchView() {
    return RequestLoadMoreWidget<SearchSongWrapX, Song2>(
      dioMetaData: searchSongDioMetaData(searchContent, 1),
      childBuilder: (List<Song2> songs) {
        var list = Home.to.song2ToMedia(songs);
        return ListView.builder(
          itemExtent: 120.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          itemBuilder: (context, index) => SongItem(
            index: index,
            mediaItem: list[index],
            onTap: () {
              Home.to.playByIndex(index, '', mediaItem: list);
            },
          ),
          itemCount: list.length,
        );
      },
      listKey: const ['result', 'songs'],
    );
  }

  Widget _buildPlayListSearchView() {
    return RequestLoadMoreWidget<SearchPlaylistWrapX, Play>(
      dioMetaData: searchSongDioMetaData(searchContent, 1000),
      childBuilder: (List<Play> playlist) {
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          itemExtent: 120.w,
          itemBuilder: (context, index) => PlayListItem( play: playlist[index]),
          itemCount: playlist.length,
        );
      },
      listKey: const ['result', 'playlists'],
    );
  }

  Widget _buildAlbumSearchView() {
    return RequestLoadMoreWidget<SearchAlbumsWrapX, Album>(
      dioMetaData: searchSongDioMetaData(searchContent, 10),
      childBuilder: (List<Album> playlist) {
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          itemExtent: 120.w,
          itemBuilder: (context, index) => AlbumItem(index: index, album: playlist[index]),
          itemCount: playlist.length,
        );
      },
      listKey: const ['result', 'albums'],
    );
  }

  Widget _buildArtistsSearchView() {
    return RequestLoadMoreWidget<SearchArtistsWrapX, Artists>(
      dioMetaData: searchSongDioMetaData(searchContent, 100),
      childBuilder: (List<Artists> playlist) {
        return ListView.builder(
          itemExtent: 120.w,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          itemBuilder: (context, index) => ArtistsItem(index: index, artists: playlist[index]),
          itemCount: playlist.length,
        );
      },
      listKey: const ['result', 'artists'],
    );
  }
}
