//
//  UserReviewCell.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/12/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Review;

@interface UserReviewCell : UITableViewCell
{
  UILabel *contentLabel;
  UILabel *createdLabel;
  UIImageView *imageView;
  UILabel *nameLabel;
  Review *review;
}

#pragma mark - Methods

- (void) loadReviewData: (Review *) reviewObject;

@end
