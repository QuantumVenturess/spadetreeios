//
//  ImageDownloader.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/11/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDownloader : NSObject
{
  NSMutableData *activeDownload;
  NSURLConnection *imageConnection;
  NSURL *imageURL;
}

@property (nonatomic, copy) void (^completionBlock) (NSError *error);

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection;

#pragma mark - Methods

- (void) cancelDownload;
- (void) startDownload;

@end
