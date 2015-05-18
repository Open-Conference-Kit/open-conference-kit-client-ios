//
//  ConferenceViewController.m
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/26/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import "ConferenceViewController.h"
#import "Director.h"
#import "EXPhotoViewer.h"

#define METERS_PER_MILE 1609.344

@interface ConferenceViewController ()

@end

@implementation ConferenceViewController
@synthesize circularBtn1, circularBtn2, circularBtn3, circularBtn4, circularBtn5, circularBtn6;
@synthesize circularBtn1String, circularBtn2String, circularBtn3String, circularBtn4String, circularBtn5String, circularBtn6String;
@synthesize circularBtnMash;
@synthesize titleOfScreen;
@synthesize detailText;
@synthesize upcomingbutton, previousbutton;
@synthesize circularBtnMashBg;
@synthesize conferenceTeamTable;
@synthesize venueView, sponsorsView;
@synthesize mapView;
@synthesize sponsorsTeamTable;
@synthesize sponsorsTable;
@synthesize logoPic;
@synthesize sponsorType;
@synthesize upcoming;
@synthesize hotelImage, hotelAddress, hotelPhone;
@synthesize conferencedescription;
@synthesize hotelName;
@synthesize hotelUrl;

static NSString * const BaseURLString = @"http://192.185.144.22/~ftthapi/index.php/ftthapi/";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setPinOnMap:(float)latitude longitude:(float)longitude
{
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = latitude;
    zoomLocation.longitude= longitude;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1*METERS_PER_MILE, 1*METERS_PER_MILE);
    
    MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
    annot.coordinate = zoomLocation;
    [self.mapView addAnnotation:annot];
    
    // 3
    [mapView setRegion:viewRegion animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    circularBtnMash.layer.opacity= 0.0;
    circularBtnMashBg.layer.opacity= 0.0;
    
    titleOfScreen.layer.opacity= 0.0;
    detailText.layer.opacity= 0.0;
    
    conferenceTeamTable.layer.opacity= 0.0;
    venueView.layer.opacity =0.0;
    sponsorsView.layer.opacity =0.0;
}

- (void)addSideBar
{
	// Do any additional setup after loading the view.
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                  bundle:nil];
    smvc = [sb instantiateViewControllerWithIdentifier:@"sidebarviewcontroller"];
    smvc.view.frame= CGRectMake(-54, self.view.frame.size.height-356, 54, 356);
    [self.view addSubview:smvc.view];
    [smvc colorButton:@"2"];
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         smvc.view.frame= CGRectMake(0, self.view.frame.size.height-356, 54, 356);
                     }completion:^(BOOL finished){
                         
                     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSideBar];
    
    self.upcomingbutton.layer.opacity= 0.0;
    self.previousbutton.layer.opacity= 0.0;
    
    NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
    self.conferencedescription.text = [prefs objectForKey:@"conferenceTextAsString"];
    [self.conferencedescription setTextColor:[UIColor whiteColor]];
    
    circularBtn1String= NSStringFromCGRect(circularBtn1.frame);
    circularBtn2String= NSStringFromCGRect(circularBtn2.frame);
    circularBtn3String= NSStringFromCGRect(circularBtn3.frame);
    circularBtn4String= NSStringFromCGRect(circularBtn4.frame);
    circularBtn5String= NSStringFromCGRect(circularBtn5.frame);
    circularBtn6String= NSStringFromCGRect(circularBtn6.frame);
    
    NSMutableParagraphStyle *style= [[NSMutableParagraphStyle alloc]init];
    [style setAlignment:NSTextAlignmentCenter];
    
    
    
    directors = [[NSMutableArray alloc]init];
    sponsors = [[NSMutableArray alloc]init];
    
    self.conferenceTeamTable.backgroundColor= [UIColor clearColor];
    
    float latitude  = 5.263;
    float longitude = 100.484;
    
    [self setPinOnMap:latitude longitude:longitude];
    
    upcoming= @"YES";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showMenu:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showConferenceTableWithAnimation {
    [UIView animateWithDuration:0.25
                          delay:1.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         conferenceTeamTable.layer.opacity= 1.0;
                     }completion:^(BOOL finished){
                         
                     }];
}

