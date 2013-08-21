//
//  ImageDownloader.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/11/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

@synthesize completionBlock;

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connection: (NSURLConnection *) connection
didReceiveData: (NSData *) data
{
  [activeDownload appendData: data];
}

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  [self cancelDownload];
  if (self.completionBlock) {
    self.completionBlock(nil);
  }
}

#pragma mark - Protocol NSURLConnectionDelegate

- (void) connection: (NSURLConnection *) connection
didFailWithError: (NSError *) error
{
  [self cancelDownload];
  if (self.completionBlock) {
    self.completionBlock(error);
  }
}

#pragma mark - Methods

- (void) cancelDownload
{
  [imageConnection cancel];
  activeDownload  = nil;
  imageConnection = nil;
}

- (void) startDownload
{
  activeDownload  = [NSMutableData data];
  imageConnection = [[NSURLConnection alloc] initWithRequest: 
    [NSURLRequest requestWithURL: imageURL] delegate: self 
      startImmediately: YES];
}

@end
