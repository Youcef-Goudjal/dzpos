import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../core/core.dart';
import '../../../product/product.dart';
import '../../application_layer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, Map<String, dynamic>>> settings = {
      LocaleKeys.settings_General_Settings.tr(): {
        LocaleKeys.Display_System_information.tr(): {
          "type": SettingsActions.navigation,
          "routeName": "",
        },
        LocaleKeys.settings_Users_and_Permission_Settings.tr(): {
          "type": SettingsActions.navigation,
          "routeName": "",
        },
        LocaleKeys.settings_PassCode_Security_on_entry.tr(): {
          "type": SettingsActions.switchTile,
          "initialValue": false,
          "onToggle": (value) {}
        },
        LocaleKeys.settings_Always_backup_on_exit.tr(): {
          "type": SettingsActions.switchTile,
          "initialValue": StorageKeys.settingsAlwaysBackup.storedValue ?? false,
          "onToggle": (bool? value) {
            StorageKeys.settingsAlwaysBackup.setValue(value ?? false);
            setState(() {});
          },
        },
      },
      LocaleKeys.Language.tr(): {
        "العربية": {
          "type": SettingsActions.svg,
          "svgPath": AppAssets.algeria,
          "onPressed": (BuildContext context) {
            context.setLocale(const Locale("ar"));
          }
        },
        "English": {
          "type": SettingsActions.svg,
          "svgPath": AppAssets.usa,
          "onPressed": (BuildContext context) {
            context.setLocale(const Locale("en"));
          }
        },
        "Français": {
          "type": SettingsActions.svg,
          "svgPath": AppAssets.france,
          "onPressed": (BuildContext context) {
            context.setLocale(const Locale("fr"));
          }
        },
      },
      LocaleKeys.settingsTheme_Settings.tr(): {
        LocaleKeys.settings_theme.tr(): {
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
        LocaleKeys.settings_Theme_Mode.tr(): {
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
      LocaleKeys.settings_Print_Settings.tr(): {
        LocaleKeys.settings_Reporting_ComponentsLogo.tr(): {
          "type": SettingsActions.navigation,
          "routeName": AppRoutes.defaultPrint.name,
        },
        LocaleKeys.settings_Labels_in_print.tr(): {
          "type": SettingsActions.navigation,
          "routeName": AppRoutes.printLabels.name,
        },
        LocaleKeys.settings_Bluetooth_Printer_Settings.tr(): {
          "type": SettingsActions.navigation,
          "onPressed": (BuildContext context) {
            showPrinterSettings(context);
          },
        },
        LocaleKeys.settings_Choose_Printer_Model.tr(): {
          "type": SettingsActions.navigation,
          "routeName": "",
        },
        LocaleKeys.settings_Font_Size.tr(): {
          "type": SettingsActions.custom,
          "onPressed": (BuildContext context) {
            statusHandler(context, Status.failure,
                msg: LocaleKeys.Coming_soon.tr());
          },
          "title": Row(
            children: [
              Text(LocaleKeys.settings_Font_Size.tr()),
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
                child: Text(LocaleKeys.Save.tr()),
              )
            ],
          ),
        },
      },
      LocaleKeys.settings_Billing_Settings.tr(): {
        LocaleKeys.settings_Increase_the_quantity_of_the_product_in_the_invoice
            .tr(): {
          "type": SettingsActions.switchTile,
          "initialValue": StorageKeys.settingsAddQuantity.storedValue ?? false,
          "onToggle": (value) {
            StorageKeys.settingsAddQuantity.setValue(value ?? false);
            setState(() {});
          }
        },
        LocaleKeys.settings_useBox.tr(): {
          "type": SettingsActions.switchTile,
          "initialValue": StorageKeys.settingsUseBox.storedValue ?? false,
          "onToggle": (value) {
            StorageKeys.settingsUseBox.setValue(value ?? false);
            setState(() {});
          }
        },
        LocaleKeys.settings_Update_all_unitsOnce.tr(): {
          "type": SettingsActions.switchTile,
          "initialValue":
              StorageKeys.settingsUpdateAllUnitsInInvoice.storedValue ?? false,
          "onToggle": (value) {
            StorageKeys.settingsUpdateAllUnitsInInvoice
                .setValue(value ?? false);
            setState(() {});
          }
        },
        LocaleKeys.settings_Selling_at_less_than_cost.tr(): {
          "type": SettingsActions.switchTile,
          "initialValue":
              StorageKeys.settingsSellLestThanCost.storedValue ?? false,
          "onToggle": (value) {
            StorageKeys.settingsSellLestThanCost.setValue(value ?? false);
            setState(() {});
          }
        },
        LocaleKeys.settings_Activate_minimum_quantities_alert.tr(): {
          "type": SettingsActions.switchTile,
          "initialValue":
              StorageKeys.settingsActivateNotificationOfQuantity.storedValue ??
                  false,
          "onToggle": (value) {
            StorageKeys.settingsActivateNotificationOfQuantity
                .setValue(value ?? false);
            setState(() {});
          }
        },
        LocaleKeys.settings_Allow_selling_while_stocks_last.tr(): {
          "type": SettingsActions.switchTile,
          "initialValue":
              StorageKeys.settingsAllowSellWhenQuantityIsZero.storedValue ??
                  false,
          "onToggle": (value) {
            StorageKeys.settingsAllowSellWhenQuantityIsZero
                .setValue(value ?? false);
            setState(() {});
          }
        },
        LocaleKeys
            .settings_Separate_customers_and_suppliers_accounts_in_invoices
            .tr(): {
          "type": SettingsActions.switchTile,
          "initialValue": StorageKeys
                  .settingsSeparateBetweenCustomersAndSuppliers.storedValue ??
              false,
          "onToggle": (value) {
            StorageKeys.settingsSeparateBetweenCustomersAndSuppliers
                .setValue(value ?? false);
            setState(() {});
          }
        },
        LocaleKeys.settings_Open_the_list_of_items_on_sale_immediately.tr(): {
          "type": SettingsActions.switchTile,
          "initialValue":
              StorageKeys.settingsOpenSellInvoicesOnStart.storedValue ?? false,
          "onToggle": (value) {
            StorageKeys.settingsOpenSellInvoicesOnStart
                .setValue(value ?? false);
            setState(() {});
          }
        },
        LocaleKeys.settings_The_default_billing_accounts_is_General_Customer
            .tr(): {
          "type": SettingsActions.switchTile,
          "initialValue":
              StorageKeys.settingsDefaultIsGeneralCustomer.storedValue ?? false,
          "onToggle": (value) {
            StorageKeys.settingsDefaultIsGeneralCustomer
                .setValue(value ?? false);
            setState(() {});
          }
        },
        LocaleKeys.settings_Show_items_frozen_in_the_new_invoice.tr(): {
          "type": SettingsActions.switchTile,
          "initialValue":
              StorageKeys.settingsShowFrozenProducts.storedValue ?? false,
          "onToggle": (value) {
            StorageKeys.settingsShowFrozenProducts.setValue(value ?? false);
            setState(() {});
          }
        },
        LocaleKeys.settings_Display_frozen_accounts_in_new_invoices.tr(): {
          "type": SettingsActions.switchTile,
          "initialValue":
              StorageKeys.settingsShowFrozenAccounts.storedValue ?? false,
          "onToggle": (value) {
            StorageKeys.settingsShowFrozenAccounts.setValue(value ?? false);
            setState(() {});
          }
        },
      },
      LocaleKeys.settings_Maintenance.tr(): {
        "Repair invoices": {
          "type": SettingsActions.custom,
          "onPressed": (BuildContext context) {
            statusHandler(context, Status.failure,
                msg: LocaleKeys.Coming_soon.tr());
          }
        },
        LocaleKeys.settings_Fix_Permissions.tr(): {
          "type": SettingsActions.custom,
          "onPressed": (BuildContext context) {
            statusHandler(context, Status.failure,
                msg: LocaleKeys.Coming_soon.tr());
          }
        },
        LocaleKeys.settings_Modify_and_manage_Databases.tr(): {
          "type": SettingsActions.custom,
          "leading": Icon(
            Icons.dangerous,
            color: context.error,
          ),
          "kStyle": context.textTheme.titleMedium!.copyWith(
            color: context.error,
          ),
          "onPressed": (BuildContext context) {
            statusHandler(context, Status.failure,
                msg: LocaleKeys.Coming_soon.tr());
          }
        },
        LocaleKeys.SignOut.tr(): {
          "type": SettingsActions.custom,
          "leading": Icon(
            Icons.logout,
            color: context.error,
          ),
          "kStyle": context.textTheme.titleMedium!.copyWith(
            color: context.error,
          ),
          "onPressed": (BuildContext context) {
            CommonBloc.authBloc.add(SignOutRequested(
                CommonBloc.applicationBloc.application.deviceId));
          },
        },
      }
    };
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
                if (routeName != null && routeName != "") {
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
