import 'package:car_wash/widgets/showConfirmation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// Provides methods to manage the permissions at runtime.
abstract class PermissionUtils {
  /// Manages all the given permissions with support for optional permissions.
  static Future<void> managePermissions({
    required BuildContext context,
    required VoidCallback onGranted,
    required List<Permission> permissions,
    List<Permission>? optionalPermissions,
  }) async {
    var customPermissions = permissions.map((permission) {
      final string = permission.toString();
      return CustomPermission(
        permission: permission,
        name: string.substring(string.indexOf('.') + 1),
        isOptional: optionalPermissions?.contains(permission) ?? false,
      );
    }).toList();

    customPermissions = await Future.sync(() async {
      for (final customPermission in customPermissions) {
        final permission = customPermission.permission;
        final isGranted = await permission.isGranted;
        customPermission
          ..isDenied = !isGranted
          ..isGranted = isGranted;
        if (!isGranted) {
          final status = await permission.request();
          customPermission
            ..isGranted = status.isGranted || status.isLimited
            ..isDenied = status.isPermanentlyDenied || status.isDenied;
        }
      }
      return customPermissions;
    });

    if (!customPermissions.where((e) => !e.isOptional).any((e) => !e.isGranted)) {
      onGranted();
    }

    final deniedPermissions = customPermissions
        .where((permission) => !permission.isOptional && permission.isDenied)
        .map((permission) => permission.name);

    if (deniedPermissions.isNotEmpty) {
      // ignore: use_build_context_synchronously
      final result = await showConfirmationBottomSheet(
            context: context,
            denialTitle: 'Cancel',
            isApprovalPositive: true,
            approvalTitle: 'Open Settings',
            heading: 'Permissions Required',
            content: Text(
              textAlign: TextAlign.center,
              'Please allow ${deniedPermissions.join(', ')} permissions from settings.',
            ),
          ) ??
          false;

      if (result != null) await openAppSettings();
    }
  }
}

class CustomPermission {
  CustomPermission({
    required this.permission,
    required this.name,
    this.isDenied = true,
    this.isGranted = false,
    this.isOptional = false,
  });
  final Permission permission;
  final String name;
  bool isOptional;
  bool isGranted;
  bool isDenied;
}
