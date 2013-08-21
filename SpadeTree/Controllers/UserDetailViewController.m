//
//  UserDetailViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/11/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AboutUserCell.h"
#import "AddReviewCell.h"
#import "AddReviewViewController.h"
#import "ChooseTutorViewController.h"
#import "FriendsTutoredCell.h"
#import "FriendsTutoredConnection.h"
#import "InterestDetailViewController.h"
#import "Review.h"
#import "SpadeTreeNavigationController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Resize.h"
#import "User.h"
#import "UserDetailConnection.h"
#import "UserDetailViewController.h"
#import "UserInterestCell.h"
#import "UserReviewCell.h"
#import "UserReviewsConnection.h"

@implementation UserDetailViewController

@synthesize user;

#pragma mark - Initializer

- (id) initWithUser: (User *) userObject
{
  self = [super init];
  if (self) {
    self.user  = userObject;
    self.title = [self.user fullName];
    self.trackedViewName = [NSString stringWithFormat:
      @"User Detail %@", [self.user fullName]];
    if (self.user.tutor) {
      addReviewNav = 
        [[SpadeTreeNavigationController alloc] initWithRootViewController:
          [[AddReviewViewController alloc] initWithUser: self.user]];
      chooseTutorNav =
        [[SpadeTreeNavigationController alloc] initWithRootViewController: 
          [[ChooseTutorViewController alloc] initWithUser: self.user]];
    }
  }
  return self;
}

#pragma mark - Override UIViewController

- (void) loadView
{
  [super loadView];
  CGRect screen = [[UIScreen mainScreen] bounds];
  // If this view controller is the profile view controller
  if ([self.navigationController.viewControllers objectAtIndex: 0] == self) {
    // Make the left bar button the menu button
    self.navigationItem.leftBarButtonItem = [[MenuBarButtonItem alloc] init];
  }
  // If current user is a tutee and this view controller's user is a tutor
  if ([User currentUser].tutee && self.user.tutor) {
    // Show a right bar button as "Choose Tutor"
    NSString *chooseString = @"Choose";
    UIFont *font14 = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    CGSize maxSize = CGSizeMake(screen.size.width, 18);
    CGSize textSize = [chooseString sizeWithFont: font14
      constrainedToSize: maxSize];
    UILabel *chooseLabel = [[UILabel alloc] init];
    chooseLabel.backgroundColor = [UIColor clearColor];
    chooseLabel.font = font14;
    chooseLabel.frame = CGRectMake(0, 0, textSize.width, textSize.height);
    chooseLabel.text = chooseString;
    chooseLabel.textColor = [UIColor whiteColor];
    UIButton *chooseButton = [[UIButton alloc] init];
    chooseButton.frame = CGRectMake(0, 0, (chooseLabel.frame.size.width + 5),
      chooseLabel.frame.size.height);
    [chooseButton addTarget: self action: @selector(chooseTutor)
      forControlEvents: UIControlEventTouchUpInside];
    [chooseButton addSubview: chooseLabel];
    self.navigationItem.rightBarButtonItem = 
      [[UIBarButtonItem alloc] initWithCustomView: chooseButton];
  }
  int imageSize = 60;
  UIColor *textColor = [UIColor gray: 50];
  // Table header view
  UIView *headerView = [[UIView alloc] init];
  headerView.backgroundColor = [UIColor clearColor];
  headerView.frame = CGRectMake(0, 0, screen.size.width, (imageSize + 40));
  self.table.tableHeaderView = headerView;
  // Table footer view
  // UIView *footerView = [[UIView alloc] init];
  // footerView.backgroundColor = [UIColor clearColor];
  // footerView.frame = CGRectMake(0, 0, screen.size.width, (imageSize + 40));
  // self.table.tableFooterView = footerView;
  // User image view
  userImageView = [[UIImageView alloc] init];
  userImageView.backgroundColor = [UIColor clearColor];
  userImageView.clipsToBounds = YES;
  userImageView.contentMode = UIViewContentModeTopLeft;
  userImageView.frame = CGRectMake(10, 20, imageSize, imageSize);
  [headerView addSubview: userImageView];
  // Name label
  nameLabel = [[UILabel alloc] init];
  nameLabel.backgroundColor = [UIColor clearColor];
  nameLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 20];
  nameLabel.frame = CGRectMake((10 + imageSize + 10), 20, 
    (screen.size.width - (10 + imageSize + 10 + 10)), (imageSize / 2.0));
  nameLabel.textColor = textColor;
  [headerView addSubview: nameLabel];
  // Location
  // image
  UIImageView *locationImageView = [[UIImageView alloc] init];
  locationImageView.frame = CGRectMake((10 + imageSize + 10),
    (20 + (imageSize / 2.0) + (15 / 2.0)), 15, 15);
  locationImageView.image = [UIImage image: [UIImage imageNamed: 
    @"location.png"] size: CGSizeMake(15, 15)];
  [headerView addSubview: locationImageView];
  // label
  locationLabel = [[UILabel alloc] init];
  locationLabel.backgroundColor = [UIColor clearColor];
  locationLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
  locationLabel.frame = CGRectMake((10 + imageSize + 10 + 15 + 5), 
    (20 + (imageSize / 2.0)), (screen.size.width - (10 + imageSize + 10 + 10)), 
      (imageSize / 2.0));
  locationLabel.textColor = textColor;
  [headerView addSubview: locationLabel];
}

