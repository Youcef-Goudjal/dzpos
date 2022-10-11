import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/database.dart';

class AccountsListPage extends StatefulWidget {
  const AccountsListPage({super.key});

  @override
  State<AccountsListPage> createState() => _AccountsListPageState();
}

class _AccountsListPageState extends State<AccountsListPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountsListCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: context.read<AccountsListCubit>().refresh,
            child: const Icon(Icons.refresh),
          ),
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    title: const Text("Accounts List"),
                    actions: [
                      BlocBuilder<AccountsListCubit, AccountsListState>(
                        builder: (context, state) {
                          return IconButton(
                            onPressed: () {
                              showSearch(
                                context: context,
                                delegate: AccountsSearchDelegate([
                                  ...state.accounts,
                                ]),
                              );
                            },
                            icon: const Icon(Icons.search),
                          );
                        },
                      ),
                    ],
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(
                          text: "Customer",
                        ),
                        Tab(
                          text: "Supplier",
                        )
                      ],
                    ),
                  ),
                ];
              },
              body: _AccountsListBody(tabController: _tabController)),
        );
      }),
    );
  }
}

class _AccountsListBody extends StatelessWidget {
  const _AccountsListBody({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: const [
        _CustomersList(),
        _SuppliersList(),
      ],
    );
  }
}

class _SuppliersList extends StatelessWidget {
  const _SuppliersList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                context
                    .read<AccountsListCubit>()
                    .importFromContactsAccounts(context, AccountType.supplier);
              },
              child: const Center(child: Text("Import Suppliers")),
            ),
          ),
          Expanded(
            child: BlocBuilder<AccountsListCubit, AccountsListState>(
                builder: (context, state) {
              final suppliers = state.accounts
                  .where(
                      (element) => element.accountType == AccountType.supplier)
                  .toList();
              if (suppliers.isEmpty) {
                return const Center(
                  child: Text("No Supplier found"),
                );
              }
              return ListView.builder(
                itemCount: suppliers.length,
                itemBuilder: (context, index) {
                  final element = suppliers[index];
                  return ListTile(
                    title: Text(element.name),
                    subtitle: Text("Phone : ${element.contact}"),
                  );
                },
              );
            }),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.theme.colorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Number of results:  ",
                  style: TextStyle(
                    color: context.theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                BlocBuilder<AccountsListCubit, AccountsListState>(
                  builder: (context, state) {
                    final suppliers = state.accounts
                        .where((element) =>
                            element.accountType == AccountType.supplier)
                        .toList();
                    return Text(
                      "${suppliers.length}",
                      style: TextStyle(
                        color: context.theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomersList extends StatelessWidget {
  const _CustomersList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                context
                    .read<AccountsListCubit>()
                    .importFromContactsAccounts(context, AccountType.customer);
              },
              child: const Center(child: Text("Import Customers")),
            ),
          ),
          Expanded(
            child: BlocBuilder<AccountsListCubit, AccountsListState>(
                buildWhen: (previous, current) =>
                    previous.accounts != current.accounts,
                builder: (context, state) {
                  final customers = state.accounts
                      .where((element) =>
                          element.accountType == AccountType.customer)
                      .toList();
                  if (customers.isEmpty) {
                    return const Center(
                      child: Text("No customer found"),
                    );
                  }
                  return ListView.builder(
                    itemCount: customers.length,
                    itemBuilder: (context, index) {
                      final element = state.accounts[index];
                      return ListTile(
                        title: Text(element.name),
                        subtitle: Text("Phone : ${element.contact}"),
                      );
                    },
                  );
                }),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.theme.colorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Number of results:  ",
                  style: TextStyle(
                    color: context.theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                BlocBuilder<AccountsListCubit, AccountsListState>(
                  buildWhen: (previous, current) =>
                      previous.accounts != current.accounts,
                  builder: (context, state) {
                    final customers = state.accounts
                        .where((element) =>
                            element.accountType == AccountType.supplier)
                        .toList();
                    return Text(
                      "${customers.length}",
                      style: TextStyle(
                        color: context.theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AccountsSearchDelegate extends SearchDelegate {
  List<Account> accounts;
  AccountsSearchDelegate(this.accounts);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
          }
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final selectedAccount = accounts[selectedIndex];

    return NewAccountPage(
      account: selectedAccount,
    );
  }

  int selectedIndex = 0;
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = accounts.where((element) {
      if (element.code?.contains(query) ?? false) {
        return true;
      } else if (element.name.contains(query)) {
        return true;
      } else if (element.contact?.contains(query) ?? false) {
        return true;
      }
      return false;
    });
    return ListView.builder(
      itemCount: query.isEmpty ? accounts.length : suggestions.length,
      itemBuilder: (context, index) {
        final element =
            query.isEmpty ? accounts[index] : suggestions.elementAt(index);

        return ListTile(
          title: Text(element.name),
          subtitle: Text("Phone : ${element.contact}"),
          onTap: () {
            selectedIndex = index;
            showResults(context);
          },
        );
      },
    );
  }
}
