//
//  BecomeAMemberViewController.m
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/19/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import "BecomeAMemberViewController.h"
#import "SideMenuViewController.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface BecomeAMemberViewController ()

@end

@implementation BecomeAMemberViewController
@synthesize type, nameoofganization, organizationwebsite,contactPerson, jobtitle, email, contactnumber, fillup, emailSent;

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
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                  bundle:nil];
    smvc = [sb instantiateViewControllerWithIdentifier:@"sidebarviewcontroller"];
    smvc.view.frame= CGRectMake(-54, self.view.frame.size.height-356, 54, 356);
    [self.view addSubview:smvc.view];
    
    [smvc colorButton:@"6"];
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         smvc.view.frame= CGRectMake(0, self.view.frame.size.height-356, 54, 356);
                     }completion:^(BOOL finished){
                         
                     }];
    
    self.fillup.hidden = YES;
    self.emailSent.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showMenu:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


-(IBAction)sendEmail:(id)sender{
    NSString *typeText= [type.text lowercaseString];
    NSString *organizationText= nameoofganization.text;
    NSString *websiteText= organizationwebsite.text;
    NSString *personText= contactPerson.text;
    NSString *titleText= jobtitle.text;
    NSString *emailText= email.text;
    NSString *numberText= contactnumber.text;
    
    if ([typeText isEqualToString:@"gold"]|| [typeText isEqualToString:@"silver"] || [typeText isEqualToString:@"platinum"]) {
        if ([typeText isEqualToString:@""]||[organizationText isEqualToString:@""]|| [websiteText isEqualToString:@""]|| [personText isEqualToString:@""]||[titleText isEqualToString:@""]||[emailText isEqualToString:@""]||[numberText isEqualToString:@""]) {
            self.fillup.hidden = NO;
        }else{
            self.fillup.hidden= YES;
            NSString *emailBody= [NSString stringWithFormat:@"I am intereseted in applying for a membership at FTTH Council. Please find my Details below: <hr/><br></b>Organization name: </b>%@, <br></b>Type: %@, <br>Website:</b>%@,<br></b>Contact person: </b>%@,<br> Title:</b>%@, <br></b>Email: </b>%@,<br></b>Contact Number: </b>%@ <hr/> Thank you.", organizationText, typeText, websiteText, personText, titleText, emailText, numberText];
            
            MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
            controller.mailComposeDelegate = self;
            [controller setToRecipients:[NSArray arrayWithObject:@"app@ftthcouncilap.org"]];
            [controller setSubject:@"Application for FTTH membership"];
            [controller setMessageBody:emailBody isHTML:YES];
            if (controller) [self presentViewController:controller animated:NO completion:nil];
            
        }
    }else{
        [type setText:@"platinum"];
        typeText= @"platinum";
    }
    
    }

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        //        NSLog(@"It's away!");
        self.emailSent.hidden = NO;
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(IBAction)membershipInfo:(id)sender{
    NSURL *url= [NSURL URLWithString:@"http://ftthcouncilap.org/membership-information"];
    [[UIApplication sharedApplication]openURL:url];
}
@end
