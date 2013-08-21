//
//  MessageDetailViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"
#import "Message.h"
#import "MessageDetailCell.h"
#import "MessageDetailConnection.h"
#import "MessageDetailStore.h"
#import "MessageDetailViewController.h"
#import "MessageListStore.h"
#import "NewMessageConnection.h"
#import "UIColor+Extensions.h"
#import "User.h"

@implementation MessageDetailViewController

#pragma mark - Initializer

- (id) initWithMessage: (Message *) messageObject
{
  self = [super init];
  if (self) {
    message             = messageObject;
    tableFrameShifted   = NO;
    textViewPlaceholder = @"Type your message here";
    self.title          = [message.sender fullName];
    self.trackedViewName = [NSString stringWithFormat:
      @"Message Detail %i", message.uid];
  }
  return self;
}

#pragma mark - Override UIViewController

- (void) loadView
{
  [super loadView];
  CGRect screen = [[UIScreen mainScreen] bounds];
  UIFont *font = [UIFont fontWithName: @"HelveticaNeue" size: 13];
  // Main view
  self.view = [[UIView alloc] init];
  self.view.backgroundColor = [UIColor blackColor];
  self.view.frame = screen;
  [self.view addSubview: self.table];
  // Table view
  self.table.frame = CGRectMake(0, 0, screen.size.width,
    (screen.size.height - (20 + 44)));
  // Add tap gesture to table
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: 
    self action: @selector(hideTextView)];
  [self.table addGestureRecognizer: tap];
  self.table.backgroundColor = [UIColor gray: 0];
  // Footer view
  UIView *footerView = [[UIView alloc] init];
  footerView.backgroundColor = [UIColor clearColor];
  footerView.frame = CGRectMake(0, 0, screen.size.width, 40);
  self.table.tableFooterView = footerView;
  // Content typing box
  contentTextBox = [[UIView alloc] init];
  contentTextBox.backgroundColor = [UIColor gray: 255];
  contentTextBox.frame = CGRectMake(0, (screen.size.height - (20 + 44 + 40)),
    screen.size.width, 40);
  [self.view addSubview: contentTextBox];
  // Content text view
  contentTextView = [[UITextView alloc] init];
  contentTextView.backgroundColor = [UIColor clearColor];
  contentTextView.contentInset = UIEdgeInsetsMake(-8, -8, -8, -8);
  contentTextView.delegate = self;
  contentTextView.font = font;
  contentTextView.frame = CGRectMake(20, (10 + 1), 
    contentTextBox.frame.size.width - (20 + 10 + 40 + 10), 17);
  contentTextView.scrollEnabled = YES;
  contentTextView.showsVerticalScrollIndicator = NO;
  contentTextView.text = textViewPlaceholder;
  contentTextView.textColor = [UIColor gray: 150];
  [contentTextBox addSubview: contentTextView];
  // Tap gesture on view over contentTextView
  UIView *textViewOverlay = [[UIView alloc] init];
  textViewOverlay.backgroundColor = [UIColor clearColor];
  textViewOverlay.frame = CGRectMake(contentTextView.frame.origin.x, 0,
    contentTextView.frame.size.width, 40);
  UITapGestureRecognizer *textViewTap = 
    [[UITapGestureRecognizer alloc] initWithTarget: 
      contentTextView action: @selector(becomeFirstResponder)];
  [textViewOverlay addGestureRecognizer: textViewTap];
  [contentTextBox addSubview: textViewOverlay];
  // Content button
  contentButton = [[UIButton alloc] init];
  contentButton.backgroundColor = [UIColor clearColor];
  contentButton.frame = CGRectMake(
    (contentTextView.frame.origin.x + contentTextView.frame.size.width), 
      0, 60, 40);
  [contentButton addTarget: self action: @selector(sendMessage)
    forControlEvents: UIControlEventTouchUpInside];
  [contentTextBox addSubview: contentButton];
  // Button label
  UILabel *buttonLabel = [[UILabel alloc] init];
  buttonLabel.backgroundColor = [UIColor clearColor];
  buttonLabel.font = font;
  buttonLabel.frame = CGRectMake(0, 0, 60, 40);
  buttonLabel.text = @"Send";
  buttonLabel.textAlignment = NSTextAlignmentCenter;
  buttonLabel.textColor = [UIColor spadeGreenDark];
  [contentButton addSubview: buttonLabel];
}

- (void) viewWillAppear: (BOOL) animated
{
  [super viewWillAppear: animated];
  [self fetchNewMessages];
  [self.table reloadData];
  [self scrollToBottom: NO];
  // Set count to nothing
  if ([[MessageListStore sharedStore] unviewedMessagesCount] == 0) {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    MenuViewController *menu = appDelegate.menu;
    menu.messagesCount.text  = @"";
  }
}

