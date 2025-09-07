import 'package:flutter/cupertino.dart';

import '../blocs/totp/totp_bloc.dart';

abstract class ContextMenuOpener {

  bool isPlatformMatching();

  Widget getContextMenuWidget(BuildContext context, TotpCodeGenerated state, TotpBloc bloc);

}