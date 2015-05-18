//
//  FlipsideViewController.h
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/18/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuViewController.h"
#import "Director.h"
#import "UIImageView+WebCache.h"

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    SideMenuViewController *smvc;
    NSMutableArray *directors;
}

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, strong)IBOutlet UITextView *aboutInfo;

- (IBAction)done:(id)sender;

@property(nonatomic, strong) IBOutlet UIButton *aboutUsButton;
@property(nonatomic, strong) IBOutlet UIButton *directorButton;
@property(nonatomic, strong) IBOutlet UIButton *committeeButton;
@property(nonatomic, strong) IBOutlet UIButton *teamButton;

@property(nonatomic, strong) IBOutlet UITableView *directorsTable;

@property(nonatomic, strong) IBOutlet UIActivityIndicatorView *loading;

@end
