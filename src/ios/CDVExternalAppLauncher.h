#import <Cordova/CDVPlugin.h>

@interface CDVExternalAppLauncher : CDVPlugin <UIAlertViewDelegate>

- (void)launch:(CDVInvokedUrlCommand *)command;

@end
