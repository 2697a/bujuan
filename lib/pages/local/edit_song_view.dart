import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/widget/app_bar.dart';
import 'package:bujuan/widget/data_widget.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:on_audio_edit/on_audio_edit.dart';

class EditSongView extends StatefulWidget {
  const EditSongView({Key? key}) : super(key: key);

  @override
  State<EditSongView> createState() => _EditSongViewState();
}

class _EditSongViewState extends State<EditSongView> {
  final OnAudioEdit edit = GetIt.instance<OnAudioEdit>();
  AudioModel? audioModel;
  final TextEditingController _lyricEdit = TextEditingController();
  final TextEditingController _nameEdit = TextEditingController();
  final TextEditingController _artistEdit = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getSongInfo();
    });
    super.initState();
  }

  _getSongInfo() async {
    audioModel = await edit.readAudio((context.routeData.args as MediaItem).extras?['url']);
    setState(() {});
    _nameEdit.text = audioModel?.title ?? '';
    _artistEdit.text = audioModel?.artist ?? '';
    _lyricEdit.text = audioModel?.lyrics ?? '';
  }

  _modifyArt() {
    // edit.editArtwork((context.routeData.args as MediaItem).extras?['url']);
  }

  _saveData() async {
    if (_nameEdit.text.isEmpty) {
      WidgetUtil.showToast('歌曲名称不能为空');
      return;
    }
    if (_artistEdit.text.isEmpty) {
      WidgetUtil.showToast('歌手名称不能为空');
      return;
    }
    WidgetUtil.showLoadingDialog(context);
    bool editAudio = await edit.editAudio(
        (context.routeData.args as MediaItem).extras?['url'], {TagType.TITLE: _nameEdit.text, TagType.ARTIST: _artistEdit.text, TagType.LYRICS: _lyricEdit.text,TagType.ALBUM:audioModel?.album},
        searchInsideFolders: true);

    // if (Home.to.audioServeHandler.queueTitle.value == 'local1') {
    //   Home.to.audioServeHandler.updateMediaItem((context.routeData.args as MediaItem).copyWith(title: _nameEdit.text, artist: _artistEdit.text));
    // }
    if (editAudio) {
      WidgetUtil.showToast('修改成功');
    } else {
      WidgetUtil.showToast('修改失败');
    }
    if(mounted)context.router.pop(editAudio);
  }

  @override
  void dispose() {
    _lyricEdit.dispose();
    _nameEdit.dispose();
    _artistEdit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: const Text('编辑歌曲信息'),
        actions: [IconButton(onPressed: () => _saveData(), icon: const Icon(TablerIcons.device_floppy))],
      ),
      body: Visibility(
        visible: audioModel != null,
        replacement: const LoadingView(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: SimpleExtendedImage(
                      (context.routeData.args as MediaItem).extras?['image'],
                      width: 200.w,
                      height: 200.w,
                      borderRadius: BorderRadius.circular(15.w),
                    ),
                    onTap: () => _modifyArt(),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 8.w)),
                  Expanded(
                      child: SizedBox(
                    height: 220.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextField(
                          controller: _nameEdit,
                          maxLines: 1,
                          style: TextStyle(fontSize: 30.sp),
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 30.sp),
                              contentPadding: const EdgeInsets.only(bottom: 1, top: 1, left: 8, right: 8),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              )),
                        ),
                        TextField(
                          controller: _artistEdit,
                          maxLines: 1,
                          style: TextStyle(fontSize: 30.sp),
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 30.sp),
                              contentPadding: const EdgeInsets.only(bottom: 1, top: 1, left: 8, right: 8),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              )),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 25.w)),
              TextField(
                controller: _lyricEdit,
                maxLines: 20,
                style: TextStyle(fontSize: 26.sp),
                decoration: const InputDecoration(
                    labelText: '歌词',
                    contentPadding: EdgeInsets.only(bottom: 2, top: 25, left: 8, right: 8),
                    labelStyle: TextStyle(fontSize: 22),
                    border: OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),

                      ///用来配置边框的样式
                      borderSide: BorderSide(
                        ///设置边框的颜色
                        color: Colors.red,

                        ///设置边框的粗细
                        width: 2.0,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
