import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // چاپ تغییرات State
    print('🔄 ${bloc.runtimeType} changed: ${change.nextState}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // چاپ Eventهایی که ارسال میشن
    print('🚀 ${bloc.runtimeType} received event: ${event.runtimeType}');
  }
}
