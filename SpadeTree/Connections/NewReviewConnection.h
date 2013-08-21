//
//  NewReviewConnection.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/26/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeConnection.h"

@class Review;

@interface NewReviewConnection : SpadeTreeConnection
{
  Review *review;
}

#pragma mark - Initializer

- (id) initWithReview: (Review *) reviewObject;

@end
