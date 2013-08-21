//
//  NewReviewConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/26/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "NewReviewConnection.h"
#import "Review.h"

@implementation NewReviewConnection

#pragma mark - Initializer

- (id) initWithReview: (Review *) reviewObject
{
  self = [super init];
  if (self) {
    review = reviewObject;
    NSString *string = [NSString stringWithFormat: 
      @"%@/u/%@/reviews/new.json/", SpadeTreeApiURL, [review.tutor slug]];
    NSURL *url = [NSURL URLWithString: string];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
    NSString *params = [NSString stringWithFormat:
      @"spadetree_token=%@&"
      @"content=%@&"
      @"positive=1",
      [User currentUser].appToken,
      review.content
    ];
    [req setHTTPBody: [params dataUsingEncoding: NSUTF8StringEncoding]];
    [req setHTTPMethod: @"POST"];
    self.request = req;
  }
  return self;
}

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  review.uid = [[[json objectForKey: @"review"] objectForKey: 
    @"id"] integerValue];
  [super connectionDidFinishLoading: connection];
}

@end
