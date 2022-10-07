import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/manager/theme/theme_manager.dart';
import 'package:dzpos/product/product.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      physics: const BouncingScrollPhysics(),
      platform: DevicePlatform.android,
      lightTheme: SettingsThemeData(
        settingsListBackground: context.theme.backgroundColor,
        dividerColor: context.theme.dividerColor,
        settingsSectionBackground: context.theme.cardColor,
      ),
      sections: [
        SettingsSection(
          title: const Text("General Settings"),
          margin: EdgeInsetsDirectional.all(15.w),
          tiles: [
            SettingsTile.navigation(
              title: const Text("Display System information"),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: (context) {},
            ),
            SettingsTile.navigation(
              title: const Text("Users and Permission Settings"),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: (context) {},
            ),
            SettingsTile.switchTile(
              initialValue: false,
              onToggle: (value) {},
              title: const Text("PassCode security on entry"),
            ),
            SettingsTile.switchTile(
              initialValue: true,
              onToggle: (value) {},
              title: const Text("Always backup on exit"),
            ),
          ],
        ),
        SettingsSection(
          title: const Text("Language"),
          tiles: [
            SettingsTile(
              leading: SvgPicture.asset(AppAssets.algeria),
              title: const Text("العربية"),
              onPressed: (context) {},
            ),
            SettingsTile(
              leading: SvgPicture.asset(AppAssets.usa),
              title: const Text("English"),
              onPressed: (context) {},
            ),
            SettingsTile(
              leading: SvgPicture.asset(AppAssets.france),
              title: const Text("Français"),
              onPressed: (context) {},
            ),
          ],
        ),
        SettingsSection(
          title: const Text("Theme Settings"),
          tiles: [
            SettingsTile(
              title: DropdownButton(
                isExpanded: true,
                value: ThemeManager.instance.defaultFlexScheme,
                items: FlexScheme.values
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
            ),
            SettingsTile.switchTile(
              initialValue: ThemeManager.instance.defaultThemeMode.index == 0,
              onToggle: (value) {},
              title: const Text("Theme Mode"),
            ),
          ],
        ),
        SettingsSection(
          title: const Text("Print Settings"),
          tiles: [
            SettingsTile.navigation(
              title: const Text("Reporting Componrnts + Logo"),
              onPressed: (context) {},
            ),
            SettingsTile.navigation(
              title: const Text("Labels in print"),
              onPressed: (context) {},
            ),
            SettingsTile.navigation(
              title: const Text("Bluetooth Printer Settings"),
              onPressed: (context) {},
            ),
            SettingsTile.navigation(
              title: const Text("Choose Printer Model"),
              onPressed: (context) {},
            ),
            SettingsTile(
              title: Row(
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
            ),
          ],
        ),
        SettingsSection(
          title: const Text("Billing settings"),
          tiles: [
            SettingsTile.switchTile(
              initialValue: false,
              onToggle: (value) {},
              title: const Text(
                  "Increase the quantity of the product in the invoice"),
            ),
            SettingsTile.switchTile(
              initialValue: false,
              onToggle: (value) {},
              title: const Text("Selling at less than cost"),
            ),
            SettingsTile.switchTile(
              initialValue: false,
              onToggle: (value) {},
              title: const Text("Activate minimum quantities alert"),
            ),
            SettingsTile.switchTile(
              initialValue: false,
              onToggle: (value) {},
              title: const Text("Allow selling while stocks last"),
            ),
            SettingsTile.switchTile(
              initialValue: false,
              onToggle: (value) {},
              title: const Text(
                  "Separate customer and supplier accounts in invoices"),
            ),
            SettingsTile.switchTile(
              initialValue: false,
              onToggle: (value) {},
              title: const Text("Open the list of items on sale immediately"),
            ),
            SettingsTile.switchTile(
              initialValue: false,
              onToggle: (value) {},
              title: const Text(
                  "The default billing accounts is General Customer"),
            ),
            SettingsTile.switchTile(
              initialValue: false,
              onToggle: (value) {},
              title: const Text("Show items frozen in new invoices"),
            ),
            SettingsTile.switchTile(
              initialValue: false,
              onToggle: (value) {},
              title: const Text("Display frozen accounts in new invoices"),
            ),
          ],
        ),
        SettingsSection(
          title: const Text("Maintenance"),
          tiles: [
            SettingsTile(
              title: const Text("Repair invoices"),
              onPressed: (context) {},
            ),
            SettingsTile(
              title: const Text("Fix permissions"),
              onPressed: (context) {},
            ),
            SettingsTile.navigation(
              title: Text(
                "Modify and manage databases",
                style: TextStyle(
                  color: context.theme.errorColor,
                ),
              ),
              onPressed: (context) {},
            ),
            SettingsTile(
              title: Text(
                "SignOut",
                style: TextStyle(
                  color: context.theme.errorColor,
                ),
              ),
              onPressed: (context) {},
            ),
          ],
        )
      ],
    );
  }
}
