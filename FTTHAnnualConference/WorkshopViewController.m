//
//  WorkshopViewController.m
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/19/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import "WorkshopViewController.h"
#import "SideMenuViewController.h"
#import "UIImageView+WebCache.h"

@interface WorkshopViewController ()

@end

@implementation WorkshopViewController
@synthesize pictureView, description, title, details;
@synthesize pdf;

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
    
    [smvc colorButton:@"3"];
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         smvc.view.frame= CGRectMake(0, self.view.frame.size.height-356, 54, 356);
                     }completion:^(BOOL finished){
                         
                     }];
    
    NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
    NSMutableArray *workshopArray= [prefs objectForKey:@"workshopAsArray"];
    
    NSDictionary *dict= [workshopArray objectAtIndex:0];
    [description setText:[dict valueForKey:@"description"]];
    
    [title setText:[dict valueForKey:@"title"]];
    pdf= [dict valueForKey:@"pdf"];
    
    NSString *pictureString= [dict objectForKey:@"picture"];
    NSString *picExists= [prefs objectForKey: pictureString];
    
    if ([picExists isEqualToString:@"YES"]) {
        [pictureView setImage: [UIImage imageNamed:pictureString ]];
    }
    else{
        [pictureView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.185.144.22/~ftthapi/uploads/%@", pictureString]] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
    }
    
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
    NSURL *url= [NSURL URLWithString:[NSString stringWithFormat:@"http://ftthapi.com/uploads/%@", pdf]];
    [[UIApplication sharedApplication]openURL:url];
}

-(IBAction)register:(id)sender{
    NSURL *url= [NSURL URLWithString:@"https://www.beaconevents.com/?regsite=32&form=1"];
    [[UIApplication sharedApplication]openURL:url];
}

@end
