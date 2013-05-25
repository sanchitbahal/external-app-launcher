#import "CDVExternalAppLauncher.h"
#import "NSArray+Comparisons.h"

@implementation CDVExternalAppLauncher
NSURL *defaultStoreUrl = nil;

- (void)launch:(CDVInvokedUrlCommand *)command {
    NSString *appUrlScheme = [command.arguments objectAtIndex:0];
    NSString *appStoreUrl = [command.arguments objectAtIndex:1];
    NSString *alertMessage = [command.arguments objectAtIndex:2];
    NSString *alertType = [command.arguments objectAtIndex:3 withDefault:@"Ok"];
    NSURL *appUrl = [NSURL URLWithString:appUrlScheme];

    if (![appStoreUrl isEqualToString:@""])
        defaultStoreUrl = [NSURL URLWithString:appStoreUrl];

    if ([[UIApplication sharedApplication] canOpenURL:appUrl]) {
        [[UIApplication sharedApplication] openURL:appUrl];
        return;
    }

    [self alertUserWith:alertType andMessage:alertMessage];
}

- (void)alertUserWith:(NSString *)alertType andMessage:(NSString *)alertMessage {
    UIAlertView *alertView;
    NSString *title = @"App Not Found";

    if ([alertType isEqualToString:@"OkCancel"]) {
        alertView = [[UIAlertView alloc]
                initWithTitle:title
                      message:alertMessage
                     delegate:self
            cancelButtonTitle:@"OK"
            otherButtonTitles:@"CANCEL", nil];
    }
    else {
        alertView = [[UIAlertView alloc]
                initWithTitle:title
                      message:alertMessage
                     delegate:self
            cancelButtonTitle:@"OK"
            otherButtonTitles:nil];
    }

    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *selectedValue = [alertView buttonTitleAtIndex:buttonIndex];
    if ([selectedValue isEqualToString:@"OK"] && defaultStoreUrl != nil) {
        [[UIApplication sharedApplication] openURL:defaultStoreUrl];
    }
}
@end
