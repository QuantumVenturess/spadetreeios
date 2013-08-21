//
//  InterestBrowseCell.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Interest;

@interface InterestBrowseCell : UITableViewCell
{
  Interest *interest;
  UILabel *titleLabel;
}

#pragma mark - Methods

- (void) loadInterestData: (Interest *) interestObject;

@end
