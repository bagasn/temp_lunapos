import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:pos/features/sync/presentation/bloc/sync_state.dart';

class SyncProgressOverlay extends StatelessWidget {
  const SyncProgressOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncBloc, SyncState>(
      builder: (context, state) {
        if (state is! SyncInProgress) return const SizedBox.shrink();
        return Container(
          color: Colors.black.withAlpha(153),
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: AppColorConstants.primaryPurpleLight,
                ),
                SizedBox(height: 16),
                Text(
                  'Sinkronisasi Data...',
                  style: TextStyle(
                    color: AppColorConstants.textWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