- (void)showSponsorsWithAnimation {
    [UIView animateWithDuration:0.25
                          delay:1.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         sponsorsView.layer.opacity= 1.0;
                     }completion:^(BOOL finished){
                         
                     }];
}

-(IBAction)buttonGrow:(id)sender{
    self.conferencedescription.layer.opacity= 0.0;
    
    UIButton *btn= (UIButton *)sender;
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [[self.view viewWithTag:234] removeFromSuperview];
                         
                         circularBtn1.transform= CGAffineTransformIdentity;
                         circularBtn2.transform= CGAffineTransformIdentity;
                         circularBtn3.transform= CGAffineTransformIdentity;
                         circularBtn4.transform= CGAffineTransformIdentity;
                         circularBtn5.transform= CGAffineTransformIdentity;
                         circularBtn6.transform= CGAffineTransformIdentity;
                         
                         switch (btn.tag) {
                             case 1:
                                 [btn setBackgroundImage:[UIImage imageNamed:@"venue_selected"] forState:UIControlStateNormal];
                                 self.conferencedescription.layer.opacity= 0.0;
                                 [self showVenue:Nil];
                                 [self upcomingButton:Nil];
                                 break;
                             case 2:
                                 [btn setBackgroundImage:[UIImage imageNamed:@"agenda_selected"] forState:UIControlStateNormal];
                                 break;
                             case 3:
                                 [btn setBackgroundImage:[UIImage imageNamed:@"conference_team_selected"] forState:UIControlStateNormal];
                                 [self showConferenceTableWithAnimation];
                                 [self reloadTableWithURL:@"conferenceTeam"];
                                 break;
                             case 4:
                                 [btn setBackgroundImage:[UIImage imageNamed:@"speakers_selected"] forState:UIControlStateNormal];
                                 [self showSpeakers:nil];
                                 break;
                             case 5:
                                 [btn setBackgroundImage:[UIImage imageNamed:@"sponsors_selected"] forState:UIControlStateNormal];
                                 [self showSponsors:nil];
                                 break;
                             case 6:
                                 [btn setBackgroundImage:[UIImage imageNamed:@"floor_plan_selected"] forState:UIControlStateNormal];
                                 [self floorPlanPicture:nil];
                                 break;
                                 
                             default:
                                 break;
                         }
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.25
                                               delay:0.25
                                             options: UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              btn.transform = CGAffineTransformIdentity;
                                          }
                                          completion:^(BOOL finished){
                                              [UIView animateWithDuration:0.5
                                                                    delay:0.5
                                                                  options: UIViewAnimationOptionCurveEaseIn
                                                               animations:^{
                                                                   
                                                                   circularBtn1.transform= CGAffineTransformScale(circularBtn1.transform, 0.7, 0.7);
                                                                   circularBtn1.layer.opacity=0.0;
                                                                   circularBtn2.transform= CGAffineTransformScale(circularBtn2.transform, 0.7, 0.7);
                                                                   circularBtn2.layer.opacity=0.0;
                                                                   circularBtn3.transform= CGAffineTransformScale(circularBtn3.transform, 0.7, 0.7);
                                                                   circularBtn3.layer.opacity=0.0;
                                                                   circularBtn4.transform= CGAffineTransformScale(circularBtn4.transform, 0.7, 0.7);
                                                                   circularBtn4.layer.opacity=0.0;
                                                                   circularBtn5.transform= CGAffineTransformScale(circularBtn5.transform, 0.7, 0.7);
                                                                   circularBtn5.layer.opacity=0.0;
                                                                   circularBtn6.transform= CGAffineTransformScale(circularBtn6.transform, 0.7, 0.7);
                                                                   circularBtn6.layer.opacity=0.0;
                                                                   
                                                                   circularBtn1.frame= CGRectMake(circularBtnMash.frame.origin.x+circularBtnMash.frame.size.width/2, circularBtnMash.frame.origin.y, circularBtn1.frame.size.width, circularBtn1.frame.size.height);
                                                                   circularBtn2.frame= CGRectMake(circularBtnMash.frame.origin.x+circularBtnMash.frame.size.width/2, circularBtnMash.frame.origin.y, circularBtn2.frame.size.width, circularBtn2.frame.size.height);;
                                                                   circularBtn3.frame= CGRectMake(circularBtnMash.frame.origin.x+circularBtnMash.frame.size.width/2, circularBtnMash.frame.origin.y, circularBtn3.frame.size.width, circularBtn3.frame.size.height);
                                                                   circularBtn4.frame= CGRectMake(circularBtnMash.frame.origin.x+circularBtnMash.frame.size.width/2, circularBtnMash.frame.origin.y, circularBtn4.frame.size.width, circularBtn4.frame.size.height);
                                                                   circularBtn5.frame= CGRectMake(circularBtnMash.frame.origin.x+circularBtnMash.frame.size.width/2, circularBtnMash.frame.origin.y, circularBtn5.frame.size.width, circularBtn5.frame.size.height);
                                                                   circularBtn6.frame= CGRectMake(circularBtnMash.frame.origin.x+circularBtnMash.frame.size.width/2, circularBtnMash.frame.origin.y, circularBtn6.frame.size.width, circularBtn6.frame.size.height);
                                                                   
                                                                   circularBtnMash.layer.opacity   = 1.0;
                                                                   circularBtnMashBg.layer.opacity = 1.0;
                                                               }
                                                               completion:^(BOOL finished){
                                                                   [UIView animateWithDuration:0.25
                                                                                         delay:0.0
                                                                                       options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                                                                                    animations:^{
                                                                                        
                                                                                        if (btn.tag ==3) {
                                                                                            titleOfScreen.text= @"CONFERENCE TEAM";
                                                                                        }
                                                                                        else{
                                                                                            titleOfScreen.text= btn.titleLabel.text;
                                                                                        }
                                                                                        
                                                                                        titleOfScreen.layer.opacity= 1.0;
                                                                                        detailText.layer.opacity= 1.0;
                                                                                        
                                                                                    }completion:^(BOOL finished){
                                                                                        
                                                                                        if (btn.tag ==2 ) {
                                                                                            NSURL *url= [NSURL URLWithString:@"http://ftthapi.com/uploads/Annual_Conference_Program.pdf"];
                                                                                            [[UIApplication sharedApplication]openURL:url];
                                                                                        }
                                                                                        
                                                                                    }];
                                                                   
                                                               }];
                                          }];
                     }];
}

