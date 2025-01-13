import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/yaru.dart';

import '../../../common/view/confirm.dart';
import '../../../l10n/l10n.dart';
import '../../chat_download_model.dart';

class ChatMessageMediaAvatar extends StatelessWidget {
  const ChatMessageMediaAvatar({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(38 / 2),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(38 / 2),
        onTap: () => showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: Text(
              event.messageType == MessageTypes.Location
                  ? context.l10n.openLinkInBrowser
                  : context.l10n.saveFile,
            ),
            onConfirm: () {
              Navigator.of(context).pop();
              if (event.messageType == MessageTypes.Location) {
                final maybeUri = Uri.tryParse(event.body);
                if (maybeUri != null) {
                  launchUrl(maybeUri);
                }
              } else {
                di<ChatDownloadModel>().safeFile(event);
              }
            },
          ),
        ),
        child: CircleAvatar(
          radius: 38 / 2,
          child: switch (event.messageType) {
            MessageTypes.Audio => const Icon(YaruIcons.media_play),
            MessageTypes.Video => const Icon(YaruIcons.video_filled),
            MessageTypes.Location => const Icon(YaruIcons.location),
            _ => const Icon(YaruIcons.document_filled),
          },
        ),
      ),
    );
  }
}
