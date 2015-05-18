//
//  SideMenuViewController.h
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/19/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuViewController : UIViewController

@property(nonatomic, strong) NSString *noBackGround;

@property(nonatomic, strong) IBOutlet UIButton *showCouncil;
@property(nonatomic, strong) IBOutlet UIButton *showConference;
@property(nonatomic, strong) IBOutlet UIButton *showWorkshop;
@property(nonatomic, strong) IBOutlet UIButton *showPresentation;
@property(nonatomic, strong) IBOutlet UIButton *showMember;
@property(nonatomic, strong) IBOutlet UIButton *showBecomeAMember;


-(void)colorButton:(NSString *)buttonNo;
@end