- (void) viewDidDisappear: (BOOL) animated
{
  [super viewDidDisappear: animated];
  for (UITableViewCell *cell in [self.table visibleCells]) {
    if ([cell isKindOfClass: [UserInterestCell class]]) {
      [(UserInterestCell *) cell unselectCell];
    }
  }
}

- (void) viewWillAppear: (BOOL) animated
{
  [super viewWillAppear: animated];
  // If user is not current user or current user did not recently update
  if (self.user.uid != [User currentUser].uid
    || ![[User currentUser] recentlyUpdated]) {

    // User detail information; about, skills/interests
    UserDetailConnection *userDetailConnection = 
      [[UserDetailConnection alloc] initWithUser: self.user];
    userDetailConnection.completionBlock = ^(NSError *error) {
      [self loadUserInformation];
      [(ChooseTutorViewController *) 
        [chooseTutorNav.viewControllers objectAtIndex: 0] refreshViews];
    };
    [userDetailConnection start];
  }
  // User reviews
  UserReviewsConnection *userReviewsConnection =
    [[UserReviewsConnection alloc] initWithUser: self.user];
  userReviewsConnection.completionBlock = ^(NSError *error) {
    [self loadUserInformation];
  };
  [userReviewsConnection start];
  // Friends tutored
  [self fetchFriendsTutored];
  [self loadUserInformation];
}

#pragma mark - Protocol UITableViewDataSource

- (UITableViewCell *) tableView: (UITableView *) tableView
cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
  NSString *identifier;
  if (indexPath.section == 0) {
    identifier = @"AboutUserCell";
    AboutUserCell *cell = [tableView dequeueReusableCellWithIdentifier:
      identifier];
    if (!cell) {
      cell = [[AboutUserCell alloc] initWithStyle: UITableViewCellStyleDefault
        reuseIdentifier: identifier];
    }
    [cell loadUserData: self.user];
    return cell;
  }
  else if (indexPath.section == 1) {
    identifier = @"UserInterestCell";
    UserInterestCell *cell = [tableView dequeueReusableCellWithIdentifier:
      identifier];
    if (!cell) {
      cell = [[UserInterestCell alloc] initWithStyle: 
        UITableViewCellStyleDefault reuseIdentifier: identifier];
    }
    NSMutableArray *array = [NSMutableArray array];
    int firstIndex  = indexPath.row * 2;
    int secondIndex = firstIndex + 1;
    Interest *interest1 = [self.user.skills objectAtIndex: firstIndex];
    [array addObject: interest1];
    if (self.user.skills.count > secondIndex) {
      Interest *interest2 = [self.user.skills objectAtIndex: secondIndex];
      [array addObject: interest2];
    }
    cell.navigationController = self.navigationController;
    [cell loadInterests: array];
    // Interest *interest = [self.user.skills objectAtIndex: indexPath.row];
    // [cell loadInterestData: interest];
    return cell;
  }
  else if (indexPath.section == 2) {
    identifier = @"FriendsTutoredCell";
    FriendsTutoredCell *cell = [tableView dequeueReusableCellWithIdentifier:
      identifier];
    if (!cell) {
      cell = [[FriendsTutoredCell alloc] initWithStyle: 
        UITableViewCellStyleDefault reuseIdentifier: identifier];
    }
    NSDictionary *dict = 
      [[self.user friendsTutoredSortedByName] objectAtIndex: indexPath.row];
    cell.navigationController = self.navigationController;
    [cell loadDictionaryData: dict];
    return cell;
  }
  else if (indexPath.section == 3) {
    // if (indexPath.row == 0) {
    //   if ([User currentUser].tutor) {
    //     return [[UITableViewCell alloc] init];
    //   }
    //   identifier = @"AddReviewCell";
    //   AddReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:
    //     identifier];
    //   if (!cell) {
    //     cell = [[AddReviewCell alloc] initWithStyle: 
    //       UITableViewCellStyleDefault reuseIdentifier: identifier];
    //   }
    //   [cell.addReviewButton addTarget: self action: @selector(addReview)
    //     forControlEvents: UIControlEventTouchUpInside];
    //   return cell;
    // }
    identifier = @"UserReviewCell";
    UserReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:
      identifier];
    if (!cell) {
      cell = [[UserReviewCell alloc] initWithStyle: 
        UITableViewCellStyleDefault reuseIdentifier: identifier];
    }
    Review *review = [self.user.reviews objectAtIndex: indexPath.row];
    [cell loadReviewData: review];
    return cell;
  }
  return [[UITableViewCell alloc] init];
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
  int sections = 2;
  if (self.user.tutor) {
    sections = 4;
  }
  return sections;
}

