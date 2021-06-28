import 'package:bujuan/pages/album/album_binding.dart';
import 'package:bujuan/pages/album/album_view.dart';
import 'package:bujuan/pages/home/home_binding.dart';
import 'package:bujuan/pages/home/home_view.dart';
import 'package:bujuan/pages/login/login_binding.dart';
import 'package:bujuan/pages/login/login_view.dart';
import 'package:bujuan/pages/music/album/local_album_bingding.dart';
import 'package:bujuan/pages/music/album/local_album_view.dart';
import 'package:bujuan/pages/music/all_song/all_song_binding.dart';
import 'package:bujuan/pages/music/all_song/all_song_view.dart';
import 'package:bujuan/pages/music/music_binding.dart';
import 'package:bujuan/pages/music/music_view.dart';
import 'package:bujuan/pages/play_view/music_talk/music_talk_binding.dart';
import 'package:bujuan/pages/play_view/music_talk/music_talk_view.dart';
import 'package:bujuan/pages/play_view/play_list_view.dart';
import 'package:bujuan/pages/profile/history/history_binding.dart';
import 'package:bujuan/pages/profile/history/history_view.dart';
import 'package:bujuan/pages/profile/profile_binding.dart';
import 'package:bujuan/pages/profile/profile_view.dart';
import 'package:bujuan/pages/radio/radio_binding.dart';
import 'package:bujuan/pages/radio/radio_detail/radio_detail_binding.dart';
import 'package:bujuan/pages/radio/radio_detail/radio_detail_view.dart';
import 'package:bujuan/pages/radio/radio_view.dart';
import 'package:bujuan/pages/search/search_detail/search_details_binding.dart';
import 'package:bujuan/pages/search/search_detail/search_dettails_view.dart';
import 'package:bujuan/pages/setting/about/about_view.dart';
import 'package:bujuan/pages/setting/donate/donate_binding.dart';
import 'package:bujuan/pages/setting/donate/donate_view.dart';
import 'package:bujuan/pages/setting/setting_binding.dart';
import 'package:bujuan/pages/setting/setting_view.dart';
import 'package:bujuan/pages/sheet_classify/sheet_classify_binding.dart';
import 'package:bujuan/pages/sheet_classify/sheet_classify_view.dart';
import 'package:bujuan/pages/sheet_info/sheet_info_binding.dart';
import 'package:bujuan/pages/sheet_info/sheet_info_view.dart';
import 'package:bujuan/pages/today/today_binding.dart';
import 'package:bujuan/pages/today/today_view.dart';
import 'package:bujuan/pages/top/top_binding.dart';
import 'package:bujuan/pages/top/top_view.dart';
import 'package:bujuan/pages/top_artists/top_artists_binding.dart';
import 'package:bujuan/pages/top_artists/top_artists_view.dart';
import 'package:bujuan/pages/user/cloud/cloud_binding.dart';
import 'package:bujuan/pages/user/cloud/cloud_view.dart';
import 'package:bujuan/pages/user/playlist_manager/playlist_manager_binding.dart';
import 'package:bujuan/pages/user/playlist_manager/playlist_manager_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static const INITIAL = '/home';

  static final routes = [
    GetPage(name: '/home', page: () => HomeView(), binding: HomeBinding()),
    GetPage(name: '/today', page: () => TodayView(), binding: TodayBinding()),
    GetPage(
        name: '/sheet',
        page: () => SheetInfoView(),
        binding: SheetInfoBinding()),
    GetPage(
        name: '/profile', page: () => ProfileView(), binding: ProfileBinding()),
    GetPage(
        name: '/setting', page: () => SettingView(), binding: SettingBinding()),
    GetPage(name: '/login', page: () => LoginView(), binding: LoginBinding()),
    GetPage(name: '/cloud', page: () => CloudView(), binding: CloudBinding()),
    GetPage(
        name: '/sheet_classify',
        page: () => SheetClassifyView(),
        binding: SheetClassifyBinding()),
    GetPage(
        name: '/music_talk',
        page: () => MusicTalkView(),
        binding: MusicTalkBinding()),
    GetPage(
        name: '/all_song',
        page: () => AllSongView(),
        binding: AllSongBinding()),
    GetPage(
        name: '/search_details',
        page: () => SearchDetailsView(),
        binding: SearchDetailBinding()),
    GetPage(name: '/local', page: () => MusicView(), binding: MusicBinding()),
    GetPage(name: '/top', page: () => TopView(), binding: TopBinding()),
    GetPage(
        name: '/local_album',
        page: () => LocalAlbumView(),
        binding: LocalAlbumBinding()),
    GetPage(
        name: '/donate', page: () => DonateView(), binding: DonateBinding()),
    GetPage(name: '/about', page: () => AboutView()),
    GetPage(name: '/album', page: () => AlbumView(), binding: AlbumBinding()),
    GetPage(
        name: '/history', page: () => HistoryView(), binding: HistoryBinding()),
    GetPage(name: '/radio', page: () => RadioView(), binding: RadioBinding()),
    GetPage(
        name: '/radio_detail',
        page: () => RadioDetailView(),
        binding: RadioDetailBinding()),
    GetPage(
        name: '/play_list_manager',
        page: () => PlayListManagerView(),
        binding: PlayListManagerBinding()),
    GetPage(
        name: '/top_artists',
        page: () => TopArtists(),
        binding: TopArtistsBinding()),
  ];
}
