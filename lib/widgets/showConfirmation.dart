import 'dart:math';

import 'package:flutter/material.dart';

/// Provides the customizable bottom sheet for asking some confirmation to the user.
/// (For ex. Logout pop up)
Future showConfirmationBottomSheet({
  required BuildContext context,
  required Widget content,
  Widget? buttonBar,
  Widget? headingWidget,
  String denialTitle = 'Close',
  String approvalTitle = 'Exit',
  VoidCallback? onDenialPressed,
  VoidCallback? onApprovalPressed,
  String? heading = 'Are you sure?',
  bool showApprovalBackground = true,
  bool showDenialBackground = false,
  bool isApprovalPositive = false,
  bool isDenialPositive = false,
}) {
  assert(
    heading != null || headingWidget != null,
    "Properties [heading] and [headingWidget] can't be null at the same time.",
  );
  return showModalBottomSheet(
    context: context,
    enableDrag: true,
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    backgroundColor: Colors.transparent,
    builder: (context) {
      // final isPortrait = SizeConfig.isPortrait;
      final theme = Theme.of(context);
      return SafeArea(
        child: Container(
          // padding: EdgeInsets.all(SizeConfig.l1),
          decoration: BoxDecoration(
            color: theme.canvasColor,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),
          // constraints: BoxConstraints(
          //   maxHeight: min(
          //     // SizeConfig.screenHeight * (isPortrait ? 0.35 : 0.7),
          //     350,
          //   ),
          //   maxWidth: min(
          //     // SizeConfig.screenWidth * (isPortrait ? 1.0 : 0.8),
          //     720,
          //   ),
          // ),
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              children: [
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: headingWidget ??
                      Text(
                        heading!,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall,
                      ),
                ),
                // Divider(indent: SizeConfig.l1, endIndent: SizeConfig.l1),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.05,
                      vertical: constraints.maxHeight * 0.05,
                    ),
                    child: content,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: constraints.maxHeight * 0.03),
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05,
                    vertical: constraints.maxHeight * 0.03,
                  ),
                  decoration: BoxDecoration(
                    color: theme.dividerColor,
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                  ),
                  child: buttonBar ??
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.4,
                            child: TextButton(
                              onPressed: onDenialPressed ?? () => Navigator.of(context).pop(false),
                              child: Text(
                                denialTitle,
                                // padding: EdgeInsets.zero,
                                // backgroundColor: showDenialBackground
                                //     ? isApprovalPositive
                                //         ? AppColors.kB1ButtonColor
                                //         : AppColors.kE2ErrorColor
                                //     : theme.cardColor,
                                style: showDenialBackground
                                    ? null
                                    : theme.textTheme.titleMedium?.copyWith(
                                        color: theme.cardColor.computeLuminance() > 0.5
                                            ? Colors.black54
                                            : Colors.white70,
                                        fontWeight: FontWeight.bold,
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.4,
                            child: TextButton(
                                onPressed:
                                    onApprovalPressed ?? () => Navigator.of(context).pop(true),
                                child: Text(
                                  // backgroundColor: isApprovalPositive
                                  //     ? AppColors.kB1ButtonColor
                                  //     : AppColors.kE2ErrorColor,
                                  approvalTitle,
                                  // padding: EdgeInsets.zero,
                                )),
                          ),
                        ],
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
