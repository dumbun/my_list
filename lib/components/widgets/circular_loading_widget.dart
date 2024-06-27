import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list/components/widgets/linear_loding_widget.dart';

class CircularLoadingWidget extends ConsumerWidget {
  const CircularLoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isloading = ref.watch(loadingProvider);

    return isloading
        ? const CircularProgressIndicator.adaptive()
        : const SizedBox.shrink();
  }
}
