//
//  InterestDetailViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Interest.h"
#import "InterestDetailCell.h"
#import "InterestDetailConnection.h"
#import "InterestDetailEmptyCell.h"
#import "InterestDetailViewController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Resize.h"
#import "UserDetailViewController.h"

@implementation InterestDetailViewController

@synthesize interest;

#pragma mark - Initializer

- (id) initWithInterest: (Interest *) interestObject
{
  self = [super init];
  if (self) {
    self.interest = interestObject;
    self.title    = [self.interest nameTitle];
    self.trackedViewName = [NSString stringWithFormat:
      @"Interest Detail %@", [self.interest nameTitle]];
  }
  return self;
}

#pragma mark - SpadeTreeTableViewController

- (void) reloadTable
{
  [self.table reloadData];
  if (self.interest.tutors.count == 0) {
    InterestDetailEmptyCell *cell = (InterestDetailEmptyCell *) 
      [self.table cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0
        inSection: 0]];
    cell.label.text = @"Sorry, no tutors yet";
  }
  if (self.interest.tutees.count == 0) {
    InterestDetailEmptyCell *cell = (InterestDetailEmptyCell *) 
      [self.table cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0
        inSection: 1]];
    cell.label.text = @"Sorry, no tutees yet";
  }
}

#pragma mark - Override UIViewController

- (void) loadView
{
  [super loadView];
}

- (void) viewWillAppear: (BOOL) animated
{
  [super viewWillAppear: animated];
  InterestDetailConnection *connection = 
    [[InterestDetailConnection alloc] initWithInterest: self.interest];
  connection.completionBlock = ^(NSError *error) {
    if (!error) {
      [self reloadTable];
    }
  };
  [connection start];
}

#pragma mark - Protocol UITableViewDataSource

- (UITableViewCell *) tableView: (UITableView *) tableView
cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
  NSArray *users;
  if (indexPath.section == 0) {
    users = self.interest.tutors;
  }
  else if (indexPath.section == 1) {
    users = self.interest.tutees;
  }
  if (users.count) {
    NSString *identifier = @"InterestDetailCell";
    InterestDetailCell *cell = 
      [tableView dequeueReusableCellWithIdentifier: identifier];
    if (!cell) {
      cell = [[InterestDetailCell alloc] initWithStyle: 
        UITableViewCellStyleDefault reuseIdentifier: identifier];
    }
    [cell loadUserData: (User *) [users objectAtIndex: indexPath.row]];
    return cell;
  }
  else {
    NSString *identifier = @"InterestDetailEmptyCell";
    InterestDetailEmptyCell *cell = 
      [tableView dequeueReusableCellWithIdentifier: identifier];
    if (!cell) {
      cell = [[InterestDetailEmptyCell alloc] initWithStyle: 
        UITableViewCellStyleDefault reuseIdentifier: identifier];
    }
    return cell;
  }
  return [[UITableViewCell alloc] init];
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
  return 2;
}

- (NSInteger) tableView: (UITableView *) tableView
numberOfRowsInSection: (NSInteger) section
{
  NSInteger count = 1;
  if (section == 0) {
    if (interest.tutors.count) {
      count = interest.tutors.count;
    }
  }
  else if (section == 1) {
    if (interest.tutees.count) {
      count = interest.tutees.count;
    }
  }
  return count;
}

#pragma mark - Protocol UITableViewDelegate

- (void) tableView: (UITableView *) tableView
didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
  int section = indexPath.section;
  int row     = indexPath.row;
  User *user;
  NSArray *users;
  if (section == 0 && self.interest.tutors) {
    users = self.interest.tutors;
  }
  else if (section == 1 && self.interest.tutees) {
    users = self.interest.tutees;
  }
  if (users.count >= row + 1) {
    user = (User *) [users objectAtIndex: row];
    UserDetailViewController *userDetail = 
      [[UserDetailViewController alloc] initWithUser: user];
    [self.navigationController pushViewController: userDetail 
      animated: YES];
  }
}

- (CGFloat) tableView: (UITableView *) tableView
heightForHeaderInSection: (NSInteger) section
{
  return 60;
}

- (CGFloat) tableView: (UITableView *) tableView
heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
  return 60;
}

- (UIView *) tableView: (UITableView *) tableView
viewForHeaderInSection: (NSInteger) section
{
  UIView *header = [[UIView alloc] init];
  header.backgroundColor = [UIColor colorWithRed: 255 green: 255 blue: 255
    alpha: 0.7];
  header.frame = CGRectMake(0, 0, tableView.frame.size.width, 60);
  UIImageView *imageView = [[UIImageView alloc] init];
  imageView.backgroundColor = [UIColor clearColor];
  imageView.clipsToBounds = YES;
  imageView.contentMode = UIViewContentModeTopLeft;
  imageView.frame = CGRectMake(10, 15, 30, 30);
  [header addSubview: imageView];
  UILabel *label = [[UILabel alloc] init];
  label.backgroundColor = [UIColor clearColor];
  label.frame = CGRectMake((10 + 30 + 10), 10, 
    (tableView.frame.size.width -  (10 + 30 + 10 + 10)), 40);
  label.font = [UIFont fontWithName: @"HelveticaNeue" size: 27];
  if (section == 0) {
    imageView.image = [UIImage image: [UIImage imageNamed: @"tutors.png"]
      size: CGSizeMake(30, 30)];
    label.text = @"Tutors";
  }
  else if (section == 1) {
    imageView.image = [UIImage image: [UIImage imageNamed: @"tutees.png"]
      size: CGSizeMake(30, 30)];
    label.text = @"Tutees";
  }
  label.textColor = [UIColor gray: 50];
  [header addSubview: label];
  return header;
}

@end
