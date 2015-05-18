//
//  FlipsideViewController.m
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/18/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import "FlipsideViewController.h"
#import "SideMenuViewController.h"

static NSString * const BaseURLString = @"http://192.185.144.22/~ftthapi/index.php/ftthapi/";

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController
@synthesize aboutInfo;
@synthesize aboutUsButton, directorButton, committeeButton, teamButton;
@synthesize directorsTable;
@synthesize loading;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)addSideBar
{
	// Do any additional setup after loading the view, typically from a nib.
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                  bundle:nil];
    smvc = [sb instantiateViewControllerWithIdentifier:@"sidebarviewcontroller"];
    smvc.view.frame= CGRectMake(-54, self.view.frame.size.height-356, 54, 356);
    [self.view addSubview:smvc.view];
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         smvc.view.frame= CGRectMake(0, self.view.frame.size.height-356, 54, 356);
                     }completion:^(BOOL finished){
                         
                     }];
    
    [smvc colorButton:@"1"];
}

//-(void)viewWillAppear:(BOOL)animated{
//    [self addSideBar];
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addSideBar];
    
    NSString *string = [NSString stringWithFormat:@"%@getdatabyid/about", BaseURLString];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    directors= [[NSMutableArray alloc]init];
    
    NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
    NSString *aboutString= [prefs objectForKey:@"textaboutinfo"];
    
    if (aboutString.length > 0) {
        [self.aboutInfo setText:aboutString];
        self.aboutInfo.textColor= [UIColor whiteColor];
        [self.aboutInfo setFont:[UIFont systemFontOfSize:14]];
        [self.loading stopAnimating];
        
    }else{
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.loading startAnimating];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *responseArray = (NSArray *)responseObject;
            NSDictionary *response= [responseArray objectAtIndex:0];
            
            NSString *aboutString = [response objectForKey:@"textaboutinfo"];
            NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
            [prefs setObject:aboutString forKey:@"textaboutinfo"];
            
            [self.aboutInfo setText:aboutString];
            self.aboutInfo.textColor= [UIColor whiteColor];
            [self.aboutInfo setFont:[UIFont systemFontOfSize:14]];
            [self.loading stopAnimating];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                                message:@"Please check your internet connection!"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
            [self.loading stopAnimating];
        }];
        
        [operation start];
    }
    
    self.directorsTable.hidden= YES;
    self.directorsTable.backgroundColor= [UIColor clearColor];
}


- (void)reloadTableWithURL:(NSString *)string {
    
    self.directorsTable.layer.opacity= 0.0;
    [directors removeAllObjects];
    
    NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
    
    NSString *keys= [NSString stringWithFormat:@"%@String", string];
    NSArray  *responseArray= (NSArray *)[prefs objectForKey:keys];
    
    NSLog(@"%@", responseArray);
    
    for (int i=0 ; i< [responseArray count]; i++) {
        NSDictionary *director= [responseArray objectAtIndex:i];
        NSLog(@"%@", director);
        
        Director *dir= [[Director alloc]init];
        dir.name= [director objectForKey:@"name"];
        dir.directorId= [director objectForKey:@"id"];
        dir.description= [director objectForKey:@"description"];
        dir.order= [director objectForKey:@"order"];
        dir.picture= [director objectForKey:@"picture"];
        dir.role= [director objectForKey:@"role"];
        
        if (![dir.name isEqual: [NSNull null]]) {
            [directors addObject:dir];
        }
    }
    [self.directorsTable reloadData];
    
    self.directorsTable.layer.opacity= 1.0;
}


-(void)getDirectors{
    [self reloadTableWithURL:@"directors"];
}


-(void)getTeam{
    [self reloadTableWithURL:@"team"];
}

-(void)getCommittees{
    [self reloadTableWithURL:@"committees"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

-(IBAction)showMenu:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)aboutUs:(id)sender{
    [self.aboutUsButton setBackgroundImage:[UIImage imageNamed:@"activetabbackleft.png"] forState:UIControlStateNormal];
    [self.directorButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackright.png"] forState:UIControlStateNormal];
    
    [self.committeeButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackleft.png"] forState:UIControlStateNormal];
    
    [self.teamButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackright.png"] forState:UIControlStateNormal];
    
    self.directorsTable.hidden = YES;
    self.aboutInfo.hidden= NO;
}

-(IBAction)director:(id)sender{
    [self.aboutUsButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackleft.png"] forState:UIControlStateNormal];
    [self.directorButton setBackgroundImage:[UIImage imageNamed:@"activetabbackright.png"] forState:UIControlStateNormal];
    
    [self.committeeButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackleft.png"] forState:UIControlStateNormal];
    
    [self.teamButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackright.png"] forState:UIControlStateNormal];
    [self getDirectors];
    self.directorsTable.hidden = NO;
    self.aboutInfo.hidden= YES;
}

-(IBAction)committee:(id)sender{
    [self.aboutUsButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackleft.png"] forState:UIControlStateNormal];
    [self.directorButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackright.png"] forState:UIControlStateNormal];
    
    [self.committeeButton setBackgroundImage:[UIImage imageNamed:@"activetabbackleft.png"] forState:UIControlStateNormal];
    
    [self.teamButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackright.png"] forState:UIControlStateNormal];
    
    self.directorsTable.hidden = YES;
    
    [self getCommittees];
    self.directorsTable.hidden = NO;
    self.aboutInfo.hidden= YES;
}

-(IBAction)team:(id)sender{
    [self.aboutUsButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackleft.png"] forState:UIControlStateNormal];
    [self.directorButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackright.png"] forState:UIControlStateNormal];
    
    [self.committeeButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackleft.png"] forState:UIControlStateNormal];
    
    [self.teamButton setBackgroundImage:[UIImage imageNamed:@"activetabbackright.png"] forState:UIControlStateNormal];
    
    [self getTeam];
    self.directorsTable.hidden = NO;
    self.aboutInfo.hidden= YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [directors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Director *dir= [directors objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"cellidentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:10];
    if ([dir.name isEqual: [NSNull null]]) {
        dir.name= @"NO NAME";
    }
    [name setText:dir.name];
    
    UILabel *role = (UILabel *)[cell.contentView viewWithTag:12];
    if ([dir.role isEqual: [NSNull null]]) {
        dir.role= @"NO ROLE";
    }
    [role setText:dir.role];
    
    UILabel *description = (UILabel *)[cell.contentView viewWithTag:13];
    if ([dir.description isEqual: [NSNull null]]) {
        dir.description= @"NO DESCRIPTION";
    }
    [description setText:dir.description];
    
    UIImageView *profilePic = (UIImageView *)[cell.contentView viewWithTag:11];
    
    NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
    NSString *picExists= [prefs objectForKey:dir.picture];
    
    if ([picExists isEqualToString:@"YES"]) {
        [profilePic setImage: [UIImage imageNamed:dir.picture ]];
    }
    else{
        [profilePic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.185.144.22/~ftthapi/uploads/%@", dir.picture]] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
    }
    
    cell.backgroundColor= [UIColor clearColor];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
@end
