import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/themes/app_colors.dart';
import 'package:spotify/utils/constant/app_url.dart';
import 'package:spotify/viewmodels/songsviewmodel/songs_list.dart';

import '../../song_player/pages/song_player.dart';

class NewSongs extends StatelessWidget {
  const NewSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<SongsList>(context).getNewRelesedsongslist(),
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
          return const Align(
              alignment: Alignment.topCenter,
              child: Text("Oops Something Went Wrong!"));
        } else {
          return SizedBox(
            height: 200,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SongPlayerPage(
                                songs: value.songslist, index: index))),
                    child: SizedBox(
                      width: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "${AppUrl.firestoragecover}${value.songslist[index].title}.jpg?${AppUrl.altmedia}"),
                                  )),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 40,
                                  transform:
                                      Matrix4.translationValues(10, 10, 0),
                                  width: 40,
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
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            value.songslist[index].title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            value.songslist[index].artist,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      width: 14,
                    ),
                itemCount: value.songslist.length),
          );
        }
      }),
    );
  }
}
