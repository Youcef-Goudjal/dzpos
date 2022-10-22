import 'package:dzpos/application_layer/application_layer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../../product/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum AppTabs {
  invoices(InvoicesPage()),
  accounts(AccountsPage()),
  reports(ReportsPage()),
  settings(SettingsPage());

  const AppTabs(this.page);

  String get name {
    switch (this) {
      case AppTabs.invoices:
        return LocaleKeys.invoices.tr();
      case AppTabs.accounts:
        return LocaleKeys.Accounts.tr();
      case AppTabs.reports:
        return LocaleKeys.Reports.tr();
      case AppTabs.settings:
        return LocaleKeys.settings.tr();
    }
  }

  final Widget page;
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: AppTabs.values.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              snap: false,
              pinned: true,
              floating: true,
              title: const Text(StringConstants.title),
              bottom: TabBar(
                controller: _tabController,
                tabs: AppTabs.values.map((e) => Text(e.name)).toList(),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: AppTabs.values.map((e) => e.page).toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
