import 'package:flutter/material.dart';

/// A reusable numeric PIN keyboard widget.
///
/// Displays a 4x3 grid of keys (1–9, Hapus, 0) separated by divider lines.
/// Calls [onKeyPressed] with the key label when a key is tapped.
/// The bottom-right cell is intentionally left empty.
class PinKeyboardWidget extends StatelessWidget {
  /// Called when a key is pressed. The [key] parameter is the key label,
  /// e.g. `'1'`, `'0'`, or `'Hapus'`.
  final void Function(String key) onKeyPressed;

  const PinKeyboardWidget({super.key, required this.onKeyPressed});

  static const _rows = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['Hapus', '0', ''],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_rows.length, (rowIndex) {
        final row = _rows[rowIndex];
        final isLastRow = rowIndex == _rows.length;
        return Expanded(
          child: Column(
            children: [
              if (!isLastRow)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.white.withValues(alpha: 0.15),
                ),
              Expanded(
                child: Row(
                  children: List.generate(row.length, (colIndex) {
                    final key = row[colIndex];
                    final isLastCol = colIndex == row.length - 1;
                    return Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _buildKey(key)),
                          if (!isLastCol)
                            VerticalDivider(
                              width: 1,
                              thickness: 1,
                              color: Colors.white.withValues(alpha: 0.15),
                            ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildKey(String key) {
    if (key.isEmpty) return const SizedBox.expand();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onKeyPressed(key),
        splashColor: Colors.white.withValues(alpha: 0.1),
        highlightColor: Colors.white.withValues(alpha: 0.08),
        child: Center(
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }
}
