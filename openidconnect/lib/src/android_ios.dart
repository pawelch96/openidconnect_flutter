part of openidconnect;

class OpenIdConnectAndroidiOS {
  static Future<String> authorizeInteractive({
    required BuildContext context,
    required String title,
    required String authorizationUrl,
    required String redirectUrl,
    required bool usePopup,
    required bool isLoggedIn,
    required int popupWidth,
    required int popupHeight,
  }) async {
    //Create the url

    final result = await showDialog<String?>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              // min(popupWidth.toDouble(), MediaQuery.of(context).size.width),
              height: MediaQuery.of(context).size.height,
              // min(popupHeight.toDouble(), MediaQuery.of(context).size.height),
              child: isLoggedIn
                  ? flutterWebView.WebView(
                      javascriptMode:
                          flutterWebView.JavascriptMode.unrestricted,
                      initialUrl: authorizationUrl,
                      onPageFinished: (url) {
                        if (url.startsWith(redirectUrl)) {
                          Navigator.pop(dialogContext, url);
                        }
                      },
                      backgroundColor: Colors.transparent,
                    )
                  : flutterWebView.WebView(
                      javascriptMode:
                          flutterWebView.JavascriptMode.unrestricted,
                      initialUrl: authorizationUrl,
                      onPageFinished: (url) {
                        if (url.startsWith(redirectUrl)) {
                          Navigator.pop(dialogContext, url);
                        }
                      },
                      onWebViewCreated: (controller) {
                        controller.clearCache();
                        flutterWebView.CookieManager().clearCookies();
                      },
                      backgroundColor: Colors.transparent,
                    ),
            ),
          ),
        );
      },
    );

    if (result == null) throw AuthenticationException(ERROR_USER_CLOSED);

    return result;
  }
}
