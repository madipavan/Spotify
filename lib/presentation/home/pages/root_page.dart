import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/themes/app_colors.dart';
import 'package:spotify/presentation/home/widget/new_songs.dart';
import 'package:spotify/presentation/home/widget/play_list.dart';

import '../../../common/widgets/appbar/app_bar.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../viewmodels/choosemode/choosemode_provider.dart';
import '../../../viewmodels/songplayer/song_player_provider.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    state == AppLifecycleState.detached
        ? Provider.of<SongPlayerProvider>(context).close()
        : null;
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        thememode: _themeMode(),
        profile: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/ProfilePage");
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.person_2_rounded),
            )),
        leading: false,
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _hometopcard(),
            _tabbar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 260,
                child: TabBarView(controller: _tabController, children: const [
                  NewSongs(),
                  NewSongs(),
                  NewSongs(),
                  NewSongs(),
                ]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const PlayList(),
          ],
        ),
      ),
    );
  }

  Widget _hometopcard() {
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(AppVectors.home_top)),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Image.asset(AppImages.home_artist),
                )),
          ],
        ),
      ),
    );
  }

  Widget _tabbar() {
    return TabBar(
        indicatorColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 40),
        controller: _tabController,
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        dividerHeight: 0,
        isScrollable: false,
        tabs: const [
          Text(
            "News",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            "Videos",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            "Artists",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            "Podcasts",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ]);
  }

  Widget _themeMode() {
    return GestureDetector(
      onTap: () {
        context.isDarkMode
            ? context.read<ChooseModeProvider>().toggleTheme(false)
            : context.read<ChooseModeProvider>().toggleTheme(true);
      },
      child: Container(
        height: 30,
        width: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.isDarkMode
              ? Colors.white.withOpacity(0.03)
              : AppColors.darkgrey,
        ),
        child: Transform.scale(
          scale: 0.6,
          child: SvgPicture.asset(
            context.isDarkMode ? AppVectors.sun : AppVectors.moon,
          ),
        ),
      ),
    );
  }
}
