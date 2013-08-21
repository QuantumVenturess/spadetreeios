//
//  EditProfileConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/29/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "City.h"
#import "EditProfileConnection.h"
#import "State.h"

@implementation EditProfileConnection

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    NSString *string = [NSString stringWithFormat: 
      @"%@/u/%@/edit.json/", SpadeTreeApiURL, [[User currentUser] slug]];
    NSURL *url = [NSURL URLWithString: string];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
    NSString *cityName = 
      [User currentUser].city ? [[User currentUser].city nameTitle] : @"";
    NSString *stateName =
      [User currentUser].state ? [[User currentUser].state nameTitle] : @"";
    NSString *phone =
      [User currentUser].phone ? [NSString stringWithFormat: @"%0.0f", 
        [User currentUser].phone] : @"";
    NSString *params = [NSString stringWithFormat:
      @"spadetree_token=%@&"
      @"about=%@&"
      @"city_name=%@&"
      @"state_name=%@&"
      @"phone=%@",
      [User currentUser].appToken,
      [User currentUser].about,
      cityName,
      stateName,
      phone
    ];
    [req setHTTPBody: [params dataUsingEncoding: NSUTF8StringEncoding]];
    [req setHTTPMethod: @"POST"];
    self.request = req;
  }
  return self;
}

@end
