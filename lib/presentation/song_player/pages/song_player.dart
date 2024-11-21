import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/configs/themes/app_colors.dart';
import 'package:spotify/models/song_model.dart';
import 'package:spotify/utils/constant/app_url.dart';
import 'package:spotify/viewmodels/songplayer/song_player_provider.dart';

class SongPlayerPage extends StatelessWidget {
  final List<SongModel> songs;
  final int index;
  const SongPlayerPage({super.key, required this.songs, required this.index});

  @override
  Widget build(BuildContext context) {
    context.read<SongPlayerProvider>().setCurrentIndex(index);
    context.watch<SongPlayerProvider>().seekmusic();
    return FutureBuilder(
      future: context.read<SongPlayerProvider>().songloading(
          "${AppUrl.firestoragesongs}${songs[context.read<SongPlayerProvider>().index].title}.mp3?${AppUrl.altmedia}"),
      builder: (context, snapshot) {
        // value.songloading(
        //     "${AppUrl.firestoragesongs}${songs[value.index].title}.mp3?${AppUrl.altmedia}");

        return Scaffold(
          appBar: BasicAppBar(
            leading: true,
            title: const Text(
              "Now Playing",
              style: TextStyle(fontSize: 18),
            ),
            profile: IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_vert_outlined)),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                _songcover(
                    context, songs[context.watch<SongPlayerProvider>().index]),
                const SizedBox(
                  height: 20,
                ),
                _songdetail(
                    songs[context.watch<SongPlayerProvider>().index], context),
                const SizedBox(
                  height: 30,
                ),
                _songplayer(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _songcover(context, SongModel song) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "${AppUrl.firestoragecover}${song.title}.jpg?${AppUrl.altmedia}"))),
    );
  }

  Widget _songdetail(SongModel song, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              song.title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              song.artist,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              song.isfavourite
                  ? Icons.favorite
                  : Icons.favorite_outline_rounded,
              color: AppColors.darkgrey,
              size: 35,
            ))
      ],
    );
  }

  Widget _songplayer(BuildContext context) {
    return Consumer<SongPlayerProvider>(
      builder: (context, value, child) {
        if (value.isloading!) {
          return const CircularProgressIndicator(
            color: AppColors.primary,
          );
        } else if (value.errormsg != null) {
          return const Text("Oops Something Went Wrong!");
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Slider(
                  activeColor: AppColors.primary,
                  inactiveColor: const Color(0xffB7B7B7),
                  thumbColor: const Color(0xffB7B7B7),
                  value: value.songposition.inSeconds.toDouble(),
                  min: 0.0,
                  max: value.songduration.inSeconds.toDouble(),
                  onChanged: (val) {
                    value.audioplayer.seek(Duration(seconds: val.toInt()));
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatduration(value.songposition),
                  ),
                  Text(
                    formatduration(value.songduration),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        value.setBackwardIndex(songs.length);
                        context.read<SongPlayerProvider>().songloading(
                            "${AppUrl.firestoragesongs}${songs[context.read<SongPlayerProvider>().index].title}.mp3?${AppUrl.altmedia}");
                      },
                      icon: const Icon(
                        Icons.skip_previous_rounded,
                        size: 35,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      value.songplayorpause();
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                          color: AppColors.primary, shape: BoxShape.circle),
                      child: Icon(value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow_rounded),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () async {
                        value.setForwardIndex(songs.length);
                        await context.read<SongPlayerProvider>().songloading(
                            "${AppUrl.firestoragesongs}${songs[context.read<SongPlayerProvider>().index].title}.mp3?${AppUrl.altmedia}");
                      },
                      icon: const Icon(
                        Icons.skip_next_rounded,
                        size: 35,
                      ))
                ],
              ),
            ],
          );
        }
      },
    );
  }

  String formatduration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
  }
}
