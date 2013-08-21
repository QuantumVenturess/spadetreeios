//
//  SpadeTreeNavigationController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 6/27/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "FlatNavigationBar.h"
#import "SpadeTreeNavigationController.h"

@implementation SpadeTreeNavigationController

#pragma mark - Initializer

- (id) initWithRootViewController: (UIViewController *) rootViewController
{
  self = [super initWithRootViewController: rootViewController];
  if (self) {
    // Navigation bar
    [self setValue: [[FlatNavigationBar alloc] init] forKey: @"navigationBar"];
  }
  return self;
}

@end