#pragma mark - Protocol UIScrollViewDelegate

- (void) scrollViewDidScroll: (UIScrollView *) scrollView
{
  // if (![scrollView isKindOfClass: [UITextView class]]) {
  //   CGRect screen = [[UIScreen mainScreen] bounds];
  //   CGRect frame = contentTextBox.frame;
  //   frame.origin.y = (screen.size.height - (20 + 44 + 40)) + 
  //     scrollView.contentOffset.y;
  //   if ([contentTextView isFirstResponder]) {
  //     if (tableFrameShifted) {
  //       frame.origin.y = self.table.contentSize.height - 
  //         contentTextBox.frame.size.height;
  //     }
  //     else {
  //       frame.origin.y -= 216;
  //     }
  //   }
  //   contentTextBox.frame = frame;
  // }
}

- (void) scrollViewWillBeginDragging: (UIScrollView *) scrollView
{
  [self hideTextView];
}

#pragma mark - Protocol UITableViewDataSource

- (UITableViewCell *) tableView: (UITableView *) tableView
cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
  static NSString *identifier = @"MessageDetailCell";
  MessageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:
    identifier];
  if (!cell) {
    cell = [[MessageDetailCell alloc] initWithStyle: 
      UITableViewCellStyleDefault reuseIdentifier: identifier];
  }
  Message *m = [[self messages] objectAtIndex: indexPath.row];
  [cell loadMessageData: m];
  return cell;
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
  return 1;
}

- (NSInteger) tableView: (UITableView *) tableView
numberOfRowsInSection: (NSInteger) section
{
  return [self messages].count;
}

#pragma mark - Protocol UITableViewDelegate

- (void) tableView: (UITableView *) tableView
didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
  NSLog(@"%i", indexPath.row);
}

- (CGFloat) tableView: (UITableView *) tableView
heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
  Message *m = [[self messages] objectAtIndex: indexPath.row];
  CGRect screen = [[UIScreen mainScreen] bounds];
  float maxWidth = (screen.size.width - (35 * 3)) - 10;
  CGSize contentSize = [m.content sizeWithFont: 
    [UIFont fontWithName: @"HelveticaNeue" size: 13]
      constrainedToSize: CGSizeMake(maxWidth, 5000)];
  // Cell padding top 5
  // Content box padding top 5, height of content label, margin of 5
  // height of created label (20), content box padding 5
  // Cell padding bottom 5
  return 5 + (5 + contentSize.height + 5 + 20 + 5) + 5;
}

#pragma mark - UITextViewDelegate

- (void) textViewDidBeginEditing: (UITextView *) textView
{
  [self showKeyboard];
}

- (void) textViewDidEndEditing: (UITextView *) textView
{
  if (textView.text.length == 0) {
    textView.text      = textViewPlaceholder;
    textView.textColor = [UIColor gray: 150];
  }
  [self hideKeyboard];
}

- (BOOL) textViewShouldBeginEditing: (UITextView *) textView
{
  if ([textView.text isEqualToString: textViewPlaceholder]) {
    textView.text      = @"";
    textView.textColor = [UIColor gray: 50];
  }
  return YES;
}

#pragma mark - Methods

- (void) fetchNewMessages
{
  MessageDetailConnection *connection = 
    [[MessageDetailConnection alloc] initWithMessage: message];
  connection.completionBlock = ^(NSError *error) {
    [self.table reloadData];
    [self scrollToBottom: YES];
    if ([contentTextView isFirstResponder]) {
      [self repositionTable];
    }
    [self tableFrameShouldBeShifted];
  };
  [connection start];
}

- (void) hideKeyboard
{
  CGRect screen = [[UIScreen mainScreen] bounds];
  float screenHeight = screen.size.height - (20 + 44);
  float contentHeight = self.table.contentSize.height;
  float keyboardHeight = 216;
  void (^animations) (void) = nil;
  float diff = screenHeight - (contentHeight + keyboardHeight);
  if (diff < 0) {
    CGRect frame = self.table.frame;
    frame.origin.y = 0;
    CGRect contentFrame   = contentTextBox.frame;
    contentFrame.origin.y = screenHeight - contentTextBox.frame.size.height;
    // contentFrame.origin.y = self.table.contentSize.height - 
    //   contentTextBox.frame.size.height;
    animations = ^(void) {
      contentTextBox.frame = contentFrame;
      self.table.frame     = frame;
    };
  }
  else {
    CGRect frame = contentTextBox.frame;
    // frame.origin.y += 216;
    frame.origin.y = (screen.size.height - (20 + 44 + 40));
    animations = ^(void) {
      contentTextBox.frame = frame;
    };
  }
  if (animations) {
    [UIView animateWithDuration: 0.15 delay: 0
      options: UIViewAnimationOptionCurveLinear animations: animations
        completion: nil];
  }
}

