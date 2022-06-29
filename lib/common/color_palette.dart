//palette.dart
import 'package:flutter/material.dart';

class ColorPalette {
  // static const MaterialColor primary = const MaterialColor(
  //   0xff005F37,
  //   const <int, Color>{
  //     50: const Color(0xffe3fbe7), //10%
  //     100: const Color(0xffC5F7CE), //20%
  //     200: const Color(0xff8FEEAA), //30%
  //     300: const Color(0xff52CF81), //40%
  //     400: const Color(0xff279F60), //50%
  //     500: const Color(0xff005F37), //60%
  //     600: const Color(0xff005137), //70%
  //     700: const Color(0xff004435), //80%
  //     800: const Color(0xff003730), //90%
  //     900: const Color(0xff002D2C), //100%
  //   },
  // );

  static const MaterialColor primary = const MaterialColor(
    0xff0288D1, 
    const <int, Color> {
      50: const Color(0x0288D1),
      100: const Color(0x0288D1),
      200: const Color(0x0288D1),
      300: const Color(0x0288D1),
      400: const Color(0x0288D1),
      500: const Color(0x0288D1),
      600: const Color(0x0288D1),
      700: const Color(0x0288D1),
      800: const Color(0x0288D1),
      900: const Color(0x0288D1),
    }
  );

  static const MaterialColor danger =
      const MaterialColor(0xffD12623, const <int, Color>{
    50: const Color(0xfffdebe1), //10%
    100: const Color(0xffFCE1D2), //20%
    200: const Color(0xffFABDA7), //30%
    300: const Color(0xffF18F78), //40%
    400: const Color(0xffE36455), //50%
    500: const Color(0xffD12623), //60%
    600: const Color(0xffB31924), //70%
    700: const Color(0xff961126), //80%
    800: const Color(0xff790B25), //90%
    900: const Color(0xff640625), //100%
  });

  static const MaterialColor success =
      const MaterialColor(0xff129134, const <int, Color>{
    50: const Color(0xffe3fbe7), //10%
    100: const Color(0xffD3F9CD), //20%
    200: const Color(0xffA0F49E), //30%
    300: const Color(0xff69DE71), //40%
    400: const Color(0xff40BD56), //50%
    500: const Color(0xff129134), //60%
    600: const Color(0xff0D7C35), //70%
    700: const Color(0xff096835), //80%
    800: const Color(0xff055431), //90%
    900: const Color(0xff03452E), //100%
  });

  static const MaterialColor info =
      const MaterialColor(0xffFF4081, const <int, Color>{
    50: const Color(0xffFF4081), //10%
    100: const Color(0xffFF4081), //20%
    200: const Color(0xffFF4081), //30%
    300: const Color(0xffFF4081), //40%
    400: const Color(0xffFF4081), //50%
    500: const Color(0xffFF4081), //60%
    600: const Color(0xffFF4081), //70%
    700: const Color(0xffFF4081), //80%
    800: const Color(0xffFF4081), //90%
    900: const Color(0xffFF4081), //100%
  });

  static const MaterialColor warning =
      const MaterialColor(0xffE8A302, const <int, Color>{
    50: const Color(0xfffef9e0), //10%
    100: const Color(0xffFDF4CB), //20%
    200: const Color(0xffFCE798), //30%
    300: const Color(0xffF8D464), //40%
    400: const Color(0xffF1C03D), //50%
    500: const Color(0xffE8A302), //60%
    600: const Color(0xffC78501), //70%
    700: const Color(0xffA76A01), //80%
    800: const Color(0xff865100), //90%
    900: const Color(0xff6F4000), //100%
  });

  static const MaterialColor basic =
      const MaterialColor(0xff0e0e0e, const <int, Color>{
    50: const Color(0xffffffff), //10%
    100: const Color(0xffefefef), //20%
    200: const Color(0xff636363), //30%
    300: const Color(0xff636363), //40%
    400: const Color(0xff636363), //50%
    500: const Color(0xff636363), //60%
    600: const Color(0xff636363), //70%
    700: const Color(0xff2a2a2a), //80%
    800: const Color(0xff2a2a2a), //90%
    900: const Color(0xff0e0e0e), //100%
  });
}
