//
//  FriendsTutoredCell.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/25/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface FriendsTutoredCell : UITableViewCell
{
  UIImageView *imageView;
  UIView *interestsView;
  UILabel *nameLabel;
}

@property (nonatomic, strong) NSMutableArray *interests;
@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, strong) User *user;

#pragma mark - Methods

- (void) loadDictionaryData: (NSDictionary *) dictionary;

@end
