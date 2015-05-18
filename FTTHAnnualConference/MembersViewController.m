//
//  MembersViewController.m
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/19/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import "MembersViewController.h"
#import "SideMenuViewController.h"
#import "Member.h"
#import "UIImageView+WebCache.h"

@interface MembersViewController ()

@end

@implementation MembersViewController
@synthesize members, platinumMembers, goldMembers, silverMembers;
@synthesize membersTable;
@synthesize loading;
@synthesize logoPic;
@synthesize allMemberButton, platinumMemberButton, goldMemberButton, silverMemberButton;
@synthesize userType;

static NSString * const BaseURLString = @"http://192.185.144.22/~ftthapi/index.php/ftthapi/";

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
    
    [smvc colorButton:@"5"];
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         smvc.view.frame= CGRectMake(0, self.view.frame.size.height-356, 54, 356);
                     }completion:^(BOOL finished){
                         
                     }];
    
    members= [[NSMutableArray alloc]init];
    platinumMembers= [[NSMutableArray alloc]init];
    goldMembers= [[NSMutableArray alloc]init];
    silverMembers= [[NSMutableArray alloc]init];
    
    self.membersTable.layer.opacity= 0.0;
    self.membersTable.backgroundColor= [UIColor clearColor];
    
    [self showAllMembers:nil];
}

