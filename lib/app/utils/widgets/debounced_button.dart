import 'dart:async';

import 'package:flutter/material.dart';

class DebouncedButton extends StatefulWidget {
  final String _text;
  final VoidCallback _onPressed;
  final Duration _duration;

  DebouncedButton({
    required String text,
    required VoidCallback onPressed,
    int debounceTimeMs = 200,
  })  : this._text = text,
        this._onPressed = onPressed,
        this._duration = Duration(milliseconds: debounceTimeMs);

  @override
  _DebouncedButtonState createState() => _DebouncedButtonState();
}

class _DebouncedButtonState extends State<DebouncedButton> {
  late ValueNotifier<bool> _isEnabled;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _isEnabled = ValueNotifier<bool>(true);
  }

  @override
  void dispose() {
    super.dispose();
    try {
      _timer.cancel();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isEnabled,
      builder: (context, isEnabled, child) => ElevatedButton(
        //I think on onPressed,( line 43) if isEnabled is false, need cancel _timer
        onPressed: (_isEnabled.value) ? _onButtonPressed : null,
        child: Text(widget._text),
      ),
    );
  }

  void _onButtonPressed() {
    _isEnabled.value = false;
    widget._onPressed();
    _timer = Timer(widget._duration, () => _isEnabled.value = true);
  }
}
