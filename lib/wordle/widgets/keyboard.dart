import 'package:flutter/material.dart';
import 'package:wordle/wordle/wordle.dart';

const _qwerty = [
  ['Q', 'w', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'DELETE'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['Z', 'X', 'C', 'V', 'B', 'N', 'M', 'ENTER'],
];

class Keyboard extends StatelessWidget {
  const Keyboard({
    super.key,
    required this.onKeyTapped,
    required this.onDeleteTapped,
    required this.onEnterTapped,
    required this.letters,
  });

  final void Function(String) onKeyTapped;
  final VoidCallback onDeleteTapped;
  final VoidCallback onEnterTapped;
  final Set<Letter> letters;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _qwerty
          .map(
            (keyRow) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: keyRow.map(
                (letter) {
                  if (letter == 'DELETE') {
                    return _KeyboardButton.delete(onTap: onDeleteTapped);
                  } else if (letter == 'ENTER') {
                    return _KeyboardButton.enter(onTap: onEnterTapped);
                  }

                  final letterKey = letters.firstWhere(
                    (e) => e.val == letter,
                    orElse: () => Letter.empty(),
                  );

                  return _KeyboardButton(
                    onTap: () => onKeyTapped(letter),
                    letter: letter,
                    backgroundColor: letterKey != Letter.empty()
                        ? letterKey.backgroundColor
                        : Colors.grey,
                  );
                },
              ).toList(),
            ),
          )
          .toList(),
    );
  }
}

class _KeyboardButton extends StatelessWidget {
  const _KeyboardButton({
    super.key,
    this.height = 48,
    this.width = 30,
    required this.letter,
    required this.backgroundColor,
    required this.onTap,
  });

  final double height;
  final double width;
  final String letter;
  final Color backgroundColor;
  final VoidCallback onTap;

  factory _KeyboardButton.enter({required VoidCallback onTap}) {
    return _KeyboardButton(
      width: 56,
      letter: 'ENTER',
      backgroundColor: Colors.grey,
      onTap: onTap,
    );
  }

  factory _KeyboardButton.delete({required VoidCallback onTap}) {
    return _KeyboardButton(
      width: 56,
      letter: 'DELETE',
      backgroundColor: Colors.grey,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 2,
      ),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            child: Text(
              letter,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
