part of '../home_page.dart';

class _MusicList extends StatelessWidget {
  final BuiltList<Music> list;
  const _MusicList({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (context, _) => Padding(
        padding: EdgeInsets.symmetric(horizontal: UiGap.normal.size),
        child: Divider(color: Theme.of(context).primaryColor, height: 0),
      ),
      itemBuilder: (context, index) {
        final music = list[index];
        return _MusicTile(music: music);
      },
    );
  }
}

class _MusicTile extends StatelessWidget {
  final Music music;

  const _MusicTile({
    Key? key,
    required this.music,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(UiGap.normal.size),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              width: 60,
              height: 60,
              child: music.imageUrl == null
                  ? null
                  : Image.network(music.imageUrl!, fit: BoxFit.contain),
            ),
            UiGap.normal.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    music.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  UiGap.small.verticalSpace,
                  Text(
                    music.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  UiGap.medium.verticalSpace,
                  Text(
                    music.album,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
