//
//  UserImageDownloader.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/11/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "User.h"
#import "UserImageDownloader.h"

@implementation UserImageDownloader

@synthesize user;

#pragma mark - Initializer

- (id) initWithUser: (User *) userObject
{
  self = [super init];
  if (self) {
    self.user = userObject;
    imageURL  = [self.user imageURL];
  }
  return self;
}

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  self.user.image = [[UIImage alloc] initWithData: activeDownload];
  [super connectionDidFinishLoading: connection];
}

@end
