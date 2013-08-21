//
//  UIColor+Extensions.m
//  Bite
//
//  Created by Tommy DANGerous on 6/9/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

+ (UIColor *) backgroundColor
{
  return [UIColor gray: 245];
}

+ (UIColor *) darkRed
{
  return [UIColor colorWithRed: (207/255.0) green: (4/255.0) blue: (4/255.0) 
    alpha: 1];
}

+ (UIColor *) gray: (int) value
{
  return [UIColor colorWithRed: (value/255.0) green: (value/255.0) 
    blue: (value/255.0) alpha: 1];
}

+ (UIColor *) red
{
  return [UIColor colorWithRed: (255/255.0) green: (26/255.0) 
    blue: (0/255.0) alpha: 1];
}

+ (UIColor *) spadeGreen
{
  return [UIColor colorWithRed: (115/255.0) green: (202/255.0) 
    blue: (36/255.0) alpha: 1];
}

+ (UIColor *) spadeGreenDark
{
  return [UIColor colorWithRed: (41/255.0) green: (154/255.0) 
    blue: (11/255.0) alpha: 1];
}

@end
