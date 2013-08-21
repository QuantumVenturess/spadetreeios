//
//  SpadeTreeConnection.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

extern NSTimeInterval RequestTimeoutInterval;
extern NSMutableArray *sharedConnectionList;
extern NSString *const SpadeTreeApiURL;

@class SpadeTreeViewController;

@interface SpadeTreeConnection : NSURLConnection
{
  NSMutableData *container;
  NSURLConnection *internalConnection;
}

@property (nonatomic, copy) void (^completionBlock) (NSError *error);
@property (nonatomic) NSTimeInterval createdAt;
@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, weak) SpadeTreeViewController *viewController;

#pragma mark - Initializer

- (id) initWithRequest: (NSURLRequest *) req;

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection;

#pragma mark - Protocol NSURLConnectionDelegate

- (void) connection: (NSURLConnection *) connection
didFailWithError: (NSError *) error;

#pragma mark - Methods

- (void) cancelConnection;
- (void) setRequestFromString: (NSString *) requestString;

@end
