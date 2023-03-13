part of openidconnect;

class OpenIdConnectAndroidiOS {
  static Future<String> authorizeInteractive({
    required BuildContext context,
    required String title,
    required String authorizationUrl,
    required String redirectUrl,
    required bool usePopup,
    required int popupWidth,
    required int popupHeight,
  }) async {
    //Create the url

    final result = await showDialog<String?>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          insetPadding:
              // usePopup
              // ?
              EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          // : EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
          // actions: [
          //   IconButton(
          //     onPressed: () => Navigator.pop(dialogContext, null),
          //     icon: Icon(Icons.close),
          //   ),
          // ],
          content: Container(
            width:
                min(popupWidth.toDouble(), MediaQuery.of(context).size.width),
            height:
                min(popupHeight.toDouble(), MediaQuery.of(context).size.height),
            child: flutterWebView.WebView(
              javascriptMode: flutterWebView.JavascriptMode.unrestricted,
              initialUrl: authorizationUrl,
              onPageFinished: (url) {
                if (url.startsWith(redirectUrl)) {
                  Navigator.pop(dialogContext, url);
                }
              },
            ),
          ),
          // title: Text(title),
        );
      },
    );

    if (result == null) throw AuthenticationException(ERROR_USER_CLOSED);

    return result;
  }
}
