import 'package:alice/alice.dart';
import 'package:alice_chopper/alice_chopper_adapter.dart';

class AliceFactory {
  static final AliceFactory _instance = AliceFactory._();
  factory AliceFactory() => _instance;

  AliceFactory._();

  static Alice? _alice;
  static AliceChopperAdapter? _aliceChopperAdapter;

  Alice get alice {
    if (_alice != null) return _alice!;
    _alice = Alice(
      showInspectorOnShake: true,
      showNotification: true,
      showShareButton: true,
    );
    return _alice!;
  }

  AliceChopperAdapter get aliceChopperAdapter {
    if (_aliceChopperAdapter != null) return _aliceChopperAdapter!;
    _aliceChopperAdapter = AliceChopperAdapter();
    return _aliceChopperAdapter!;
  }
}
