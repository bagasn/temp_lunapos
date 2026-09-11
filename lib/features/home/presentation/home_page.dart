import 'package:flutter/material.dart';
import 'package:pos/generated/colors.gen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _navWidgets(),
          Expanded(child: _mainWidget()),
        ],
      ),
    );
  }

  Widget _mainWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [],
    );
  }

  Widget _navWidgets() {
    final navWidth = 80.0;
    return Container(
      width: navWidth,
      height: double.infinity,
      color: AppColors.primaryPurple,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: navWidth,
            height: navWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'L',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
