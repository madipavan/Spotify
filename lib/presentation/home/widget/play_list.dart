import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/snackbar/basic_snackbar.dart';
import 'package:spotify/core/configs/themes/app_colors.dart';
import 'package:spotify/models/song_model.dart';
import 'package:spotify/presentation/song_player/pages/song_player.dart';
import 'package:spotify/viewmodels/songsviewmodel/songs_list.dart';

import '../../../viewmodels/favsongs/fav_songs.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<SongsList>().getPlaylist(),
      builder: (context, snapshot) =>
          Consumer<SongsList>(builder: (context, value, child) {
        if (value.isloading!) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        } else if (value.errormsg != null) {
          return const Text("Oops Something Went Wrong!");
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Playlist",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      "See More",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xffC6C6C6)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(child: _playlist(value.playlist)),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _playlist(List<SongModel> songs) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SongPlayerPage(songs: songs, index: index))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: context.isDarkMode
                              ? AppColors.darkgrey
                              : const Color(0xffE6E6E6),
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: context.isDarkMode
                            ? const Color(0xff959595)
                            : const Color(0xff555555),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          songs[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          songs[index].artist,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(songs[index].duration.toString().replaceAll(".", ":")),
                    const SizedBox(
                      width: 10,
                    ),
                    Consumer<FavSongsProvider>(
                      builder: (context, value, child) => IconButton(
                          onPressed: () async {
                            await value
                                .addOrremovefavSongs(songs[index].songId);
                            await context.read<SongsList>().getPlaylist();
                            if (value.errormsg != null) {
                              BasicSnackBar.showSnackbar(
                                  context, "Failed To Add");
                            } else {
                              BasicSnackBar.showSnackbar(context, "Done!!");
                            }
                          },
                          icon: Icon(
                            songs[index].isfavourite
                                ? Icons.favorite
                                : Icons.favorite_outline_rounded,
                            color: AppColors.darkgrey,
                            size: 25,
                          )),
                    )
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
        itemCount: songs.length);
  }
}
