import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_in_flutter_with_api/providers/state_provider.dart';

final postApiProvider =
    StateNotifierProvider<PostStateNotifier, PostState>((ref) {
  return PostStateNotifier();
});
