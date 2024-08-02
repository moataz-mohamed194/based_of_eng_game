import 'package:flutter/material.dart';

abstract class PaintOfBlocks {
  static body({required String color, required String boarderColor}) {
    return """<svg width="41" height="19" viewBox="0 0 41 19" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M1 6.57358V17.6343H34.5255L40.0703 12.0897V1.02319H6.55044L1 6.57358Z" fill="${color}"/>
  <path d="M6.55044 1.02319L1 6.57358V17.6343H34.5255L40.0703 12.0897V1.02319H6.55044Z" fill="${color}"/>
  <path d="M34.1941 6.95611L40.1447 0.999878" stroke="${boarderColor}" stroke-width="1.26328" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M34.2912 6.79651H1V17.6343H34.2912V6.79651Z" stroke="${boarderColor}" stroke-width="1.26328" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M1 6.57358V17.6343H34.5255L40.0703 12.0897V1.02319H6.55044L1 6.57358Z" stroke="${boarderColor}" stroke-width="1.26328" stroke-linecap="round" stroke-linejoin="round"/>
  </svg>
  """;
  }
}
