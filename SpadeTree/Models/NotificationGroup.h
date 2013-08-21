//
//  NotificationGroup.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationGroup : NSObject

@property (nonatomic) NSTimeInterval date;
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) NSMutableArray *notifications;

@end
