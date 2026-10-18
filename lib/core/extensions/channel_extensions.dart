import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/string_extensions.dart';

/// Display helpers for a [Channel], resolved relative to the current user.
extension ChannelX on Channel {
  bool get isGroup => (memberCount ?? 0) > 2;

  List<Member> otherMembers(String? currentUserId) =>
      state?.members.where((m) => m.userId != currentUserId).toList() ??
      const [];

  /// The other participant of a one-to-one channel, if any.
  User? directPeer(String? currentUserId) {
    final others = otherMembers(currentUserId);
    return others.length == 1 ? others.first.user : null;
  }

  String displayName(String? currentUserId) {
    final channelName = name;
    if (channelName != null && channelName.isNotEmpty) return channelName;

    final others = otherMembers(currentUserId);
    return switch (others.length) {
      0 => AppStrings.unnamedChat,
      1 => others.first.user?.name ?? AppStrings.unknownUser,
      _ => others.map((m) => m.user?.name.firstWord).nonNulls.join(', '),
    };
  }

  String? displayImage(String? currentUserId) =>
      image ?? directPeer(currentUserId)?.image;
}
