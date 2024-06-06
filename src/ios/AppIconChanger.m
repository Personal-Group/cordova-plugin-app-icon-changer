#import "Cordova/CDV.h"
#import "AppIconChanger.h"

@implementation AppIconChanger

- (void) isSupported:(CDVInvokedUrlCommand*)command
{
  CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:[self supportsAlternateIcons]];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) changeIcon:(CDVInvokedUrlCommand*)command
{
  if (![self supportsAlternateIcons]) {
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"This version of iOS doesn't support alternate icons"] callbackId:command.callbackId];
    return;
  }

  NSDictionary* options = command.arguments[0];
  NSString *iconName = options[@"iconName"];
  BOOL suppressUserNotification = (options[@"suppressUserNotification"] == nil || [options[@"suppressUserNotification"] boolValue]);

  if ([iconName isEqualToString:@""]) {
    iconName = nil;
  }

  [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError *error) {
      if (error != nil) {
        NSString *errMsg = error.localizedDescription;
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:errMsg] callbackId:command.callbackId];
      } else {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
      }
  }];


  if (suppressUserNotification) {
    [self suppressUserNotification];
  }
}

- (void)currentIconName:(CDVInvokedUrlCommand *)command 
{
    if ([self supportsAlternateIcons]) {
        NSString *iconName = [[UIApplication sharedApplication] alternateIconName] ?: @""; // account for null
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:iconName];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    } else {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Alternative icons not supported on this device"] callbackId:command.callbackId];
    }
}

- (void)getAppIcon:(CDVInvokedUrlCommand *)command 
{
	NSDictionary *options = command.arguments[0];
 	NSString *iconName = options[@"iconName"];
  NSString *path = [[NSBundle mainBundle] pathForResource:iconName ofType:@"png"];

  if (path) {
      NSData *data = [NSData dataWithContentsOfFile:path];
      if (data) {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArrayBuffer:data] callbackId:command.callbackId];
        return;
      }
  }
    
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Could not get requested icon"] callbackId:command.callbackId];
}
}

#pragma mark - Helper functions

- (BOOL) supportsAlternateIcons
{
    if (![[UIApplication sharedApplication] respondsToSelector:NSSelectorFromString(@"supportsAlternateIcons")]) {
        return NO;
    }
    return [[UIApplication sharedApplication] supportsAlternateIcons];
}

- (void) suppressUserNotification
{
  UIViewController* suppressAlertVC = [UIViewController new];
  [self.viewController presentViewController:suppressAlertVC animated:NO completion:^{
      [suppressAlertVC dismissViewControllerAnimated:NO completion: nil];
  }];
}

@end