- (NSInteger) tableView: (UITableView *) tableView
numberOfRowsInSection: (NSInteger) section
{
  if (section == 0) {
    return 1;
  }
  else if (section == 1) {
    int rows = self.user.skills.count / 2;
    if (self.user.skills.count % 2) {
      rows += 1;
    }
    return rows;
  }
  else if (section == 2) {
    return self.user.friendsTutored.count;
  }
  else if (section == 3) {
  //  return 1 + self.user.reviews.count;
    return self.user.reviews.count;
  }
  return 1;
}

#pragma mark - Protocol UITableViewDelegate

- (void) tableView: (UITableView *) tableView
didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
  if (indexPath.section == 1) {
    // UserInterestCell *cell = (UserInterestCell *)
    //   [tableView cellForRowAtIndexPath: indexPath];
    // [cell selectCell];
    // Interest *interest = [self.user.skills objectAtIndex: indexPath.row];
    // InterestDetailViewController *interestDetail = 
    //   [[InterestDetailViewController alloc] initWithInterest: interest];
    // [self.navigationController pushViewController: interestDetail 
    //   animated: YES];
  }
  else if (indexPath.section == 2) {
    // Do nothing when user clicks on a friends tutored cell
  }
  else if (indexPath.section == 3) {
    // if (indexPath.row == 0) {
    //   // Add review
    // }
    Review *review = [self.user.reviews objectAtIndex: indexPath.row];
    UserDetailViewController *userDetail =
      [[UserDetailViewController alloc] initWithUser: review.tutee];
    [self.navigationController pushViewController: userDetail
      animated: YES];
  }
}

- (CGFloat) tableView: (UITableView *) tableView
heightForHeaderInSection: (NSInteger) section
{
  if (section == 2 && ![self shouldShowFriendsTutored])
    return 0;
  return 40;
}

- (CGFloat) tableView: (UITableView *) tableView
heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
  int padding = 10;
  UIFont *font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
  CGSize size = CGSizeMake(tableView.frame.size.width - (padding * 2), 1000);
  if (indexPath.section == 0) {
    NSString *text = self.user.about;
    CGSize textSize = [text sizeWithFont: font constrainedToSize: size];
    return textSize.height + (padding * 2);
  }
  else if (indexPath.section == 1) {
    return 40;
  }
  else if (indexPath.section == 2) {
    if (![self shouldShowFriendsTutored]) {
      return 0;
    }
    return 60;
  }
  else if (indexPath.section == 3) {
    // if (indexPath.row == 0) {
    //   if ([User currentUser].tutor) {
    //     return 0;
    //   }
    //   return 40;
    // }
    Review *review = [self.user.reviews objectAtIndex: indexPath.row];
    NSString *text = review.content;
    CGSize textSize = [text sizeWithFont: font constrainedToSize: size];
    return 10 + 40 + 10 + textSize.height + 10;
  }
  return 40;
}

