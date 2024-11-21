import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/configs/themes/app_colors.dart';
import 'package:spotify/models/song_model.dart';
import 'package:spotify/viewmodels/userviewmodel/userprofile_viewmodel.dart';

import '../../../common/widgets/snackbar/basic_snackbar.dart';
import '../../../utils/constant/app_url.dart';
import '../../../viewmodels/favsongs/fav_songs.dart';
import '../../../viewmodels/songsviewmodel/favsonglist_viewmodel.dart';
import '../../../viewmodels/songsviewmodel/songs_list.dart';
import '../../song_player/pages/song_player.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        profile: IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/GetStartedPage", (route) => false);
            },
            icon: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.03)
                    : Colors.black.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout,
                size: 15,
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
            )),
        backgroudcolor:
            context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
        title: const Text("Profile"),
        leading: true,
      ),
      body: Column(
        children: [
          _profileInfo(context),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: Provider.of<FavsonglistViewmodel>(context, listen: false)
                .getFavsongslist(),
            builder: (context, snapshot) => Consumer<FavsonglistViewmodel>(
              builder: (context, value, child) {
                if (value.isloading) {
                  return Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        color: AppColors.primary,
                      ));
                } else if (value.errormsg != null) {
                  return const Text("Oops!");
                } else {
                  return _favSongs(value.favsongslist);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
      ),
      child: Consumer<UserprofileViewmodel>(
        builder: (context, value, child) {
          value.isloading ? value.getUser() : null;

          if (value.isloading) {
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: AppColors.primary,
                ));
          } else if (value.errormsg != null) {
            return const Text("Oops!");
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(value.user!.imageurl!)),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(value.user!.email!),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  value.user!.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _favSongs(List<SongModel> favsongslist) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("FAVORITE SONGS"),
          const SizedBox(
            height: 20,
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SongPlayerPage(songs: favsongslist, index: index))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "${AppUrl.firestoragecover}${favsongslist[index].title}.jpg?${AppUrl.altmedia}")),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            favsongslist[index].title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            favsongslist[index].artist,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(favsongslist[index]
                          .duration
                          .toString()
                          .replaceAll(".", ":")),
                      const SizedBox(
                        width: 10,
                      ),
                      Consumer<FavsonglistViewmodel>(
                        builder: (context, value, child) => IconButton(
                            onPressed: () async {
                              await context
                                  .read<FavSongsProvider>()
                                  .addOrremovefavSongs(
                                      favsongslist[index].songId);

                              await value.getFavsongslist();
                              await context.read<SongsList>().getPlaylist();
                              if (value.errormsg != null) {
                                BasicSnackBar.showSnackbar(
                                    context, "Failed To Add");
                              } else {
                                BasicSnackBar.showSnackbar(context, "Done!!");
                              }
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: AppColors.darkgrey,
                              size: 25,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
            itemCount: favsongslist.length,
          )
        ],
      ),
    );
  }
}
