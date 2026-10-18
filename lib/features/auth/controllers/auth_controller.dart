import 'package:flutter/foundation.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/utils/app_logger.dart';
import 'package:tawasul/features/auth/models/demo_user.dart';

/// Signs demo users in and out of Stream Chat and exposes the busy state.
class AuthController extends ChangeNotifier {
  AuthController({required StreamChatClient client}) : _client = client;

  final StreamChatClient _client;

  String? _pendingUserId;
  var _isSigningOut = false;

  /// Id of the user currently being signed in, if any.
  String? get pendingUserId => _pendingUserId;
  bool get isSigningOut => _isSigningOut;
  bool get isBusy => _pendingUserId != null || _isSigningOut;

  /// Returns `true` when the user was connected successfully.
  Future<bool> signIn(DemoUser user) async {
    if (isBusy) return false;
    _pendingUserId = user.id;
    notifyListeners();
    try {
      await _client.connectUser(
        User(id: user.id, extraData: {'name': user.name, 'image': user.image}),
        _client.devToken(user.id).rawValue,
      );
      return true;
    } on Exception catch (error, stackTrace) {
      appLogger.e('Sign in failed', error: error, stackTrace: stackTrace);
      return false;
    } finally {
      _pendingUserId = null;
      notifyListeners();
    }
  }

  /// Returns `true` when the user was disconnected successfully.
  Future<bool> signOut() async {
    if (isBusy) return false;
    _isSigningOut = true;
    notifyListeners();
    try {
      await _client.disconnectUser();
      return true;
    } on Exception catch (error, stackTrace) {
      appLogger.e('Sign out failed', error: error, stackTrace: stackTrace);
      return false;
    } finally {
      _isSigningOut = false;
      notifyListeners();
    }
  }
}
