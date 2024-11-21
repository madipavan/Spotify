import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/core/configs/themes/app_theme.dart';
import 'package:spotify/utils/app_routs.dart';
import 'package:spotify/viewmodels/choosemode/choosemode_provider.dart';
import 'package:spotify/viewmodels/favsongs/fav_songs.dart';
import 'package:spotify/viewmodels/songplayer/song_player_provider.dart';
import 'package:spotify/viewmodels/songsviewmodel/favsonglist_viewmodel.dart';
import 'package:spotify/viewmodels/songsviewmodel/songs_list.dart';
import 'package:spotify/viewmodels/userviewmodel/userprofile_viewmodel.dart';
import 'package:spotify/viewmodels/userviewmodel/userview_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDV6r_Jqg1hOA9GgtL91V8gDZoj-mjGzOw",
          appId: "1:220340290594:android:839a7f99ffb444e6c7f67b",
          messagingSenderId: "220340290594",
          projectId: "main-a82f7"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChooseModeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserviewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SongsList(),
        ),
        ChangeNotifierProvider(
          create: (context) => SongPlayerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavSongsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserprofileViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavsonglistViewmodel(),
        ),
      ],
      builder: (context, child) => MaterialApp(
          theme: AppTheme.lighttheme,
          darkTheme: AppTheme.darktheme,
          themeMode: Provider.of<ChooseModeProvider>(context).currentTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          routes: AppRouts.routes),
    );
  }
}
