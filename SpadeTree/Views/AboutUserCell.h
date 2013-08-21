//
//  AboutUserCell.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/12/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface AboutUserCell : UITableViewCell

@property (nonatomic, strong) UILabel *aboutLabel;

#pragma mark - Methods

- (void) loadUserData: (User *) userObject;

@end
