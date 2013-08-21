//
//  NotificationsCountConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/6/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"
#import "NotificationsCountConnection.h"

@implementation NotificationsCountConnection

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    NSString *string = [NSString stringWithFormat:
      @"%@/n/count.json/?spadetree_token=%@",
        SpadeTreeApiURL, [User currentUser].appToken];
    [self setRequestFromString: string];
  }
  return self;
}

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  MenuViewController *menu = appDelegate.menu;
  int count;
  if ([json objectForKey: @"count"] != [NSNull null]) {
    count = [[json objectForKey: @"count"] integerValue];
  }
  else {
    count = 0;
  }
  if (count == 0) {
    menu.notificationsCount.text = @"";
  }
  else {
    menu.notificationsCount.text = [NSString stringWithFormat: @"%i", count];
  }
  [super connectionDidFinishLoading: connection]; 
}

@end
