import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                                  ...state.customers,
                                  ...state.suppliers,
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
                    .importFromContactsSuppliers(context);
              },
              child: const Center(child: Text("Import Suppliers")),
            ),
          ),
          Expanded(
            child: BlocBuilder<AccountsListCubit, AccountsListState>(
                buildWhen: (previous, current) =>
                    previous.suppliers != current.suppliers,
                builder: (context, state) {
                  if (state.suppliers.isEmpty) {
                    return const Center(
                      child: Text("No Supplier found"),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.suppliers.length,
                    itemBuilder: (context, index) {
                      final element = state.suppliers[index];
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
                      previous.suppliers != current.suppliers,
                  builder: (context, state) {
                    return Text(
                      "${state.suppliers.length}",
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
                    .importFromContactsCustomers(context);
              },
              child: const Center(child: Text("Import Customers")),
            ),
          ),
          Expanded(
            child: BlocBuilder<AccountsListCubit, AccountsListState>(
                buildWhen: (previous, current) =>
                    previous.customers != current.customers,
                builder: (context, state) {
                  if (state.customers.isEmpty) {
                    return const Center(
                      child: Text("No customer found"),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.customers.length,
                    itemBuilder: (context, index) {
                      final element = state.customers[index];
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
                      previous.customers != current.customers,
                  builder: (context, state) {
                    return Text(
                      "${state.customers.length}",
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
  List<dynamic> accounts;
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
    if (selectedIndex is Customer) {
      return NewAccountPage(
        customer: selectedAccount,
      );
    }
    return NewAccountPage(
      supplier: selectedAccount,
    );
  }

  int selectedIndex = 0;
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = accounts.where((element) {
      return (element.name.contains(query) ||
          element.code.contains(query) ||
          element.contact.contains(query));
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
