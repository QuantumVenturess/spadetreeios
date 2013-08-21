//
//  UserInterestCell.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/12/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Interest;

@interface UserInterestCell : UITableViewCell
{
  UIButton *button1;
  UIButton *button2;
  // Interest *interest;
  Interest *interest1;
  Interest *interest2;
  UIView *mainView;
  // UILabel *nameLabel;
  UILabel *nameLabel1;
  UILabel *nameLabel2;
}

@property (nonatomic, weak) UINavigationController *navigationController;

#pragma mark - Methods

- (void) loadInterestData: (Interest *) interestObject;
- (void) loadInterests: (NSArray *) interests;
- (void) selectCell;
- (void) unselectCell;

@end
