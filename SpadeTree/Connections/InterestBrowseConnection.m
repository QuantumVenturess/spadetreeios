//
//  InterestBrowseConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/9/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "BrowseInterestStore.h"
#import "InterestBrowseConnection.h"
#import "SpadeTreeTableViewController.h"

@implementation InterestBrowseConnection

#pragma mark - Initializer

- (id) initWithPage: (int) page
{
  self = [super init];
  if (self) {
    NSString *requestString = [NSString stringWithFormat: 
      @"%@/i/browse.json/?"
      @"spadetree_token=%@&"
      @"p=%i",
      SpadeTreeApiURL, [User currentUser].appToken, page];
    [self setRequestFromString: requestString];
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
  [[BrowseInterestStore sharedStore] readFromDictionary: json];
  [super connectionDidFinishLoading: connection];
}

@end
