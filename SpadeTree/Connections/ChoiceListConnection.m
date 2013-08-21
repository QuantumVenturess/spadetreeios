//
//  ChoiceListConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/1/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "ChoiceListConnection.h"
#import "ChoiceListStore.h"
#import "SpadeTreeTableViewController.h"

@implementation ChoiceListConnection

#pragma mark - Initializer

- (id) initWithPage: (int) page
{
  self = [super init];
  if (self) {
    NSString *string = [NSString stringWithFormat:
      @"%@/c/requests.json/?"
      @"spadetree_token=%@&"
      @"p=%i",
      SpadeTreeApiURL, [User currentUser].appToken, page];
    [self setRequestFromString: string];
  }
  return self;
}

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  int maxPages = [[json objectForKey: @"pages"] integerValue];
  if (maxPages == 0) {
    maxPages = 1;
  }
  [(SpadeTreeTableViewController *) self.viewController setMaxPages: maxPages];
  [[ChoiceListStore sharedStore] readFromDictionary: json];
  [super connectionDidFinishLoading: connection];
}

@end
