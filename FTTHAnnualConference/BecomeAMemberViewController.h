//
//  BecomeAMemberViewController.h
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/19/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuViewController.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface BecomeAMemberViewController : UIViewController<MFMailComposeViewControllerDelegate>{
    SideMenuViewController *smvc;
}

@property(nonatomic, strong) IBOutlet UITextField *type;
@property(nonatomic, strong) IBOutlet UITextField *nameoofganization;
@property(nonatomic, strong) IBOutlet UITextField *organizationwebsite;
@property(nonatomic, strong) IBOutlet UITextField *contactPerson;
@property(nonatomic, strong) IBOutlet UITextField *jobtitle;
@property(nonatomic, strong) IBOutlet UITextField *email;
@property(nonatomic, strong) IBOutlet UITextField *contactnumber;

@property(nonatomic, strong) IBOutlet UILabel *fillup;
@property(nonatomic, strong) IBOutlet UILabel *emailSent;

-(IBAction)membershipInfo:(id)sender;
@end
