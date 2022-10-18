import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/application_layer/auth/utils.dart';
import 'package:dzpos/core/common_blocs/common_blocs.dart';
import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/product.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../core/manager/route/routes.dart';
import '../../../core/manager/theme/theme_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SettingsList(
      physics: const BouncingScrollPhysics(),
      platform: DevicePlatform.android,
      lightTheme: SettingsThemeData(
        titleTextColor: context.textTheme.titleMedium!.color,
        tileDescriptionTextColor: context.textTheme.bodyMedium!.color,
        settingsListBackground: context.theme.backgroundColor,
        dividerColor: context.theme.dividerColor,
        settingsSectionBackground: context.theme.cardColor,
      ),
      sections: settings.keys.map((e) {
        final section = settings[e]!;
        return SettingsSection(
          title: Text(e),
          tiles: section.keys.map((t) {
            final tile = section[t]!;
            final type = tile["type"] as SettingsActions;
            return type.widget(
              title: t,
              description: tile["description"],
              enabled: tile["enabled"] ?? true,
              initialValue: tile["initialValue"] ?? false,
              kDescription: tile["kDescription"],
              kStyle: tile["kStyle"],
              kTitle: tile["kTitle"],
              leading: tile["leading"],
              onPressed: tile["onPressed"],
              onToggle: tile["onToggle"],
              routeName: tile["routeName"],
              svgPath: tile["svgPath"] ?? "",
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  late Map<String, Map<String, Map<String, dynamic>>> settings = {
    "General Settings": {
      "Display System information": {
        "type": SettingsActions.navigation,
        "routeName": "",
      },
      "Users and Permission Settings": {
        "type": SettingsActions.navigation,
        "routeName": "",
      },
      "PassCode Security on entry": {
        "type": SettingsActions.switchTile,
        "initialValue": false,
        "onToggle": (value) {}
      },
      "Always backup on exit": {
        "type": SettingsActions.switchTile,
        "initialValue": false,
        "onToggle": (value) {}
      },
    },
    "Language": {
      "العربية": {
        "type": SettingsActions.svg,
        "svgPath": AppAssets.algeria,
      },
      "English": {
        "type": SettingsActions.svg,
        "svgPath": AppAssets.usa,
      },
      "Français": {
        "type": SettingsActions.svg,
        "svgPath": AppAssets.france,
      },
    },
    "Theme Settings": {
      "theme": {
        "type": SettingsActions.custom,
        "onPressed": (BuildContext context) {},
        "kTitle": DropdownButton<FlexScheme>(
          isExpanded: true,
          value: ThemeManager.instance.defaultFlexScheme,
          items: FlexScheme.values
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.name),
                  ))
              .toList(),
          onChanged: (value) {
            CommonBloc.themeBloc.add(ThemeChanged(
              flexScheme: value,
            ));
          },
        ),
      },
      "Theme Mode": {
        "type": SettingsActions.switchTile,
        "initialValue":
            ThemeManager.instance.defaultThemeMode == ThemeMode.dark,
        "onToggle": (value) {
          CommonBloc.themeBloc.add(ThemeChanged(
            themeMode: (value) ? ThemeMode.dark : ThemeMode.light,
          ));
        }
      },
    },
    "Print Settings": {
      'Reporting Components + Logo': {
        "type": SettingsActions.navigation,
        "routeName": AppRoutes.defaultPrint.name,
      },
      "Labels in print": {
        "type": SettingsActions.navigation,
        "routeName": AppRoutes.printLabels.name,
      },
      "Bluetooth Printer Settings": {
        "type": SettingsActions.navigation,
        "onPressed": (BuildContext context) {
          showPrinterSettings(context);
        },
      },
      "Choose Printer Model": {
        "type": SettingsActions.navigation,
        "routeName": "",
      },
      "Font Size": {
        "type": SettingsActions.custom,
        "onPressed": (BuildContext context) {
          statusHandler(context, Status.failure, msg: "Coming soon");
        },
        "title": Row(
          children: [
            const Text("Font Size"),
            20.w.widthBox,
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {},
              ),
            ),
            10.w.widthBox,
            ElevatedButton(
              onPressed: () {},
              child: const Text("Save"),
            )
          ],
        ),
      },
    },
    "Billing Settings": {
      "Increase the quantity of the product in the invoice": {
        "type": SettingsActions.switchTile,
        "initialValue": false,
        "onToggle": (value) {
          statusHandler(context, Status.failure, msg: "Coming soon");
        }
      },
      "Selling at less than cost": {
        "type": SettingsActions.switchTile,
        "initialValue": false,
        "onToggle": (value) {
          statusHandler(context, Status.failure, msg: "Coming soon");
        }
      },
      "Activate minimum quantities alert": {
        "type": SettingsActions.switchTile,
        "initialValue": false,
        "onToggle": (value) {
          statusHandler(context, Status.failure, msg: "Coming soon");
        }
      },
      "Allow selling while stocks last": {
        "type": SettingsActions.switchTile,
        "initialValue": false,
        "onToggle": (value) {
          statusHandler(context, Status.failure, msg: "Coming soon");
        }
      },
      "Separate customers and suppliers accounts in invoices": {
        "type": SettingsActions.switchTile,
        "initialValue": false,
        "onToggle": (value) {
          statusHandler(context, Status.failure, msg: "Coming soon");
        }
      },
      "Open the list of items on sale immediately": {
        "type": SettingsActions.switchTile,
        "initialValue": false,
        "onToggle": (value) {
          statusHandler(context, Status.failure, msg: "Coming soon");
        }
      },
      "The default billing accounts is General Customer": {
        "type": SettingsActions.switchTile,
        "initialValue": false,
        "onToggle": (value) {
          statusHandler(context, Status.failure, msg: "Coming soon");
        }
      },
      "Show items frozen in the new invoice": {
        "type": SettingsActions.switchTile,
        "initialValue": false,
        "c": (value) {
          statusHandler(context, Status.failure, msg: "Coming soon");
        }
      },
      "Display frozen accounts in new invoices": {
        "type": SettingsActions.switchTile,
        "initialValue": false,
        "onToggle": (value) {
          statusHandler(context, Status.failure, msg: "Coming soon");
        }
      },
    },
    "Maintenance": {
      "Repair invoices": {
        "type": SettingsActions.custom,
        "onPressed": (BuildContext context) {
          statusHandler(context, Status.failure, msg: "Coming soon");
        }
      },
      "Fix Permissions": {
        "type": SettingsActions.custom,
        "onPressed": (BuildContext context) {
          statusHandler(context, Status.failure, msg: "Coming soon");
        }
      },
      "Modify and manage Databases": {
        "type": SettingsActions.custom,
        "leading": Icon(
          Icons.dangerous,
          color: context.error,
        ),
        "kStyle": context.textTheme.titleMedium!.copyWith(
          color: context.error,
        ),
        "onPressed": (BuildContext context) {
          statusHandler(context, Status.failure, msg: "Coming soon");
        }
      },
      "SignOut": {
        "type": SettingsActions.custom,
        "leading": Icon(
          Icons.logout,
          color: context.error,
        ),
        "kStyle": context.textTheme.titleMedium!.copyWith(
          color: context.error,
        ),
        "onPressed": (BuildContext context) {
          CommonBloc.authBloc.add(const SignOutRequested());
        },
      },
    }
  };
}