- (void)reloadTableWithURL:(NSString *)string{
    self.membersTable.layer.opacity= 0.0;
    [self.loading startAnimating];
    
    NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
    NSArray *responseArray=(NSArray *)[prefs objectForKey:@"membersString"];
    
    
    for (int i=0 ; i< [responseArray count]; i++) {
        NSDictionary *member= [responseArray objectAtIndex:i];
        NSLog(@"%@", member);
        
        Member *mem= [[Member alloc]init];
        mem.memberid= [member objectForKey:@"id"];
        mem.name= [member objectForKey:@"name"];
        mem.logo= [member objectForKey:@"logo"];
        mem.category= [member objectForKey:@"category"];
        mem.order= [member objectForKey:@"order"];
        
        if (![mem.name isEqual: [NSNull null]]) {
            [members addObject:mem];
            if ([mem.category isEqualToString:@"gold"]) {
                [goldMembers addObject:mem];
            }else if ([mem.category isEqualToString:@"platinum"]) {
                [platinumMembers addObject:mem];
                NSLog(@"platinum member [%@]", mem.name);
            }else if ([mem.category isEqualToString:@"silver"]){
                [silverMembers addObject:mem];
            }
        }
    }
    
    [self.membersTable reloadData];
    
    [self.loading stopAnimating];
    self.membersTable.layer.opacity= 1.0;
    
    Member *mem= (Member *)[members objectAtIndex:0];
    
    NSString *logoExists= [prefs objectForKey:mem.logo];
    if ([logoExists isEqualToString:@"YES"]) {
        logoPic.image = [UIImage imageNamed:mem.logo];
    }
    else{
        [logoPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.185.144.22/~ftthapi/uploads/%@", mem.logo]] placeholderImage:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showMenu:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)showAllMembers:(id)sender{
    NSString *string = [NSString stringWithFormat:@"%@getdata_byorder/members", BaseURLString];
    NSLog(@"[%@]",string);
    
    [self reloadTableWithURL:string];
    
    [self.allMemberButton setBackgroundImage:[UIImage imageNamed:@"activetabbackleft.png"] forState:UIControlStateNormal];
    [self.platinumMemberButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackright.png"] forState:UIControlStateNormal];
    [self.goldMemberButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackleft.png"] forState:UIControlStateNormal];
    [self.silverMemberButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackright.png"] forState:UIControlStateNormal];
    
    userType= @"all";
}

-(IBAction)showPlatinumMembers:(id)sender{
    [self.allMemberButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackleft.png"] forState:UIControlStateNormal];
    [self.platinumMemberButton setBackgroundImage:[UIImage imageNamed:@"activetabbackright.png"] forState:UIControlStateNormal];
    [self.goldMemberButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackleft.png"] forState:UIControlStateNormal];
    [self.silverMemberButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackright.png"] forState:UIControlStateNormal];
    
    userType= @"platinum";
    
    [self.membersTable reloadData];
}

-(IBAction)showGoldMembers:(id)sender{
    [self.allMemberButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackleft.png"] forState:UIControlStateNormal];
    [self.platinumMemberButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackright.png"] forState:UIControlStateNormal];
    [self.goldMemberButton setBackgroundImage:[UIImage imageNamed:@"activetabbackleft.png"] forState:UIControlStateNormal];
    [self.silverMemberButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackright.png"] forState:UIControlStateNormal];
    
    userType= @"gold";
    
    [self.membersTable reloadData];
}

-(IBAction)showSilverMembers:(id)sender{
    [self.allMemberButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackleft.png"] forState:UIControlStateNormal];
    [self.platinumMemberButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackright.png"] forState:UIControlStateNormal];
    [self.goldMemberButton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackleft.png"] forState:UIControlStateNormal];
    [self.silverMemberButton setBackgroundImage:[UIImage imageNamed:@"activetabbackright.png"] forState:UIControlStateNormal];
    
    userType= @"silver";
    
    [self.membersTable reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger totalRow;
    
    if ([userType isEqualToString:@"all"]) {
        totalRow= [members count]*100;
    }else if ([userType isEqualToString:@"platinum"]) {
        totalRow= [platinumMembers count]*100;
    }else if ([userType isEqualToString:@"gold"]) {
        totalRow= [goldMembers count]*100;
    }else if ([userType isEqualToString:@"silver"]) {
        totalRow= [silverMembers count];
    }else
        totalRow= [members count]*100;
    
    return totalRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger actualRow;
    Member *mem;
    
    if ([userType isEqualToString:@"all"]) {
        actualRow = indexPath.row % [members count];
        mem = [members objectAtIndex:actualRow];
    }else if ([userType isEqualToString:@"platinum"]) {
        actualRow = indexPath.row % [platinumMembers count];
        mem = [platinumMembers objectAtIndex:actualRow];
    }else if ([userType isEqualToString:@"gold"]) {
        actualRow = indexPath.row % [goldMembers count];
        mem = [goldMembers objectAtIndex:actualRow];
    }else if ([userType isEqualToString:@"silver"]) {
        actualRow = indexPath.row % [silverMembers count];
        mem = [silverMembers objectAtIndex:actualRow];
    }
    
    static NSString *CellIdentifier = @"membercellidentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:10];
    if ([mem.name isEqual: [NSNull null]]) {
        mem.name= @"NO NAME";
    }
    [name setText:mem.name];
    
    cell.backgroundColor= [UIColor clearColor];
    
    if (indexPath.row== 0) {
        NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
        NSString *logoExists= [prefs objectForKey:mem.logo];
        if ([logoExists isEqualToString:@"YES"]) {
            logoPic.image = [UIImage imageNamed:mem.logo];
        }
        else{
            [logoPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.185.144.22/~ftthapi/uploads/%@", mem.logo]] placeholderImage:nil];
        }
    }
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (![userType isEqualToString:@"silver"]) {
        NSIndexPath *firstVisibleIndexPath = [[self.membersTable indexPathsForVisibleRows] objectAtIndex:0];
        
        NSUInteger actualRow;
        Member *mem;
        
        if ([userType isEqualToString:@"all"]) {
            actualRow = firstVisibleIndexPath.row % [members count];
            mem = [members objectAtIndex:actualRow];
        }else if ([userType isEqualToString:@"platinum"]) {
            actualRow = firstVisibleIndexPath.row % [platinumMembers count];
            mem = [platinumMembers objectAtIndex:actualRow];
        }else if ([userType isEqualToString:@"gold"]) {
            actualRow = firstVisibleIndexPath.row % [goldMembers count];
            mem = [goldMembers objectAtIndex:actualRow];
        }else if ([userType isEqualToString:@"silver"]) {
            actualRow = firstVisibleIndexPath.row % [silverMembers count];
            mem = [silverMembers objectAtIndex:actualRow];
        }
        
        NSLog(@"%@",mem.logo);
        
        NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
        NSString *logoExists= [prefs objectForKey:mem.logo];
        
        if ([logoExists isEqualToString:@"YES"]) {
            [logoPic setImage: [UIImage imageNamed:mem.logo ]];
        }
        else{
            [logoPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.185.144.22/~ftthapi/uploads/%@", mem.logo]] placeholderImage:nil];
        }
    }
}

-(void)showEffect{
    NSString *membertableframe= NSStringFromCGRect(self.membersTable.frame);
    
    self.membersTable.frame= CGRectMake(self.membersTable.frame.origin.x, 480, self.membersTable.frame.size.width, self.membersTable.frame.size.height);
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.membersTable.frame= CGRectFromString(membertableframe);
                         
                     }completion:^(BOOL finished){
                         
                     }];
    
    
}

@end
