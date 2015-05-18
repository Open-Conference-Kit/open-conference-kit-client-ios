//
//  SideMenuViewController.m
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/19/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import "SideMenuViewController.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController
@synthesize showCouncil, showConference, showWorkshop, showPresentation, showMember,showBecomeAMember;
@synthesize noBackGround;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if ([noBackGround isEqualToString:@"YES"]) {
        showCouncil.layer.opacity= 0.0;
        showConference.layer.opacity= 0.0;
        showWorkshop.layer.opacity= 0.0;
        showPresentation.layer.opacity= 0.0;
        showMember.layer.opacity= 0.0;
        showBecomeAMember.layer.opacity= 0.0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showCouncilView:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showCouncilPage" object:nil];
}

-(IBAction)showConferenceView:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showConferencePage" object:nil];
}

-(IBAction)showWorkshopView:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showWorkshopPage" object:nil];
}

-(IBAction)showPresentationView:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showPresentationPage" object:nil];
}

-(IBAction)showMemberView:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showMemberPage" object:nil];
}

-(IBAction)showBecomeAMemberView:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showBecomeAMemberPage" object:nil];
}

-(void)colorButton:(NSString *)buttonNo{
    if ([buttonNo isEqualToString:@"1"]) {
        showCouncil.backgroundColor= [UIColor blackColor];
        showCouncil.layer.opacity= 0.5;
    }
    else if ([buttonNo isEqualToString:@"2"]) {
        showConference.backgroundColor= [UIColor blackColor];
        showConference.layer.opacity= 0.5;
    }
    else if ([buttonNo isEqualToString:@"3"]) {
        showWorkshop.backgroundColor= [UIColor blackColor];
        showWorkshop.layer.opacity= 0.5;
    }
    else if ([buttonNo isEqualToString:@"4"]) {
        showPresentation.backgroundColor= [UIColor blackColor];
        showPresentation.layer.opacity= 0.5;
    }
    else if ([buttonNo isEqualToString:@"5"]) {
        showMember.backgroundColor= [UIColor blackColor];
        showMember.layer.opacity= 0.5;
    }
    else if ([buttonNo isEqualToString:@"6"]) {
        showBecomeAMember.backgroundColor= [UIColor blackColor];
        showBecomeAMember.layer.opacity= 0.5;
    }
}
@end
