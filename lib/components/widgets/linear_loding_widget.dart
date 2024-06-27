import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeStateProvider<bool> loadingProvider =
    StateProvider.autoDispose<bool>((ref) {
  return false;
});

class LinearLodingWidget extends ConsumerWidget {
  const LinearLodingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isloading = ref.watch(loadingProvider);

    return isloading
        ? const LinearProgressIndicator()
        : const SizedBox.shrink();
  }
}
