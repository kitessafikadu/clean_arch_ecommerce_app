abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // Simulate network status (replace with actual implementation)
    return Future.value(true); // Change to `false` for offline testing
  }
}
