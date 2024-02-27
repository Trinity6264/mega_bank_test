import "package:flutter/material.dart"
    show BuildContext, Color, MediaQuery, Size;

extension BuildContextExtension on BuildContext {
// ? Colors
  Color get primaryColor => const Color(0xff022E64);
  Color get primaryLightColor => const Color(0xff00408F);
  Color get secondaryColor => const Color(0xffE6B014);
  Color get whiteTextColor => const Color(0xffffffff);
  Color get blackTextColor => const Color(0xff212121);

// ? fonts,padding sizes etc.

//? Padding, Height, width
  double get smallPaddingSize => 8.0;
  double get mediumPaddingSize => 16.0;
  double get navbarIconSize => 32.0;
  double get navbarHeightSize => 50.0;
  double get appbarProfilePictureSize => 42.0;

// ? Radius
  double get mediumRadiusSize => 16.0;

  // ? Body font size
  double get bodyFontSize => 14.0;
  double get headerFontSize => 24.0;
  double get bodySmallFontSize => 10.0;
  double get greetingsTextFontSize => 12.0;
  double get nameTextFontSize => 16.0;
  double get transactionTextFontSize => 18.0;
  double get textButtonFontSize => 14.0;
  double get textBalanceFontSize => 36.0;

  double getBodyFontSize() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => bodyFontSize * 1.3,
      > 720 => bodyFontSize * 1.2,
      > 640 => bodyFontSize * 1.1,
      > 360 => bodyFontSize * 1.0,
      double() => bodyFontSize * 1.0,
    };
  }

  double getHeaderFontSize() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => headerFontSize * 1.3,
      > 720 => headerFontSize * 1.2,
      > 640 => headerFontSize * 1.1,
      > 360 => headerFontSize * 1.0,
      double() => headerFontSize * 1.0,
    };
  }

  //? start Dashboard

  double dashBoardAppBarHeight() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => height / 11,
      > 720 => height / 12,
      > 640 => height / 10,
      > 360 => height / 10,
      double() => height / 10,
    };
  }

  double dashBoardBottomBarHeight() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => height / 12,
      > 720 => height / 11,
      > 640 => height / 10,
      > 360 => height / 10,
      double() => height / 10,
    };
  }

  double transactionTopBarHeight() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => height / 7,
      > 720 => height / 7,
      > 640 => height / 6,
      > 360 => height / 6,
      double() => height / 6,
    };
  }
  //? end Dashboard

  // ?start profile page
  double profilePageAppbar() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => height / 8,
      > 720 => height / 8,
      > 640 => height / 7,
      > 360 => height / 7,
      double() => height / 7,
    };
  }

  double profilePageBottomAppbar() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => height / 5,
      > 720 => height / 5,
      > 640 => height / 4,
      > 360 => height / 4,
      double() => height / 4,
    };
  }
  // ?end profile page

  double getBodySmallFontSize() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => bodySmallFontSize * 1.3,
      > 720 => bodySmallFontSize * 1.2,
      > 640 => bodySmallFontSize * 1.1,
      > 360 => bodySmallFontSize * 1.0,
      double() => bodySmallFontSize * 1.0,
    };
  }

  double getGreetingsTextFontSize() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => greetingsTextFontSize * 1.3,
      > 720 => greetingsTextFontSize * 1.2,
      > 640 => greetingsTextFontSize * 1.1,
      > 360 => greetingsTextFontSize * 1.0,
      double() => greetingsTextFontSize * 1.0,
    };
  }

  double getNameTextFontSize() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => nameTextFontSize * 1.2,
      > 720 => nameTextFontSize * 1.1,
      > 640 => nameTextFontSize * 1.1,
      > 360 => nameTextFontSize * 1.0,
      double() => nameTextFontSize * 1.0,
    };
  }

  double getTransactionTextFontSize() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => transactionTextFontSize * 1.3,
      > 720 => transactionTextFontSize * 1.2,
      > 640 => transactionTextFontSize * 1.1,
      > 360 => transactionTextFontSize * 1.0,
      double() => transactionTextFontSize * 1.0,
    };
  }

  double getTextBalanceFontSize() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => textBalanceFontSize * 1.3,
      > 720 => textBalanceFontSize * 1.2,
      > 640 => textBalanceFontSize * 1.1,
      > 360 => textBalanceFontSize * 1.0,
      double() => textBalanceFontSize * 1.0,
    };
  }

  double getTextButtonFontSize() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => textButtonFontSize * 1.3,
      > 720 => textButtonFontSize * 1.2,
      > 640 => textButtonFontSize * 1.1,
      > 360 => textButtonFontSize * 1.0,
      double() => textButtonFontSize * 1.0,
    };
  }

  double getMediumRadiusSize() {
    final Size(:height) = MediaQuery.sizeOf(this);
    return switch (height) {
      > 1080 => mediumRadiusSize * 1.25,
      > 720 => mediumRadiusSize * 1.2,
      > 640 => mediumRadiusSize * 1.1,
      > 360 => mediumRadiusSize * 1.0,
      double() => mediumRadiusSize * 1.0,
    };
  }

  double getSmallPaddingSize() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => smallPaddingSize * 1.3,
      > 720 => smallPaddingSize * 1.2,
      > 640 => smallPaddingSize * 1.1,
      > 360 => smallPaddingSize * 1.0,
      double() => smallPaddingSize * 1.0,
    };
  }

  double getMediumPaddingSize() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => mediumPaddingSize * 1.3,
      > 720 => mediumPaddingSize * 1.2,
      > 640 => mediumPaddingSize * 1.1,
      > 360 => mediumPaddingSize * 1.0,
      double() => mediumPaddingSize * 1.0,
    };
  }

  double getAppbarProfilePictureSize() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => appbarProfilePictureSize * 1.3,
      > 720 => appbarProfilePictureSize * 1.2,
      > 640 => appbarProfilePictureSize * 1.1,
      > 360 => appbarProfilePictureSize * 1.0,
      double() => appbarProfilePictureSize * 1.0,
    };
  }

  double getNavbarHeightSize() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => navbarHeightSize * 1.3,
      > 720 => navbarHeightSize * 1.2,
      > 640 => navbarHeightSize * 1.1,
      > 360 => navbarHeightSize * 1.0,
      double() => navbarHeightSize * 1.0,
    };
  }

  double getNavbarIconSize() {
    final Size(:height) = MediaQuery.sizeOf(this);

    return switch (height) {
      > 1080 => navbarIconSize * 1.15,
      > 720 => navbarIconSize * 1.13,
      > 640 => navbarIconSize * 1.12,
      > 360 => navbarIconSize * 1.0,
      double() => navbarIconSize * 1.0,
    };
  }
}
