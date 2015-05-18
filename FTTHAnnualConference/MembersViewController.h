//
//  MembersViewController.h
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/19/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuViewController.h"

@interface MembersViewController : UIViewController{
    SideMenuViewController *smvc;
}

@property (nonatomic, strong) NSMutableArray *members;
@property (nonatomic, strong) NSMutableArray *platinumMembers;
@property (nonatomic, strong) NSMutableArray *goldMembers;
@property (nonatomic, strong) NSMutableArray *silverMembers;

@property(nonatomic, strong) IBOutlet UITableView *membersTable;
@property(nonatomic, strong) IBOutlet UIActivityIndicatorView *loading;
@property(nonatomic, strong) IBOutlet UIImageView *logoPic;

@property(nonatomic, strong) IBOutlet UIButton *allMemberButton;
@property(nonatomic, strong) IBOutlet UIButton *platinumMemberButton;
@property(nonatomic, strong) IBOutlet UIButton *goldMemberButton;
@property(nonatomic, strong) IBOutlet UIButton *silverMemberButton;

@property(nonatomic, strong) NSString *userType;
@end