import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/core/configs/constants/app_urls.dart';
import 'package:spotify_clone/domain/entities/song/song.dart';
import 'package:spotify_clone/presentation/home/bloc/news_song_cubit.dart';
import 'package:spotify_clone/presentation/home/bloc/news_song_state.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongCubit, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }
            if (state is NewsSongsLoaded) {
              return _song(context, state.songs);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _song(BuildContext context, List<SongEntity> songs) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return SizedBox(
            width: 160,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                          image: NetworkImage(
                              '${AppUrls.fireStorage}${songs[index].artist} - ${songs[index].title}.jpg?${AppUrls.mediaAlt}')),
                    ),
                  ),
                ),
              ],
            ));
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 14,
      ),
      itemCount: songs.length,
    );
  }
}
