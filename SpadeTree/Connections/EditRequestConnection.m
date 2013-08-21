//
//  EditRequestConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Choice.h"
#import "City.h"
#import "EditRequestConnection.h"
#import "State.h"

@implementation EditRequestConnection

#pragma mark - Initializer

- (id) initWithChoice: (Choice *) choiceObject
{
  self = [super init];
  if (self) {
    choice = choiceObject;
    NSString *string = [NSString stringWithFormat: 
      @"%@/c/%i.json/", SpadeTreeApiURL, choice.uid];
    NSURL *url = [NSURL URLWithString: string];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
    NSString *params = [NSString stringWithFormat:
      @"spadetree_token=%@&"
      @"address=%@&"
      @"city_name=%@&"
      @"date=%@&"
      @"state_name=%@",
      [User currentUser].appToken,
      choice.address,
      choice.city ? [choice.city nameTitle] : @"",
      [choice dateStringNumbers],
      choice.city && choice.city.state ? [choice.city.state nameTitle] : @""
    ];
    [req setHTTPBody: [params dataUsingEncoding: NSUTF8StringEncoding]];
    [req setHTTPMethod: @"POST"];
    self.request = req;
  }
  return self;
}

@end
