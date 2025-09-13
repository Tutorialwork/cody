import 'dart:async';

import 'package:cody/constants/list_constants.dart';
import 'package:cody/constants/style_constants.dart';
import 'package:cody/models/account.dart';
import 'package:cody/models/account_data_result.dart';
import 'package:cody/models/context_menu_opener.dart';
import 'package:cody/blocs/totp/totp_bloc.dart';
import 'package:cody/services/accounts_data_service.dart';
import 'package:cody/widgets/expiration_counter.dart';
import 'package:cody/widgets/loading.dart';
import 'package:cody/widgets/no_accounts.dart';
import 'package:cody/widgets/page_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CodesPage extends StatefulWidget {
  const CodesPage({super.key});

  @override
  State<CodesPage> createState() => _CodesPageState();
}

class _CodesPageState extends State<CodesPage> with WidgetsBindingObserver {

  late final Timer codesTimer;

  final AccountsDataService dataService = GetIt.I<AccountsDataService>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    dataService.cleanupLocalCodes();
    dataService.fetchNewData(_onDataLoaded);
    dataService.updateStream.stream.listen((_) => _onUpdateEvent());
    codesTimer = _startCountdownTimer();

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    codesTimer.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      dataService.fetchNewData(_onDataLoaded);
    }
  }

  void _onUpdateEvent() {
    setState(() {
      dataService.isLoadingData = true;
    });

    dataService.fetchNewData(_onDataLoaded, noLocalData: true);
    _updateUI();
  }

  void _onDataLoaded(AccountDataResult dataResult) {
    dataResult.fetchedAccounts.sort((Account a, Account b) => a.provider.compareTo(b.provider));

    List<TotpBloc> totpAccounts = List.empty(growable: true);
    dataResult.fetchedAccounts.forEach((Account account) => totpAccounts.add(dataService.convertAccountToBloc(account)));

    dataService.accounts = totpAccounts;
    dataService.isLoadingData = false;
    _updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: mediumSize),
      child: Column(
        children: [
          PageTitle(
              title: 'Codes'
          ),
          dataService.accounts.isNotEmpty ? ExpirationCounter(progress: _getCurrentSeconds(dataService.accounts.first) / 30 * 100, secondsRemaining: _getCurrentSeconds(dataService.accounts.first),) : Container(),
          const SizedBox(height: mediumSize,),
          _getContentWidget()
        ],
      ),
    );
  }

  Widget _getContentWidget() {
    if (dataService.isLoadingData) {
      return Expanded(
          child: Loading()
      );
    }

    if (dataService.accounts.isEmpty) {
      return Expanded(
          child: NoAccounts()
      );
    }

    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          crossAxisSpacing: smallSize,
          mainAxisSpacing: smallSize,
          childAspectRatio: 1.25,
        ),
        itemCount: dataService.accounts.length,
        itemBuilder: (BuildContext buildContext, int index) {
          TotpBloc bloc = dataService.accounts[index];
          TotpCodeGenerated state = dataService.accounts[index].state as TotpCodeGenerated;

          return Padding(
              padding: const EdgeInsets.all(xSmallSize),
              child: _getContextMenu(context, state, bloc)
          );
        },
      ),
    );
  }

  Widget _getContextMenu(BuildContext context, TotpCodeGenerated state, TotpBloc bloc) {
    ContextMenuOpener opener = ListsConstants.contextMenuOpeners.where((ContextMenuOpener opener) => opener.isPlatformMatching()).toList().first;
    return opener.getContextMenuWidget(context, state, bloc);
  }

  int _getCurrentSeconds(TotpBloc totpBloc) {
    if (totpBloc.state is! TotpCodeGenerated) {
      return 0;
    }
    TotpCodeGenerated totpCodeGenerated = totpBloc.state as TotpCodeGenerated;
    return _convertToSeconds(totpCodeGenerated.expiresAt);
  }

  int _convertToSeconds(DateTime expiresAt) {
    return expiresAt.difference(DateTime.now()).inSeconds;
  }

  Future<void> _generateCodes() async {
    dataService.accounts.forEach((TotpBloc totpBloc) {
      setState(() {
        totpBloc.add(GenerateTotpCode());
      });
    });
  }

  void _updateUI() {
    if (mounted) {
      setState(() {

      });
    }
  }

  Timer _startCountdownTimer() {
    return Timer.periodic(const Duration(seconds: 1), (Timer timer) => _generateCodes());
  }

}

