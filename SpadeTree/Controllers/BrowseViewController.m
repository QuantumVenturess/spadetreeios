//
//  BrowseViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 6/27/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AllInterestStore.h"
#import "BrowseInterestStore.h"
#import "BrowseViewController.h"
#import "Interest.h"
#import "InterestBrowseCell.h"
#import "InterestBrowseSearchConnection.h"
#import "InterestDetailViewController.h"
#import "InterestGroup.h"
#import "NSString+Extensions.h"
#import "TextFieldPadding.h"
#import "UIColor+Extensions.h"
#import "User.h"

@implementation BrowseViewController

@synthesize searchField;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.title = @"Browse";
    self.trackedViewName = @"Browse";
    [[NSNotificationCenter defaultCenter] addObserver: self
      selector: @selector(reloadTable) name: AppTokenReceivedNotification 
        object: nil];
  }
  return self;
}

#pragma mark - Override SpadeTreeTableViewController

- (void) reloadTable
{
  [super reloadTable];
  [[BrowseInterestStore sharedStore] setViewController: self];
  [[BrowseInterestStore sharedStore] fetchPage: self.currentPage completion: 
    ^(NSError *error) {
      if (!error) {
        [self.table reloadData];
      }
      self.fetching = NO;
    }
  ];
}

#pragma mark - Override UIViewController

- (void) loadView
{
  [super loadView];
  // Navigation item
  // Add menu button to navigation item
  self.navigationItem.leftBarButtonItem = [[MenuBarButtonItem alloc] init];
  CGRect screen = [[UIScreen mainScreen] bounds];
  // Search view
  UIView *searchView = [[UIView alloc] init];
  searchView.backgroundColor = [UIColor whiteColor];
  searchView.frame = CGRectMake(0, 0, screen.size.width, 84);
  self.table.tableHeaderView = searchView;
  // search field
  self.searchField = [[TextFieldPadding alloc] init];
  self.searchField.autocapitalizationType = 
    UITextAutocapitalizationTypeSentences;
  // self.searchField.autocorrectionType = UITextAutocorrectionTypeYes;
  self.searchField.backgroundColor = [UIColor whiteColor];
  self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.searchField.delegate = self;
  self.searchField.frame = CGRectMake(10, 20, (screen.size.width - 20), 44);
  self.searchField.font  = [UIFont fontWithName: @"HelveticaNeue" size: 15];
  self.searchField.layer.borderWidth = 1.0;
  self.searchField.layer.borderColor = [UIColor blackColor].CGColor;
  self.searchField.paddingX = 40;
  self.searchField.paddingY = 12;
  self.searchField.placeholder = @"Search your passions";
  self.searchField.textColor   = [UIColor gray: 50];
  [searchView addSubview: self.searchField];
  [self.searchField addTarget: self action: @selector(fetchInterests:)
    forControlEvents: UIControlEventEditingChanged];
  // search field image
  UIImageView *searchImage = [[UIImageView alloc] init];
  searchImage.alpha = 0.5;
  searchImage.frame = CGRectMake(10, 0, 20, 20);
  searchImage.image = [UIImage imageNamed: @"search_interest.png"];
  UIView *searchImageView = [[UIView alloc] init];
  searchImageView.frame = CGRectMake(0, 0, 20, 20);
  [searchImageView addSubview: searchImage];
  self.searchField.leftView = searchImageView;
  self.searchField.leftViewMode = UITextFieldViewModeAlways;
}

- (void) viewWillAppear: (BOOL) animated
{
  [super viewWillAppear: animated];
  [self.table reloadData];
}

#pragma mark - Protocol UIScrollViewDelegate

- (void) scrollViewDidScroll: (UIScrollView *) scrollView
{
  float scrollViewHeight   = scrollView.frame.size.height;     // 504
  float contentHeight      = scrollView.contentSize.height;    // 1620
  float totalContentOffset = contentHeight - scrollViewHeight; // 1116
  float limit = totalContentOffset - (scrollViewHeight / 1.0); // 1116 - 504/1
  if (!self.fetching && scrollView.contentOffset.y > limit && 
    self.maxPages > self.currentPage) {

    self.currentPage += 1;
    self.fetching = YES;
    [self reloadTable];
  }
}

- (void) scrollViewWillBeginDragging: (UIScrollView *) scrollView
{
  [self.searchField resignFirstResponder];
}

#pragma mark - Protocol UITableViewDataSource

- (UITableViewCell *) tableView: (UITableView *) tableView
cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
  NSString *indentifier = @"InterestBrowseCell";
  InterestBrowseCell *cell = [tableView dequeueReusableCellWithIdentifier: 
    indentifier];
  if (!cell) {
    cell = [[InterestBrowseCell alloc] initWithStyle: 
      UITableViewCellStyleDefault reuseIdentifier: indentifier];
  }
  [cell loadInterestData: [self interestAtIndexPath: indexPath]];
  return cell;
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
  return [[BrowseInterestStore sharedStore] group].count;
}

