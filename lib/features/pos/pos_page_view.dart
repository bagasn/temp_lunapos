import 'package:flutter/material.dart';

class PosPageView extends StatefulWidget {
  const PosPageView({super.key});

  @override
  State<PosPageView> createState() => _PosPageViewState();
}

class _PosPageViewState extends State<PosPageView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            children: [
              for (int i = 0; i < 100; i++)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text('Text Item ${i + 1}'),
                ),
            ],
          ),
        ),

        Container(
          width: 400,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.grey.shade300, width: 2),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Text('Order Detail')),
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.more_horiz_rounded),
                  ),
                  IconButton(onPressed: null, icon: Icon(Icons.delete)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
