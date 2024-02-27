// Copyright 2023 trinity
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import "package:bank/common/constant.dart";
import "package:flutter/material.dart";
import "package:percent_indicator/circular_percent_indicator.dart";

class PictureLoading extends StatelessWidget {
  const PictureLoading({
    required this.progress,
    super.key,
  });

  final double progress;
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      percent: progress / 100.0,
      lineWidth: 10.0,
      radius: 50,
      progressColor: context.secondaryColor,
      header: const Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Text(
          "Uploading",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            fontFamily: "Roboto",
          ),
        ),
      ),
      center: Text(
        "${progress.round()}%",
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          fontFamily: "Roboto",
        ),
      ),
    );
  }
}
