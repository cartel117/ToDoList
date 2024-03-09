import 'package:flutter/material.dart';

enum ChoiceType { none, low, medium, high }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  ChoiceType type = ChoiceType.none;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: SegmentedButton<ChoiceType>(
        emptySelectionAllowed: false,
        segments: const <ButtonSegment<ChoiceType>>[
          ButtonSegment<ChoiceType>(
              value: ChoiceType.none, label: Text('None')),
          ButtonSegment<ChoiceType>(value: ChoiceType.low, label: Text('Low')),
          ButtonSegment<ChoiceType>(
            value: ChoiceType.medium,
            label: Text('Medium'),
          ),
          ButtonSegment<ChoiceType>(
              value: ChoiceType.high, label: Text('High')),
        ],
        selected: <ChoiceType>{type},
        showSelectedIcon: false,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return const Color.fromRGBO(230, 200, 245, 1); // 改變按鈕被按下時的顏色
              }
              return Colors.white; // 使用原始的 overlayColor
            },
          ),
        ),
        onSelectionChanged: (Set<ChoiceType> newSelection) {
          setState(() {
            type = newSelection.first;
          });
        },
      ),
    );
  }
}
