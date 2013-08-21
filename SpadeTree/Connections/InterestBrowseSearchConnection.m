//
//  InterestBrowseSearchConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AllInterestStore.h"
#import "BrowseInterestStore.h"
#import "InterestBrowseSearchConnection.h"

NSMutableArray *browseSearchConnectionList = nil;

@implementation InterestBrowseSearchConnection

#pragma mark - Initializer

- (id) initWithTerm: (NSString *) term
{
  self = [super init];
  if (self) {
    NSString *requestString = [NSString stringWithFormat:
      @"%@/i/browse/search.json/?"
      @"spadetree_token=%@&"
      @"q=%@",
      SpadeTreeApiURL, [User currentUser].appToken, term];
    [self setRequestFromString: requestString];
  }
  return self;
}

#pragma mark - Override SpadeTreeConnection

- (void) start
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  container = [[NSMutableData alloc] init];
  internalConnection = [[NSURLConnection alloc] initWithRequest: self.request
    delegate: self startImmediately: NO];
  if (!browseSearchConnectionList) {
    browseSearchConnectionList = [NSMutableArray array];
  }
  for (InterestBrowseSearchConnection *conn in browseSearchConnectionList) {
    [conn cancelConnection];
  }
  for (InterestBrowseSearchConnection *conn in browseSearchConnectionList) {
    [browseSearchConnectionList removeObject: conn];
  }
  [browseSearchConnectionList addObject: self];
  [internalConnection start];
}

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  [[AllInterestStore sharedStore] readFromDictionary: json];
  // [[BrowseInterestStore sharedStore].interests removeAllObjects];
  // [[BrowseInterestStore sharedStore] readFromDictionary: json];
  [browseSearchConnectionList removeObject: self];
  [super connectionDidFinishLoading: connection];
}

#pragma mark - Protocol NSURLConnectionDelegate

- (void) connection: (NSURLConnection *) connection
didFailWithError: (NSError *) error
{
  [browseSearchConnectionList removeObject: self];
  [super connection: connection didFailWithError: error];
}

@end