- (void) hideTextView
{
  [contentTextView resignFirstResponder];
}

- (NSArray *) messages
{
  return [[MessageDetailStore sharedStore] messagesForUser: message.sender];
}

- (void) repositionTable
{
  CGRect screen = [[UIScreen mainScreen] bounds];
  float screenHeight = screen.size.height - (20 + 44);
  float offset = self.table.frame.origin.y; // -10
  float height = self.table.contentSize.height; // 100
  float adjustedHeight = height + offset;
  float diff = (adjustedHeight + 216) - screenHeight;
  if (diff > 0) {
    // CGRect contentFrame = contentTextBox.frame;
    CGRect tableFrame   = self.table.frame;
    // contentFrame.origin.y += diff;
    tableFrame.origin.y -= diff;
    if (tableFrame.origin.y <= -216) {
      if (tableFrameShifted) {
        [self scrollToBottom: YES];
      }
      else {
        [self scrollToBottom: NO];
      }
      // contentFrame.origin.y = self.table.contentSize.height - 
      //   contentTextBox.frame.size.height;
      // contentTextBox.frame  = contentFrame;
      tableFrame.origin.y   = -216;
      if (!tableFrameShifted) {
        self.table.frame  = tableFrame;
        tableFrameShifted = YES;
      }
    }
    void (^animations) (void) = ^(void) {
    //   contentTextBox.frame = contentFrame;
      self.table.frame     = tableFrame;
    };
    [UIView animateWithDuration: 0.15 delay: 0
      options: UIViewAnimationOptionCurveLinear animations: animations
        completion: nil];
  }
}

- (void) scrollToBottom: (BOOL) animated
{
  CGRect screen = [[UIScreen mainScreen] bounds];
  float height = self.table.contentSize.height - 
    (screen.size.height - (20 + 44));
  if (height > 0) {
    [self.table setContentOffset: CGPointMake(0, height) animated: animated];
  }
}

- (void) sendMessage
{
  NSString *content = contentTextView.text;
  if (![content isEqualToString: textViewPlaceholder] && content.length > 0) {
    contentTextView.text = @"";
    Message *newMessage  = [[Message alloc] init];
    newMessage.content   = content;
    newMessage.created   = [[NSDate date] timeIntervalSince1970];
    newMessage.recipient = message.sender;
    newMessage.sender    = [User currentUser];
    newMessage.uid       = 0;
    newMessage.viewed    = NO;
    NewMessageConnection *connection = 
      [[NewMessageConnection alloc] initWithMessage: newMessage];
    connection.completionBlock = ^(NSError *error) {
      if (!error) {
        [self fetchNewMessages];
      }
    };
    [connection start];
    [[MessageDetailStore sharedStore] addMessageFromRecipient: newMessage];
    [self.table reloadData];
    [self repositionTable];
  }
}

- (void) showKeyboard
{
  CGRect screen = [[UIScreen mainScreen] bounds];
  float screenHeight = screen.size.height - (20 + 44);
  float contentHeight = self.table.contentSize.height;
  float keyboardHeight = 216;
  void (^animations) (void) = nil;
  float diff = screenHeight - (contentHeight + keyboardHeight);
  if (diff < 0) {
    if (diff < keyboardHeight * -1) {
      diff = keyboardHeight * -1;
    }
    CGRect frame = self.table.frame;
    frame.origin.y = diff;
    CGRect contentFrame = contentTextBox.frame;
    // contentFrame.origin.y -= (diff + keyboardHeight);
    contentFrame.origin.y -= 216;
    animations = ^(void) {
      contentTextBox.frame = contentFrame;
      self.table.frame = frame;
    };
  }
  else {
    CGRect frame = contentTextBox.frame;
    frame.origin.y -= 216;
    animations = ^(void) {
      contentTextBox.frame = frame;
    };
  }
  if (animations) {
    [UIView animateWithDuration: 0.15 delay: 0
      options: UIViewAnimationOptionCurveLinear animations: animations
        completion: nil];
  }
}

- (void) tableFrameShouldBeShifted
{
  CGRect screen        = [[UIScreen mainScreen] bounds];
  float screenHeight   = screen.size.height - (20 + 44);
  float offset         = self.table.frame.origin.y; // -10
  float height         = self.table.contentSize.height; // 100
  float adjustedHeight = height + offset;
  float diff = (adjustedHeight + 216) - screenHeight;
  if (diff > 0) {
    float y = self.table.frame.origin.y;
    if (y - diff <= -216) {
      if (!tableFrameShifted) {
        tableFrameShifted = YES;
      }
    }
  }
}

@end