- (NSInteger) tableView: (UITableView *) tableView
numberOfRowsInSection: (NSInteger) section
{
  InterestGroup *interestGroup = (InterestGroup *)
    [[[BrowseInterestStore sharedStore] group] objectAtIndex: section];
  return interestGroup.interests.count;
}

#pragma mark - Protocol UITableViewDelegate

- (void) tableView: (UITableView *) tableView
didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
  Interest *interest = [self interestAtIndexPath: indexPath];
  InterestDetailViewController *interestDetail = 
    [[InterestDetailViewController alloc] initWithInterest: interest];
  [self.searchField resignFirstResponder];
  [self.navigationController pushViewController: interestDetail
    animated: YES];
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
  InterestGroup *interestGroup = (InterestGroup *)
    [[[BrowseInterestStore sharedStore] group] objectAtIndex: section];
  UIView *header = [[UIView alloc] init];
  header.backgroundColor = [UIColor colorWithRed: 255 green: 255 blue: 255
    alpha: 0.7];
  header.frame = CGRectMake(0, 0, tableView.frame.size.width, 60);
  CALayer *layer = [CALayer layer];
  layer.backgroundColor = [UIColor blackColor].CGColor;
  layer.frame = CGRectMake(0, 59, (tableView.frame.size.width - 0), 1);
  [header.layer addSublayer: layer];
  UILabel *label = [[UILabel alloc] init];
  label.backgroundColor = [UIColor clearColor];
  label.frame = CGRectMake(20, 10, (tableView.frame.size.width - 40), 40);
  label.font = [UIFont fontWithName: @"HelveticaNeue" size: 27];
  label.text = [interestGroup.letter uppercaseString];
  label.textColor = [UIColor gray: 50];
  [header addSubview: label];
  return header;
}

#pragma mark - Protocol UITextFieldDelegate

- (BOOL) textFieldShouldReturn: (UITextField *) textField
{
  [self fetchInterests: textField];
  [textField resignFirstResponder];
  return NO;
}

#pragma mark - Methods

- (void) fetchInterests: (id) sender
{
  UITextField *textField = (UITextField *) sender;
  [self searchInterests: textField.text];
  InterestBrowseSearchConnection *connection = 
    [[InterestBrowseSearchConnection alloc] initWithTerm: textField.text];
  connection.completionBlock = ^(NSError *error) {
    [self searchInterests: self.searchField.text];
    self.fetching = NO;
  };
  self.currentPage = self.maxPages;
  self.fetching    = YES;
  [connection start];
}

- (Interest *) interestAtIndexPath: (NSIndexPath *) indexPath
{
  InterestGroup *interestGroup = [self interestGroupAtIndexPath: indexPath];
  return (Interest *) [interestGroup.interests objectAtIndex: 
    indexPath.row];
}

- (InterestGroup *) interestGroupAtIndexPath: (NSIndexPath *) indexPath
{
  return (InterestGroup *) 
    [[[BrowseInterestStore sharedStore] group] objectAtIndex: 
      indexPath.section];
}

- (void) searchInterests: (NSString *) string
{
  NSMutableArray *subpredicates = [NSMutableArray array];
  NSArray *words = [string componentsSeparatedByString: @","];
  for (NSString *word in words) {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
      @"(%K BEGINSWITH %@) OR (%K CONTAINS %@)",
      @"name", [NSString stripLower: word],
      @"name", [NSString stripLower: word]
    ];
    [subpredicates addObject: predicate];
  }
  NSPredicate *allPredicates = 
    [NSCompoundPredicate orPredicateWithSubpredicates: subpredicates];
  NSArray *array = [[AllInterestStore sharedStore].interests allValues];
  NSArray *filteredArray = [array filteredArrayUsingPredicate: 
    allPredicates];
  NSSortDescriptor *sortName = [NSSortDescriptor sortDescriptorWithKey: @"name"
    ascending: YES];
  NSArray *sortedArray = [filteredArray sortedArrayUsingDescriptors:
    [NSArray arrayWithObject: sortName]];
  if ([[string stringByTrimmingCharactersInSet: 
    [NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
    
    [BrowseInterestStore sharedStore].interests = 
      [NSMutableArray arrayWithArray: sortedArray];
  }
  else {
    [BrowseInterestStore sharedStore].interests =
      [NSMutableArray arrayWithArray: 
        [[AllInterestStore sharedStore] allInterests]];
  }
  [self.table reloadData];
}

@end
