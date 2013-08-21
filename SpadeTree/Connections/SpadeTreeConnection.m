//
//  SpadeTreeConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeConnection.h"
#import "SpadeTreeViewController.h"

NSTimeInterval RequestTimeoutInterval = 10;
NSMutableArray *sharedConnectionList  = nil;
NSString *const SpadeTreeApiURL = @"https://spadetree.herokuapp.com";

@implementation SpadeTreeConnection

@synthesize completionBlock;
@synthesize createdAt;
@synthesize delegate;
@synthesize request;
@synthesize viewController;

#pragma mark - Initializer

- (id) init
{
  return [self initWithRequest: nil];
}

- (id) initWithRequest: (NSURLRequest *) req
{
  self = [super init];
  if (self) {
    self.createdAt = [[NSDate date] timeIntervalSince1970];
    self.request   = req;
  }
  return self;
}

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connection: (NSURLConnection *) connection
didReceiveData: (NSData *) data
{
  [container appendData: data];
}

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  if (self.completionBlock) {
    self.completionBlock(nil);
  }
  [sharedConnectionList removeObject: self];
  NSMutableArray *connectionsToRemove = [NSMutableArray array];
  for (SpadeTreeConnection *spadeTreeConnection in sharedConnectionList) {
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    if (now - spadeTreeConnection.createdAt > 5) {
      [spadeTreeConnection cancelConnection];
      [connectionsToRemove addObject: spadeTreeConnection];
    }
  }
  for (SpadeTreeConnection *spadeTreeConnection in connectionsToRemove) {
    [sharedConnectionList removeObject: spadeTreeConnection];
  }
  if (sharedConnectionList.count == 0) {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  }
}

#pragma mark - Protocol NSURLConnectionDelegate

- (void) connection: (NSURLConnection *) connection
didFailWithError: (NSError *) error
{
  if (self.completionBlock) {
    self.completionBlock(error);
  }
  [sharedConnectionList removeObject: self];
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - Methods

- (void) cancelConnection
{
  [internalConnection cancel];
}

- (void) setRequestFromString: (NSString *) requestString
{
  NSURL *url = [NSURL URLWithString:
    [requestString stringByAddingPercentEscapesUsingEncoding:
      NSUTF8StringEncoding]];
  NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
  [req setTimeoutInterval: RequestTimeoutInterval];
  self.request = req;
}

- (void) start
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  container = [[NSMutableData alloc] init];
  internalConnection = [[NSURLConnection alloc] initWithRequest: self.request
    delegate: self startImmediately: YES];
  if (!sharedConnectionList) {
    sharedConnectionList = [NSMutableArray array];
  }
  [sharedConnectionList addObject: self];
}

@end
