#import <Cordova/CDVPlugin.h>

@interface AppIconChanger : CDVPlugin

- (void)isSupported:(CDVInvokedUrlCommand *)command;
- (void)changeIcon:(CDVInvokedUrlCommand *)command;
- (void)currentIconName:(CDVInvokedUrlCommand *)command;
- (void)getAppIcon:(CDVInvokedUrlCommand *)command;
- (void)getAlternativeAppIconNames:(CDVInvokedUrlCommand *)command;
- (void)getAlternativeAppIconByName:(CDVInvokedUrlCommand *)command;

@end