-(IBAction)buttonGoBack:(id)sender{
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [[self.view viewWithTag:234] removeFromSuperview];
                         self.upcomingbutton.layer.opacity= 0.0;
                         self.previousbutton.layer.opacity= 0.0;
                         
                         for (int i=1; i<7; i++) {
                             UIButton *btn= (UIButton *)[self.view viewWithTag:i];
                             switch (i) {
                                 case 1:
                                     [btn setBackgroundImage:[UIImage imageNamed:@"venue_button"] forState:UIControlStateNormal];
                                     self.venueView.layer.opacity =0.0;
                                     self.conferencedescription.layer.opacity = 1.0;
                                     break;
                                 case 2:
                                     [btn setBackgroundImage:[UIImage imageNamed:@"agenda_button"] forState:UIControlStateNormal];
                                     break;
                                 case 3:
                                     [btn setBackgroundImage:[UIImage imageNamed:@"conference_button"] forState:UIControlStateNormal];
                                     conferenceTeamTable.layer.opacity= 0.0;
                                     [self reloadTableWithURL:@"conferenceTeam"];
                                     break;
                                 case 4:
                                     [btn setBackgroundImage:[UIImage imageNamed:@"speakers_button"] forState:UIControlStateNormal];
                                     break;
                                 case 5:
                                     [btn setBackgroundImage:[UIImage imageNamed:@"sponsors_button"] forState:UIControlStateNormal];
                                     self.sponsorsView.layer.opacity =0.0;
                                     break;
                                 case 6:
                                     [btn setBackgroundImage:[UIImage imageNamed:@"floor_plan_button"] forState:UIControlStateNormal];
                                     break;
                                     
                                 default:
                                     break;
                             }
                         }
                         
                         
                         
                         titleOfScreen.layer.opacity= 0.0;
                         detailText.layer.opacity= 0.0;
                         
                         circularBtn1.layer.opacity=1.0;
                         circularBtn2.layer.opacity=1.0;
                         circularBtn3.layer.opacity=1.0;
                         circularBtn4.layer.opacity=1.0;
                         circularBtn5.layer.opacity=1.0;
                         circularBtn6.layer.opacity=1.0;
                         
                         circularBtnMash.layer.opacity=0.0;
                         circularBtnMashBg.layer.opacity=0.0;
                         
                         circularBtn1.transform= CGAffineTransformIdentity;
                         circularBtn2.transform= CGAffineTransformIdentity;
                         circularBtn3.transform= CGAffineTransformIdentity;
                         circularBtn4.transform= CGAffineTransformIdentity;
                         circularBtn5.transform= CGAffineTransformIdentity;
                         circularBtn6.transform= CGAffineTransformIdentity;
                         
                         circularBtn1.frame= CGRectFromString(circularBtn1String);
                         circularBtn2.frame= CGRectFromString(circularBtn2String);
                         circularBtn3.frame= CGRectFromString(circularBtn3String);
                         circularBtn4.frame= CGRectFromString(circularBtn4String);
                         circularBtn5.frame= CGRectFromString(circularBtn5String);
                         circularBtn6.frame= CGRectFromString(circularBtn6String);
                     }completion:^(BOOL finished){
                         
                     }];
}

