#import <WebKit/WebKit.h>
#import <objc/runtime.h>

void setup_webview_media(void *webview_ptr) {
    WKWebView *webView = (__bridge WKWebView *)webview_ptr;

    webView.customUserAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36";

    id<WKUIDelegate> delegate = webView.UIDelegate;
    SEL selector = @selector(webView:requestMediaCapturePermissionForOrigin:initiatedByFrame:type:decisionHandler:);

    if (![delegate respondsToSelector:selector]) {
        Class delegateClass = [delegate class];
        class_addMethod(delegateClass, selector, imp_implementationWithBlock(^(id _self, WKWebView *_wv, WKSecurityOrigin *_origin, WKFrameInfo *_frame, WKMediaCaptureType _type, void (^decisionHandler)(WKPermissionDecision)) {
            decisionHandler(WKPermissionDecisionGrant);
        }), "v@:@@@q@?");
    }
}
