//
//  AddReviewViewController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/26/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "NewModelViewController.h"

@class User;

@interface AddReviewViewController : NewModelViewController
{
  User *user;
}

#pragma mark - Initializer

- (id) initWithUser: (User *) userObject;

@end