-(IBAction)upcomingButton:(id)sender{
    NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
    NSMutableArray *venueArray= [prefs objectForKey:@"venueAsString"];
    NSDictionary *venueDictionary= [venueArray objectAtIndex:0];
    
    NSString *name = [venueDictionary objectForKey:@"name"];
    NSString *url = [venueDictionary objectForKey:@"url"];
    NSString *picture = [venueDictionary objectForKey:@"picture"];
    float lattitude = [[venueDictionary objectForKey:@"lattitude"] floatValue];
    float longitude = [[venueDictionary objectForKey:@"longitude"] floatValue];
    NSString *phone = [venueDictionary objectForKey:@"phone"];
    NSString *address = [venueDictionary objectForKey:@"address"];
    //    NSString *pdf = [venueDictionary objectForKey:@"pdf"];
    
    
    [upcomingbutton setBackgroundImage:[UIImage imageNamed:@"activetabbackleft.png"] forState:UIControlStateNormal];
    [previousbutton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackright.png"] forState:UIControlStateNormal];
    
    NSString *picExists= [prefs objectForKey:picture];
    
    if ([picExists isEqualToString:@"YES"]) {
        [hotelImage setImage: [UIImage imageNamed:picture]];
    }
    else{
        [hotelImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.185.144.22/~ftthapi/uploads/%@", picture]] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
    }
    
    [hotelImage setContentMode:UIViewContentModeScaleAspectFill];
    [hotelName setText:name];
    [hotelAddress setText:address];
    [hotelUrl setText:url];
    [hotelPhone setTitle:phone forState:UIControlStateNormal];
    [self setPinOnMap:lattitude longitude:longitude];
}

-(IBAction)previousButton:(id)sender{
    NSLog(@"previous button pressed");
    NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
    NSMutableArray *venueArray= [prefs objectForKey:@"previousVenue"];
    NSDictionary *venueDictionary= [venueArray objectAtIndex:0];
    
    NSString *name = [venueDictionary objectForKey:@"name"];
    NSString *url = [venueDictionary objectForKey:@"url"];
    NSString *picture = [venueDictionary objectForKey:@"picture"];
    float lattitude = [[venueDictionary objectForKey:@"lattitude"] floatValue];
    float longitude = [[venueDictionary objectForKey:@"longitude"] floatValue];
    NSString *phone = [venueDictionary objectForKey:@"phone"];
    NSString *address = [venueDictionary objectForKey:@"address"];
    
    [upcomingbutton setBackgroundImage:[UIImage imageNamed:@"inactivetabbackleft.png"] forState:UIControlStateNormal];
    [previousbutton setBackgroundImage:[UIImage imageNamed:@"activetabbackright.png"] forState:UIControlStateNormal];
    
    NSString *picExists= [prefs objectForKey:picture];
    
    if ([picExists isEqualToString:@"YES"]) {
        [hotelImage setImage: [UIImage imageNamed:picture]];
    }
    else{
        [hotelImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.185.144.22/~ftthapi/uploads/%@", picture]] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
    }
    
    [hotelImage setContentMode:UIViewContentModeScaleAspectFill];
    [hotelName setText:name];
    [hotelUrl setText:url];
    [hotelAddress setText:address];
    [hotelPhone setTitle:phone forState:UIControlStateNormal];
    [self setPinOnMap:lattitude longitude:longitude];
}

-(IBAction)register:(id)sender{
    NSURL *url= [NSURL URLWithString:@"https://www.beaconevents.com/?regsite=32&form=1"];
    [[UIApplication sharedApplication]openURL:url];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == sponsorsTeamTable) {
        return [sponsors count]*100;
    }else
        return [directors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView != sponsorsTeamTable) {
        Director *dir= [directors objectAtIndex:indexPath.row];
        
        static NSString *CellIdentifier = @"conferencecellidentifier";
        
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
            NSLog(@"[%@ exists]", dir.picture);
        }
        else{
            [profilePic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.185.144.22/~ftthapi/uploads/%@", dir.picture]] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
            NSLog(@"[%@ loading]", dir.picture);
        }
        
        cell.backgroundColor= [UIColor clearColor];
        return cell;
    }else{
        Director *dir= [sponsors objectAtIndex: indexPath.row% [sponsors count]];
        
        static NSString *CellIdentifier = @"sponsorscellidentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        UILabel *name = (UILabel *)[cell.contentView viewWithTag:100];
        if ([dir.name isEqual: [NSNull null]]) {
            dir.name= @"NO NAME";
        }
        [name setText:dir.name];
        
        cell.backgroundColor= [UIColor clearColor];
        return cell;
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)reloadTableWithURL:(NSString *)string {
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
        
        NSLog(@"%@", dir.role);
        
        if (![dir.name isEqual: [NSNull null]]) {
            [directors addObject:dir];
        }
    }
    [self.conferenceTeamTable reloadData];
}


-(void)getTeam{
    [self reloadTableWithURL:@"conferenceTeam"];
}

-(IBAction)showVenue:(id)sender{
    [UIView animateWithDuration:0.25
                          delay:1.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.venueView.layer.opacity= 1.0;
                     }completion:^(BOOL finished){
                         self.previousbutton.layer.opacity= 1.0;
                         self.upcomingbutton.layer.opacity= 1.0;
                     }];
}

-(IBAction)floorPlanPicture:(id)sender{
    [UIView animateWithDuration:0.25
                          delay:1.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         
                         UIImageView *floorplanpic= [[UIImageView alloc]initWithFrame:self.conferenceTeamTable.frame];
                         floorplanpic.contentMode= UIViewContentModeScaleAspectFit;
                         
                         NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
                         floorplanpic.tag= 234;
                         [floorplanpic setImageWithURL:[NSURL URLWithString:[prefs objectForKey:@"floorPlanPicture"]] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
                         
                         
                         [self.view addSubview:floorplanpic];
                         
                         UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
                         singleTap.numberOfTapsRequired = 1;
                         floorplanpic.userInteractionEnabled = YES;
                         [floorplanpic addGestureRecognizer:singleTap];
                     }completion:^(BOOL finished){
                         
                     }];
}

-(IBAction)showSponsors:(id)sender{
    [sponsors removeAllObjects];
    
    NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
    NSArray *responseArray = (NSArray *)[prefs objectForKey:@"sponsorsAsString"];
    for (int i=0; i< [responseArray count]; i++) {
        NSDictionary *response= [responseArray objectAtIndex:i];
        
        NSString *sponsors_id =[response objectForKey:@"id"];
        NSString *sponsors_category =[response objectForKey:@"category"];
        NSString *sponsors_logo =[response objectForKey:@"logo"];
        NSString *sponsors_name =[response objectForKey:@"name"];
        NSString *sponsors_order =[response objectForKey:@"order"];
        
        NSLog(@"%@", sponsors_order);
        
        Director *dir= [[Director alloc]init];
        dir.directorId= sponsors_id;
        dir.name= sponsors_name;
        dir.description= @"";
        dir.picture= sponsors_logo;
        dir.role= [sponsors_category capitalizedString];
        
        [sponsors addObject:dir];
    }
    
    [self showSponsorsWithAnimation];
    [self.sponsorsTeamTable reloadData];
}

-(IBAction)showSpeakers:(id)sender{
    [directors removeAllObjects];
    
    NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
    NSArray *responseArray = (NSArray *)[prefs objectForKey:@"speakersAsString"];
    for (int i=0; i< [responseArray count]; i++) {
        NSDictionary *response= [responseArray objectAtIndex:i];
        
        NSString *speakers_id =[response objectForKey:@"id"];
        NSString *speakers_name =[response objectForKey:@"name"];
        NSString *speakers_role =[response objectForKey:@"role"];
        NSString *speakers_description =[response objectForKey:@"description"];
        NSString *speakers_picture =[response objectForKey:@"picture"];
        
        
        
        Director *dir= [[Director alloc]init];
        dir.directorId= speakers_id;
        dir.name= speakers_name;
        dir.description= speakers_description;
        
        if ([speakers_picture isEqualToString:@"error"]) {
            dir.picture= @"members.png";
        }
        else
            dir.picture= speakers_picture;
        
        dir.role= speakers_role;
        
        [directors addObject:dir];
    }
    [self.conferenceTeamTable reloadData];
    [self showConferenceTableWithAnimation];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == sponsorsTeamTable) {
        NSIndexPath *firstVisibleIndexPath = [[self.sponsorsTeamTable indexPathsForVisibleRows] objectAtIndex:0];
        
        NSUInteger actualRow;
        Director *dir;
        
        actualRow = firstVisibleIndexPath.row % [sponsors count];
        dir = [sponsors objectAtIndex:actualRow];
        
        
        NSLog(@"%@",dir.picture);
        
        NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
        NSString *logoExists= [prefs objectForKey:dir.picture];
        
        if ([logoExists isEqualToString:@"YES"]) {
            [logoPic setImage: [UIImage imageNamed:dir.picture ]];
        }
        else{
            [logoPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.185.144.22/~ftthapi/uploads/%@", dir.picture]] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
        }
        sponsorType.text= dir.role;
    }
}



-(void)tapDetected{
    [self resignFirstResponder];
    UIImageView *floorplanpic= (UIImageView *)[self.view viewWithTag:234];
    [EXPhotoViewer showImageFrom:floorplanpic];
}

-(IBAction)makePhoneCall:(id)sender{
    NSString *phoneNumber = [@"tel://" stringByAppendingString:@"+6046327000"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

-(IBAction)openPDFInSafari:(id)sender{
    NSURL *url= [NSURL URLWithString:@"http://ftthapi.com/uploads/driving_map_penangairport_hep1.pdf"];
    [[UIApplication sharedApplication]openURL:url];
}

@end
