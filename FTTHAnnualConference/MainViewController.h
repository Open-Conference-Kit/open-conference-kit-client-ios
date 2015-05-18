//
//  MainViewController.h
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/18/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import "FlipsideViewController.h"
#import "SideMenuViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate>{
    SideMenuViewController *smvc;
    NSMutableArray *directors;
}

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property (strong, nonatomic) IBOutlet UIImageView *cover;

@property(nonatomic, strong) IBOutlet UIButton *facebook;
@property(nonatomic, strong) IBOutlet UIButton *twitter;
@property(nonatomic, strong) IBOutlet UIButton *blogger;
@property(nonatomic, strong) IBOutlet UIButton *linkedin;

@property(nonatomic, strong) IBOutlet UIActivityIndicatorView *activity;
@property(nonatomic, strong) IBOutlet UILabel *downloadingInformation;

@property(nonatomic, strong) IBOutlet UILabel *internet;

@property(nonatomic, strong) NSString *dataDownloaded;

-(void)showCouncilPage:(id)sender;
-(void)showConferencePage:(id)sender;
-(void)showWorkshopPage:(id)sender;
-(void)showPresentationPage:(id)sender;
-(void)showMemberPage:(id)sender;
-(void)showBecomeAMemberPage:(id)sender;

-(IBAction)blackBarAnimation:(id)sender;
@end