enum SettingsActions {
  navigation,
  switchTile,
  svg,
  custom;

  SettingsTile widget({
    required String title,
    bool enabled = true,
    String? description,
    String? routeName,
    bool initialValue = false,
    Function(bool value)? onToggle,
    String svgPath = AppAssets.algeria,
    Function(BuildContext context)? onPressed,
    Widget? leading,
    TextStyle? kStyle,
    Widget? kTitle,
    Widget? kDescription,
  }) {
    switch (this) {
      case SettingsActions.navigation:
        return SettingsTile.navigation(
          leading: leading,
          enabled: enabled,
          description: kDescription ??
              ((description != null) ? Text(description) : null),
          title: Text(
            title,
            style: kStyle,
          ),
          onPressed: onPressed ??
              (context) {
                if (routeName != null) {
                  context.pushNamed(routeName);
                }
              },
        );
      case SettingsActions.switchTile:
        return SettingsTile.switchTile(
          leading: leading,
          enabled: enabled,
          description: kDescription ??
              ((description != null) ? Text(description) : null),
          initialValue: initialValue,
          onToggle: onToggle,
          title: kTitle ??
              Text(
                title,
                style: kStyle,
              ),
        );
      case SettingsActions.svg:
        return SettingsTile(
          enabled: enabled,
          leading: SvgPicture.asset(svgPath),
          description: kDescription ??
              ((description != null) ? Text(description) : null),
          title: kTitle ??
              Text(
                title,
                style: kStyle,
              ),
          onPressed: onPressed,
        );
      default:
        return SettingsTile(
          leading: leading,
          enabled: enabled,
          title: kTitle ??
              Text(
                title,
                style: kStyle,
              ),
          onPressed: onPressed,
          description: kDescription ??
              ((description != null) ? Text(description) : null),
        );
    }
  }
}
