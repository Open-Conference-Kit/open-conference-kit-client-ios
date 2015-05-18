//
//  StudiesAndSeminarViewController.m
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/19/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import "StudiesAndSeminarViewController.h"
#import "SideMenuViewController.h"

@interface StudiesAndSeminarViewController ()

@end

@implementation StudiesAndSeminarViewController
@synthesize descriptionView;
@synthesize descriptionString;
@synthesize urlString;
@synthesize latest;
@synthesize previous;
@synthesize descriptionView1;

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
    
    [smvc colorButton:@"4"];
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         smvc.view.frame= CGRectMake(0, self.view.frame.size.height-356, 54, 356);
                     }completion:^(BOOL finished){
                         
                     }];
    
    NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
    NSArray *responseArray=(NSArray *)[prefs objectForKey:@"latestStudiesString"];
    
    NSDictionary *latestDict= [responseArray objectAtIndex:0];
    descriptionString= [latestDict objectForKey:@"description"];
    [latestDict objectForKey:@"link"];
    
    [descriptionView setText:descriptionString];
    descriptionView.textColor= [UIColor whiteColor];
    
    NSArray *responseArray1=(NSArray *)[prefs objectForKey:@"previousStudiesString"];
    NSDictionary *previoustDict= [responseArray1 objectAtIndex:0];
    [previoustDict objectForKey:@"description"];
    [previoustDict objectForKey:@"link"];
    
    [self latestStudies:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showMenu:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(IBAction)previous:(id)sender{
    [self.latest setBackgroundImage:[UIImage imageNamed:@"inactivetabbackleft.png"] forState:UIControlStateNormal];
    [self.previous setBackgroundImage:[UIImage imageNamed:@"activetabbackright.png"] forState:UIControlStateNormal];
    
    [self.descriptionView1 setText:@"The solution for Mobile Broadband, Focus on APAC, Interim report "];
    
    NSURL *url= [NSURL URLWithString:@"http://ftthapi.com/uploads/Sri_Lanka_Workshop_Program.pdf"];
    [[UIApplication sharedApplication]openURL:url];
}

-(IBAction)latestStudies:(id)sender{
    [self.latest setBackgroundImage:[UIImage imageNamed:@"activetabbackleft.png"] forState:UIControlStateNormal];
    [self.previous setBackgroundImage:[UIImage imageNamed:@"inactivetabbackright.png"] forState:UIControlStateNormal];
    
    self.descriptionView1.text= @"The FTTH Council Asia-Pacific initiates multiple studies and reports on FTTH development with in the Asia-Pacific region. The Council also carries out various technical studies. The members of the council get access to all the latest studies. Please log on to the FTTH Council Asia-Pacific website to get access to the latest studies.";
}
@end
