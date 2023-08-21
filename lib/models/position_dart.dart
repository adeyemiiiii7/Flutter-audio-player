import 'package:flutter/material.dart';

class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );
  
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}
