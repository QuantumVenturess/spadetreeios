//
//  SpadeTreeTableViewController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 6/27/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeViewController.h"

@interface SpadeTreeTableViewController : SpadeTreeViewController
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) int currentPage;
@property (nonatomic) BOOL fetching;
@property (nonatomic) int maxPages;
@property (nonatomic, strong) UITableView *table;

#pragma mark - Methods

- (void) reloadTable;

@end
