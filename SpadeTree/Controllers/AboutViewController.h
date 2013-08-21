//
//  AboutViewController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/6/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeViewController.h"

@interface AboutViewController : SpadeTreeViewController
<UIScrollViewDelegate>
{
  UIScrollView *scroll;
  NSMutableArray *subviews;
}

@end
