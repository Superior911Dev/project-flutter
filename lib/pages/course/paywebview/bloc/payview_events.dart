abstract class PayWebViewEvent {
  const PayWebViewEvent();
}

class TriggerWebView extends PayWebViewEvent {
  final String url;
  const TriggerWebView(this.url);
}
