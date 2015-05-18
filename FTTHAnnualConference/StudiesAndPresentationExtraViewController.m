//
//  StudiesAndPresentationExtraViewController.m
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 5/17/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import "StudiesAndPresentationExtraViewController.h"

@interface StudiesAndPresentationExtraViewController ()

@end

@implementation StudiesAndPresentationExtraViewController
@synthesize previousStudies;

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
    studiesArray= [prefs objectForKey:@"previousStudiesString"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [studiesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"previousstudiescell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *studies= [studiesArray objectAtIndex:indexPath.row];
    
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:45];
    [name setText: [studies objectForKey:@"description"]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *studies= [studiesArray objectAtIndex:indexPath.row];
    
    NSString *urlString = [NSString stringWithFormat:@"http://ftthapi.com/uploads/%@",[studies objectForKey:@"file"]];
    NSURL *url= [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication]openURL:url];
}

@end
