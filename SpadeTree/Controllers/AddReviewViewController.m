//
//  AddReviewViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/26/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AddReviewViewController.h"
#import "NewReviewConnection.h"
#import "Review.h"
#import "User.h"

@implementation AddReviewViewController

#pragma mark - Initializer

- (id) initWithUser: (User *) userObject
{
  self = [super init];
  if (self) {
    user       = userObject;
    self.title = @"Adding Review";
    self.trackedViewName = @"Add Review";
  }
  return self;
}

#pragma mark - Methods

- (void) submit
{
  NSString *content = [contentTextView.text stringByTrimmingCharactersInSet: 
    [NSCharacterSet whitespaceAndNewlineCharacterSet]];
  if (content.length > 0) {
    Review *review  = [[Review alloc] init];
    review.content  = content;
    review.created  = [[NSDate date] timeIntervalSince1970];
    review.positive = YES;
    review.tutee    = [User currentUser];
    review.tutor    = user;
    [user addNewReview: review];
    [[[NewReviewConnection alloc] initWithReview: review] start];
    [self cancel];
  }
}

@end
