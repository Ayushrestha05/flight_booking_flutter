enum NetworkState { initial, loading, loaded, error }

String baseNetworkUrl = "http://192.168.1.73:8000/api";
String baseServerUrl = baseNetworkUrl.substring(0, baseNetworkUrl.length - 4);