- (UIView *) tableView: (UITableView *) tableView
viewForHeaderInSection: (NSInteger) section
{
  int imageSize = 18;
  UIView *header = [[UIView alloc] init];
  header.backgroundColor = [UIColor colorWithRed: 255 green: 255 blue: 255
    alpha: 0.7];
  header.frame = CGRectMake(0, 0, tableView.frame.size.width, 40);
  UILabel *label = [[UILabel alloc] init];
  label.backgroundColor = [UIColor clearColor];
  label.font = [UIFont fontWithName: @"HelveticaNeue" size: 20];
  label.frame = CGRectMake((10 + imageSize + 10), 0, 
    (tableView.frame.size.width - (10 + imageSize + 10 + 10)), 40);
  label.textColor = [UIColor gray: 50];
  [header addSubview: label];
  UIImageView *imageView = [[UIImageView alloc] init];
  imageView.frame = CGRectMake(10, 10, imageSize, imageSize);
  [header addSubview: imageView];
  if (section == 0) {
    // About
    label.text = @"About";
    imageView.image = [UIImage image: [UIImage imageNamed: @"about_user.png"]
      size: CGSizeMake(imageSize, imageSize)];
  }
  else if (section == 1) {
    // Interests, Skills
    label.text = @"Skills";
    if (self.user.tutee) {
      label.text = @"Interests";
    }
    imageView.image = [UIImage image: [UIImage imageNamed: @"skills_user.png"]
      size: CGSizeMake(imageSize, imageSize)];
  }
  else if (section == 2) {
    label.text = @"Friends tutored";
    imageView.image = [UIImage image: [UIImage imageNamed: 
      @"friends_tutored.png"] size: CGSizeMake(imageSize, imageSize)];
  }
  else if (section == 3) {
    label.text = @"Reviews";
    imageView.image = [UIImage image: [UIImage imageNamed: @"reviews_user.png"]
      size: CGSizeMake(imageSize, imageSize)];
    // Add Review button
    if (self.user.tutor && [User currentUser].tutee) {
      CGRect screen = [[UIScreen mainScreen] bounds];
      UILabel *label = [[UILabel alloc] init];
      label.backgroundColor = [UIColor clearColor];
      label.font  = [UIFont fontWithName: @"HelveticaNeue" size: 14];
      label.text  = @"+ Add Review";
      label.textAlignment = NSTextAlignmentRight;
      label.textColor = [UIColor spadeGreenDark];
      CGSize textSize = [label.text sizeWithFont: label.font 
        constrainedToSize: CGSizeMake(screen.size.width - 20, 20)];
      label.frame = CGRectMake(0, 10, textSize.width, textSize.height);
      // button
      UIButton *addReviewButton = [[UIButton alloc] init];
      addReviewButton.frame = CGRectMake(
        (screen.size.width - (10 + label.frame.size.width)), 0, 
          label.frame.size.width, 40);
      [addReviewButton addSubview: label];
      [addReviewButton addTarget: self action: @selector(addReview)
        forControlEvents: UIControlEventTouchUpInside];
      [header addSubview: addReviewButton];
    }
  }
  if (section == 2 && ![self shouldShowFriendsTutored])
    return [[UIView alloc] init];
  return header;
}

#pragma mark - Methods

- (void) addReview
{
  if (self.user.tutor) {
    [self presentViewController: addReviewNav animated: YES completion: nil];
  }
}

- (void) chooseTutor
{
  if (self.user.tutor) {
    [self presentViewController: chooseTutorNav animated: YES completion: nil];
  }
}

- (void) fetchFriendsTutored
{
  if (self.user.tutor && [User currentUser].tutee) {
    FriendsTutoredConnection *connection = 
      [[FriendsTutoredConnection alloc] initWithUser: self.user];
    connection.completionBlock = ^(NSError *error) {
      [self.table reloadData];
    };
    [connection start];
  }
}

- (void) loadUserData: (User *) userObject
{
  self.user  = userObject;
  self.title = [self.user fullName];
  [self loadUserInformation];
}

- (void) loadUserInformation
{
  if (self.user) {
    // Image
    int imageSize = 60;
    if (self.user.image) {
      userImageView.image = [self.user imageWithSize: 
        CGSizeMake(imageSize, imageSize)];
    }
    else {
      [self.user downloadImage: ^(NSError *error) {
        if (!error) {
          userImageView.image = [self.user imageWithSize: 
            CGSizeMake(imageSize, imageSize)];
        }
      }];
      userImageView.image = [UIImage imageNamed: @"placeholder.png"];
    }
    // Name
    nameLabel.text = [self.user fullName];
    // Location
    locationLabel.text = [self.user locationString];
  }
  [self.table reloadData];
}

- (BOOL) shouldShowFriendsTutored
{
  if (self.user.tutor && self.user.friendsTutored.count > 0) {
    return YES;
  }
  return NO;
}

@end
