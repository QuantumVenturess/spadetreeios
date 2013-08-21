//
//  MenuBarButtonItem.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 6/28/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuBarButtonItem.h"
#import "MFSideMenu.h"

@implementation MenuBarButtonItem

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    UIButton *menuButton = [[UIButton alloc] init];
    menuButton.backgroundColor = [UIColor clearColor];
    menuButton.frame = CGRectMake(0, 0, 40, 23);
    menuButton.imageEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);
    [menuButton addTarget: self action: @selector(showMenu)
      forControlEvents: UIControlEventTouchUpInside];
    [menuButton setImage: [UIImage imageNamed: @"menu.png"]
      forState: UIControlStateNormal];
    self.customView = menuButton;
  }
  return self;
}

#pragma mark - Methods

- (void) showMenu
{
  AppDelegate *appDelegate = (AppDelegate *)
    [UIApplication sharedApplication].delegate;
  [appDelegate.panel toggleLeftSideMenuCompletion: ^{}];
}

@end
