//
//  MainViewController.m
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/18/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import "MainViewController.h"
#import "SideMenuViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize cover;
@synthesize facebook, twitter, blogger, linkedin;
@synthesize activity;
@synthesize downloadingInformation;
@synthesize internet;
@synthesize dataDownloaded;

- (void)addSideBar
{
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                  bundle:nil];
    smvc = [sb instantiateViewControllerWithIdentifier:@"sidebarviewcontroller"];
    smvc.noBackGround= @"YES";
    
    smvc.view.frame= CGRectMake(-54, self.view.frame.size.height-356, 54, 356);
    [self.view addSubview:smvc.view];
    
    
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
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCouncilPage:) name:@"showCouncilPage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showConferencePage:) name:@"showConferencePage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showWorkshopPage:)  name:@"showWorkshopPage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPresentationPage:)  name:@"showPresentationPage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMemberPage:) name:@"showMemberPage"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBecomeAMemberPage:)  name:@"showBecomeAMemberPage" object:nil];
    
    directors= [[NSMutableArray alloc]init];
 
    
    if ([[[AFNetworkReachabilityManager sharedManager]localizedNetworkReachabilityStatusString] isEqualToString:@"Not Reachable"]) {
        
        cover.hidden= NO;
        downloadingInformation.hidden= YES;
        [activity stopAnimating];
        internet.hidden= NO;
    }else{
        
        internet.hidden= YES;
        [self getAllData];
        [self badGarbages];
    }
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if ([AFStringFromNetworkReachabilityStatus(status) isEqualToString:@"Not Reachable"] && ![self.dataDownloaded isEqualToString:@"YES"]) {
            
            cover.hidden= NO;
            downloadingInformation.hidden= YES;
            [activity stopAnimating];
            internet.hidden= NO;
        }
        else{
            
            internet.hidden= YES;
            [self getAllData];
            [self badGarbages];
        }
    }];

    
    
    if (self.view.frame.size.height == 480) {
        facebook.transform= CGAffineTransformScale(facebook.transform,0.7, 0.7);
        twitter.transform= CGAffineTransformScale(twitter.transform,0.7, 0.7);
        blogger.transform= CGAffineTransformScale(blogger.transform,0.7, 0.7);
        linkedin.transform= CGAffineTransformScale(linkedin.transform,0.7, 0.7);
    }
}

- (void)getAllData {
    NSURL *url = [NSURL URLWithString:@"http://ftthapi.com/index.php/ftthapi/getallapi"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [activity startAnimating];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [activity stopAnimating];
        self.downloadingInformation.hidden= YES;
        
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        
        NSMutableArray *aboutArray = [responseDictionary objectForKey:@"about"];
        NSDictionary *about =[aboutArray objectAtIndex:0];
        
        NSMutableArray *membersAsArray = [[responseDictionary objectForKey:@"members"]mutableCopy];
        for (int i=0; i< [membersAsArray count]; i++) {
            NSDictionary *dict= [membersAsArray objectAtIndex:i];
            if ([dict objectForKey:@"name"]== [NSNull null]) {
                [membersAsArray removeObjectAtIndex:i];
            }
        }
        
        
        NSMutableArray *conferenceTextAsArray = [[responseDictionary objectForKey:@"conference_text"]mutableCopy];
        NSString *conferenceTextAsString;
        for (int i=0; i< [conferenceTextAsArray count]; i++) {
            NSDictionary *dict= [conferenceTextAsArray objectAtIndex:i];
            if ([dict objectForKey:@"text"]== [NSNull null]) {
                [conferenceTextAsArray removeObjectAtIndex:i];
            }
            conferenceTextAsString= [dict objectForKey:@"text"];
        }
        
        NSMutableArray *directorsAsArray = [[responseDictionary objectForKey:@"directors"]mutableCopy];
        for (int i=0; i< [directorsAsArray count]; i++) {
            NSDictionary *dict= [directorsAsArray objectAtIndex:i];
            if ([dict objectForKey:@"name"]== [NSNull null]) {
                [directorsAsArray removeObjectAtIndex:i];
            }
        }
        
        
        NSMutableArray *committeeAsArray = [[responseDictionary objectForKey:@"committees"]mutableCopy];
        for (int i=0; i< [committeeAsArray count]; i++) {
            NSDictionary *dict= [committeeAsArray objectAtIndex:i];
            if ([dict objectForKey:@"name"]== [NSNull null]) {
                [committeeAsArray removeObjectAtIndex:i];
            }
        }
        
        NSMutableArray *teamAsArray = [[responseDictionary objectForKey:@"team"]mutableCopy];
        for (int i=0; i< [teamAsArray count]; i++) {
            NSDictionary *dict= [teamAsArray objectAtIndex:i];
            if ([dict objectForKey:@"name"]== [NSNull null]) {
                [teamAsArray removeObjectAtIndex:i];
            }
        }
        
        NSMutableArray *conferenceTeamAsArray = [[responseDictionary objectForKey:@"conference_team"]mutableCopy];
        for (int i=0; i< [conferenceTeamAsArray count]; i++) {
            NSDictionary *dict= [conferenceTeamAsArray objectAtIndex:i];
            if ([dict objectForKey:@"name"]== [NSNull null]) {
                [teamAsArray removeObjectAtIndex:i];
            }
        }
        
        NSMutableArray *latestStudiesAsArray = [[responseDictionary objectForKey:@"latest_studies"]mutableCopy];
        for (int i=0; i< [latestStudiesAsArray count]; i++) {
            NSDictionary *dict= [latestStudiesAsArray objectAtIndex:i];
            if ([dict objectForKey:@"name"]== [NSNull null]) {
                [latestStudiesAsArray removeObjectAtIndex:i];
            }
        }
        
        NSMutableArray *previousStudiesAsArray = [[responseDictionary objectForKey:@"previous_studies"]mutableCopy];
        for (int i=0; i< [previousStudiesAsArray count]; i++) {
            NSDictionary *dict= [previousStudiesAsArray objectAtIndex:i];
            if ([dict objectForKey:@"description"]== [NSNull null]) {
                [previousStudiesAsArray removeObjectAtIndex:i];
            }
        }
        
        NSMutableArray *workshopAsArray = [[responseDictionary objectForKey:@"previous"]mutableCopy];
        for (int i=0; i< [workshopAsArray count]; i++) {
            NSDictionary *dict= [workshopAsArray objectAtIndex:i];
            if ([dict objectForKey:@"description"]== [NSNull null]) {
                [workshopAsArray removeObjectAtIndex:i];
            }
        }
        
        NSMutableArray *venueAsArray = [[responseDictionary objectForKey:@"venue"]mutableCopy];
        for (int i=0; i< [venueAsArray count]; i++) {
            NSDictionary *dict= [venueAsArray objectAtIndex:i];
            NSLog(@"[%@]", dict);
            if ([dict objectForKey:@"pdf"]== [NSNull null]) {
                [venueAsArray removeObjectAtIndex:i];
            }
        }
        
        NSMutableArray *previousVenueAsArray = [[responseDictionary objectForKey:@"previous_venue"]mutableCopy];
        for (int i=0; i< [venueAsArray count]; i++) {
            NSDictionary *dict= [venueAsArray objectAtIndex:i];
            NSLog(@"[%@]", dict);
            if ([dict objectForKey:@"pdf"]== [NSNull null]) {
                [previousVenueAsArray removeObjectAtIndex:i];
            }
        }
        
        NSMutableArray *sponsorsAsArray = [[responseDictionary objectForKey:@"sponsors"]mutableCopy];
        for (int i=0; i< [sponsorsAsArray count]; i++) {
            NSDictionary *dict= [sponsorsAsArray objectAtIndex:i];
            NSLog(@"[%@]", dict);
            if ([dict objectForKey:@"name"]== [NSNull null]) {
                [sponsorsAsArray removeObjectAtIndex:i];
            }
        }
        
        NSMutableArray *speakersAsArray = [[responseDictionary objectForKey:@"speakers"]mutableCopy];
        for (int i=0; i< [speakersAsArray count]; i++) {
            NSDictionary *dict= [speakersAsArray objectAtIndex:i];
            NSLog(@"[%@]", dict);
            if ([dict objectForKey:@"name"]== [NSNull null]) {
                [speakersAsArray removeObjectAtIndex:i];
            }
        }
        
        NSMutableArray *floorplanAsArray = [[responseDictionary objectForKey:@"floorplan"]mutableCopy];
        NSDictionary *dictionary= [floorplanAsArray objectAtIndex:0];
        NSString *floorPlanPicture= [NSString stringWithFormat:@"http://192.185.144.22/~ftthapi/uploads/%@",[dictionary objectForKey:@"picture"]];
        
        NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
        [prefs setObject:[about objectForKey:@"textaboutinfo"] forKey:@"textaboutinfo"];
        [prefs setObject:membersAsArray forKey:@"membersString"];
        [prefs setObject:directorsAsArray forKey:@"directorsString"];
        [prefs setObject:committeeAsArray forKey:@"committeesString"];
        [prefs setObject:teamAsArray forKey:@"teamString"];
        [prefs setObject:conferenceTeamAsArray forKey:@"conferenceTeamString"];
        [prefs setObject:latestStudiesAsArray forKey:@"latestStudiesString"];
        [prefs setObject:previousStudiesAsArray forKey:@"previousStudiesString"];
        [prefs setObject:venueAsArray forKey:@"venueAsString"];
        [prefs setObject:previousVenueAsArray forKey:@"previousVenue"];
        [prefs setObject:floorPlanPicture forKey:@"floorPlanPicture"];
        [prefs setObject:sponsorsAsArray forKey:@"sponsorsAsString"];
        [prefs setObject:speakersAsArray forKey:@"speakersAsString"];
        [prefs setObject:conferenceTextAsString forKey:@"conferenceTextAsString"];
        [prefs setObject:workshopAsArray forKey:@"workshopAsArray"];
        
        NSLog(@"[%@]", [about objectForKey:@"textaboutinfo"]);
        cover.hidden= YES;
        [self addSideBar];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        cover.hidden= YES;
        [self addSideBar];
    }];
    
    [operation start];
}



-(void)showCouncilPage:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self performSegueWithIdentifier:@"showCouncil" sender:nil];
}

-(void)showConferencePage:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self performSegueWithIdentifier:@"showConference" sender:nil];
}

-(void)showWorkshopPage:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self performSegueWithIdentifier:@"showWorkshop" sender:nil];
}
-(void)showPresentationPage:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self performSegueWithIdentifier:@"showPresentation" sender:nil];
}
-(void)showMemberPage:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self performSegueWithIdentifier:@"showMember" sender:nil];
}
-(void)showBecomeAMemberPage:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self performSegueWithIdentifier:@"showBecomeAMember" sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

-(IBAction)blackBarAnimation:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
    
    UIButton *btn= (UIButton *)sender;
    UIImageView *img;
    NSInteger tag= btn.tag;
    
    if (tag %2 ==0) {
        img= [[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.origin.x+btn.frame.size.width,btn.frame.origin.y ,btn.frame.size.width ,btn.frame.size.height)];
    }else
        img= [[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.origin.x+btn.frame.size.width,btn.frame.origin.y+5 ,btn.frame.size.width ,btn.frame.size.height-10)];
    
    img.image= [UIImage imageNamed:@"blackbar.png"];
    [self.view addSubview:img];
    img.layer.opacity= 0.5;
    [self.view bringSubviewToFront:btn];
    
    
    
    [UIView animateWithDuration:0.10
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         if (tag %2 ==1) {
                             img.frame= CGRectMake(btn.frame.origin.x,btn.frame.origin.y+5 ,btn.frame.size.width ,btn.frame.size.height-10);
                         }else
                             img.frame= CGRectMake(btn.frame.origin.x,btn.frame.origin.y ,btn.frame.size.width ,btn.frame.size.height);
                         
                     }completion:^(BOOL finished){
                         

                                              [img removeFromSuperview];
                                              
                                              switch (tag) {
                                                  case 1:
                                                      //                                                      [self performSegueWithIdentifier:@"showCouncil" sender:nil];
                                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"showCouncilPage" object:nil];
                                                      break;
                                                  case 2:
                                                      //                                                      [self performSegueWithIdentifier:@"showConference" sender:nil];
                                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"showConferencePage" object:nil];
                                                      break;
                                                  case 3:
                                                      //                                                      [self performSegueWithIdentifier:@"showWorkshop" sender:nil];
                                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"showWorkshopPage" object:nil];
                                                      break;
                                                  case 4:
                                                      //                                                      [self performSegueWithIdentifier:@"showPresentation" sender:nil];
                                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"showPresentationPage" object:nil];
                                                      break;
                                                  case 5:
                                                      //                                                      [self performSegueWithIdentifier:@"showMember" sender:nil];
                                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"showMemberPage" object:nil];
                                                      break;
                                                  case 6:
                                                      //                                                      [self performSegueWithIdentifier:@"showBecomeAMember" sender:nil];
                                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"showBecomeAMemberPage" object:nil];
                                                      
                                                      break;
                                                      
                                                  default:
                                                      break;
                                              }
                     }];
    
    
}

-(void)badGarbages{
    NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"YES" forKey:@"3m.png"];
    [prefs setObject:@"YES" forKey:@"3opp1.png"];
    [prefs setObject:@"YES" forKey:@"AJ_world.png"];
    [prefs setObject:@"YES" forKey:@"Advance_Network_Sol.png"];
    [prefs setObject:@"YES" forKey:@"Akter_ul_Alam_photo.png"];
    [prefs setObject:@"YES" forKey:@"Alphion.png"];
    [prefs setObject:@"YES" forKey:@"Arief_Mustain,_Telekom_Indonesia.jpg"];
    [prefs setObject:@"YES" forKey:@"Cisco.png"];
    [prefs setObject:@"YES" forKey:@"Dennis_Kan_photo1.jpg"];
    [prefs setObject:@"YES" forKey:@"Dilir_Hssain_Mollah.jpg"];
    [prefs setObject:@"YES" forKey:@"Dr_Al-Hedaithy_Suleiman,_FTTH_Middle_East.jpg"];
    [prefs setObject:@"YES" forKey:@"Dr_Ching-Sheu_Wang,_Chunghwa_Telecom.jpg"];
    [prefs setObject:@"YES" forKey:@"Dr_Farid_Sani.png"];
    [prefs setObject:@"YES" forKey:@"Dr_Khairuddin.png"];
    [prefs setObject:@"YES" forKey:@"Dr_Tan.png"];
    [prefs setObject:@"YES" forKey:@"Du_Guan_Hou,_FTTH_Council_Americas.jpg"];
    [prefs setObject:@"YES" forKey:@"Duraline1.png"];
    [prefs setObject:@"YES" forKey:@"FUJIKURA.png"];
    [prefs setObject:@"YES" forKey:@"FUTONG.png"];
    [prefs setObject:@"YES" forKey:@"Fouad.jpg"];
    [prefs setObject:@"YES" forKey:@"Gillian_Trenerry.png"];
    [prefs setObject:@"YES" forKey:@"Gunadi_Dwi_Hantoro,_Telekomunikasi_Indonesia.jpg"];
    [prefs setObject:@"YES" forKey:@"HITACHI.png"];
    [prefs setObject:@"YES" forKey:@"HMC_Pic.jpg"];
    [prefs setObject:@"YES" forKey:@"Hansen.png"];
    [prefs setObject:@"YES" forKey:@"Hengtong.png"];
    [prefs setObject:@"YES" forKey:@"Hock_Yun_Khoong.png"];
    [prefs setObject:@"YES" forKey:@"Inno_INs.png"];
    [prefs setObject:@"YES" forKey:@"Ishibashi.png"];
    [prefs setObject:@"YES" forKey:@"JGJohnGuest-logo1.jpg"];
    [prefs setObject:@"YES" forKey:@"Jalur.png"];
    [prefs setObject:@"YES" forKey:@"Jeff_Ooi.jpg"];
    [prefs setObject:@"YES" forKey:@"Jiangsu.png"];
    [prefs setObject:@"YES" forKey:@"Julie_Kunstler,_OVUM.jpg"];
    [prefs setObject:@"YES" forKey:@"JungYo_Moon,_Inno_Instrument.jpg"];
    [prefs setObject:@"YES" forKey:@"Kevin.png"];
    [prefs setObject:@"YES" forKey:@"Khairuddin_Ab_Hamid.jpg"];
    [prefs setObject:@"YES" forKey:@"Kiran.png"];
    [prefs setObject:@"YES" forKey:@"Kumpulan.png"];
    [prefs setObject:@"YES" forKey:@"LS_Cable.png"];
    [prefs setObject:@"YES" forKey:@"Lau_Bik_Soon,_REDTONE.jpg"];
    [prefs setObject:@"YES" forKey:@"Lim_Guan_Eng,_Chief_Minister_of_Penang2.jpg"];
    [prefs setObject:@"YES" forKey:@"Migita.png"];
    [prefs setObject:@"YES" forKey:@"Nadia_Babaali_2014_(1).jpg"];
    [prefs setObject:@"YES" forKey:@"Nor.png"];
    [prefs setObject:@"YES" forKey:@"PLUMETT1.jpg"];
    [prefs setObject:@"YES" forKey:@"PT._Buana_Selaras_Globalindo.png"];
    [prefs setObject:@"YES" forKey:@"PT._Industri_Telekomunikasi_Indonesia_(Persero).png"];
    [prefs setObject:@"YES" forKey:@"PT_Halilintar_Lintas_Semesta.png"];
    [prefs setObject:@"YES" forKey:@"PT_Link_Net.png"];
    [prefs setObject:@"YES" forKey:@"Peter_Macaulay-_Vice_Chair_TA1.jpg"];
    [prefs setObject:@"YES" forKey:@"Preformed.png"];
    [prefs setObject:@"YES" forKey:@"Prof_Hartwig_Tauber,_FTTH_Europe.jpg"];
    [prefs setObject:@"YES" forKey:@"Prysmian.png"];
    [prefs setObject:@"YES" forKey:@"Radius.png"];
    [prefs setObject:@"YES" forKey:@"Reichle_De-Massari_AG.png"];
    [prefs setObject:@"YES" forKey:@"Reliance_Jio.png"];
    [prefs setObject:@"YES" forKey:@"Robin_Mersh,_Broadband_Forum.jpg"];
    [prefs setObject:@"YES" forKey:@"Roland_Montagne,_IDATE.jpg"];
    [prefs setObject:@"YES" forKey:@"SHKE.jpg"];
    [prefs setObject:@"YES" forKey:@"Samsung.png"];
    [prefs setObject:@"YES" forKey:@"Schneider.png"];
    [prefs setObject:@"YES" forKey:@"Sha.png"];
    [prefs setObject:@"YES" forKey:@"Shoichi_Hanatani.png"];
    [prefs setObject:@"YES" forKey:@"Stefan_Stanislwaski,_Ventura_Team.jpg"];
    [prefs setObject:@"YES" forKey:@"Sterlite.png"];
    [prefs setObject:@"YES" forKey:@"Steve.png"];
    [prefs setObject:@"YES" forKey:@"Sunsea.png"];
    [prefs setObject:@"YES" forKey:@"Synchronoss.png"];
    [prefs setObject:@"YES" forKey:@"TE_Connectivity1.png"];
    [prefs setObject:@"YES" forKey:@"Techtel.png"];
    [prefs setObject:@"YES" forKey:@"Telcom_rd.png"];
    [prefs setObject:@"YES" forKey:@"Tim_Clark_-_Vice_Chair_PCE.jpg"];
    [prefs setObject:@"YES" forKey:@"Udo_Fetzer._JDSU.jpg"];
    [prefs setObject:@"YES" forKey:@"Victoria.jpg"];
    [prefs setObject:@"YES" forKey:@"Wei_Leping,_China_Telecom2.jpg"];
    [prefs setObject:@"YES" forKey:@"Xingfu_He.jpg"];
    [prefs setObject:@"YES" forKey:@"Yokogawa.jpg"];
    [prefs setObject:@"YES" forKey:@"Yoshiaki_Miyajima1.jpg"];
    [prefs setObject:@"YES" forKey:@"Zhejiang.jpg"];
    [prefs setObject:@"YES" forKey:@"Zony_Chen.jpg"];
    [prefs setObject:@"YES" forKey:@"adtran.png"];
    [prefs setObject:@"YES" forKey:@"alexis.png"];
    [prefs setObject:@"YES" forKey:@"arora.png"];
    [prefs setObject:@"YES" forKey:@"bbnl.png"];
    [prefs setObject:@"YES" forKey:@"beacon.png"];
    [prefs setObject:@"YES" forKey:@"bktel.png"];
    [prefs setObject:@"YES" forKey:@"broadcom.png"];
    [prefs setObject:@"YES" forKey:@"calix-logo.jpg"];
    [prefs setObject:@"YES" forKey:@"cdot.png"];
    [prefs setObject:@"YES" forKey:@"channell.png"];
    [prefs setObject:@"YES" forKey:@"chorus.png"];
    [prefs setObject:@"YES" forKey:@"converge.png"];
    [prefs setObject:@"YES" forKey:@"corning.png"];
    [prefs setObject:@"YES" forKey:@"crown.png"];
    [prefs setObject:@"YES" forKey:@"deed.jpg"];
    [prefs setObject:@"YES" forKey:@"dsm.png"];
    [prefs setObject:@"YES" forKey:@"emtelle.png"];
    [prefs setObject:@"YES" forKey:@"eti_software.png"];
    [prefs setObject:@"YES" forKey:@"exfo.png"];
    [prefs setObject:@"YES" forKey:@"fUJITSU.png"];
    [prefs setObject:@"YES" forKey:@"fiber@home.png"];
    [prefs setObject:@"YES" forKey:@"fons.png"];
    [prefs setObject:@"YES" forKey:@"furukawa.png"];
    [prefs setObject:@"YES" forKey:@"gilberto-guitarte-FTTH_Council_Latam.jpg"];
    [prefs setObject:@"YES" forKey:@"hkbn.png"];
    [prefs setObject:@"YES" forKey:@"huawei.png"];
    [prefs setObject:@"YES" forKey:@"jdsu.png"];
    [prefs setObject:@"YES" forKey:@"kiana.png"];
    [prefs setObject:@"YES" forKey:@"lee1.png"];
    [prefs setObject:@"YES" forKey:@"maraise.png"];
    [prefs setObject:@"YES" forKey:@"mark_te.png"];
    [prefs setObject:@"YES" forKey:@"mashuk.png"];
    [prefs setObject:@"YES" forKey:@"moncef.png"];
    [prefs setObject:@"YES" forKey:@"monique.png"];
    [prefs setObject:@"YES" forKey:@"muhammed.png"];
    [prefs setObject:@"YES" forKey:@"munasir.png"];
    [prefs setObject:@"YES" forKey:@"nagoya.png"];
    [prefs setObject:@"YES" forKey:@"ntt.png"];
    [prefs setObject:@"YES" forKey:@"pccw.png"];
    [prefs setObject:@"YES" forKey:@"pcom.png"];
    [prefs setObject:@"YES" forKey:@"planet_com.jpg"];
    [prefs setObject:@"YES" forKey:@"ravi_shanker.png"];
    [prefs setObject:@"YES" forKey:@"revolin.png"];
    [prefs setObject:@"YES" forKey:@"rob.png"];
    [prefs setObject:@"YES" forKey:@"robert.png"];
    [prefs setObject:@"YES" forKey:@"ryan.png"];
    [prefs setObject:@"YES" forKey:@"senko.png"];
    [prefs setObject:@"YES" forKey:@"senko1.png"];
    [prefs setObject:@"YES" forKey:@"sergio.png"];
    [prefs setObject:@"YES" forKey:@"sui_lon.png"];
    [prefs setObject:@"YES" forKey:@"sumitomo1.png"];
    [prefs setObject:@"YES" forKey:@"suresh-ramasamy.jpg"];
    [prefs setObject:@"YES" forKey:@"syibli.png"];
    [prefs setObject:@"YES" forKey:@"versionstream.png"];
    [prefs setObject:@"YES" forKey:@"warren.png"];
    [prefs setObject:@"YES" forKey:@"yofc1.png"];
    [prefs setObject:@"YES" forKey:@"zhone.png"];
    [prefs setObject:@"YES" forKey:@"Andrew Deed`.jpg"];
    [prefs setObject:@"YES" forKey:@"H. Munasir Choudhury.jpg"];
    [prefs setObject:@"YES" forKey:@"Mohamed Shajahan.png"];
    [prefs setObject:@"YES" forKey:@"Steve Foster.png"];
    [prefs setObject:@"YES" forKey:@"Yoshiaki Miyajima.jpg"];
    [prefs setObject:@"YES" forKey:@"Anil Pande.png"];
    [prefs setObject:@"YES" forKey:@"Ishibashi.png"];
    [prefs setObject:@"YES" forKey:@"Monique Morrow.png"];
    [prefs setObject:@"YES" forKey:@"Tim Clark.jpg"];
    [prefs setObject:@"YES" forKey:@"Zony Chen.jpg"];
    [prefs setObject:@"YES" forKey:@"Bernard Lee.png"];
    [prefs setObject:@"YES" forKey:@"Mashuk R Ch.png"];
    [prefs setObject:@"YES" forKey:@"Peter Macaulay.jpg"];
    [prefs setObject:@"YES" forKey:@"Victoria Ong.jpg"];
    [prefs setObject:@"YES" forKey:@"alexis.png"];
    [prefs setObject:@"YES" forKey:@"Frank (Fouad) Jaffer.jpg"];
    [prefs setObject:@"YES" forKey:@"Micheal Hansen.png"];
    [prefs setObject:@"YES" forKey:@"Shoichi Hanatani.png"];
    [prefs setObject:@"YES" forKey:@"Xingfu He.jpg"];
}

-(IBAction)showFacebookPage:(id)sender{
    NSURL *url= [NSURL URLWithString:@"https://www.facebook.com/pages/FTTH-Council-Asia-Pacific/233216600139960?ref=hl"];
    [[UIApplication sharedApplication]openURL:url];
}

-(IBAction)showtwitterPage:(id)sender{
    NSURL *url= [NSURL URLWithString:@"https://twitter.com/FTTHCOUNCILAPAC"];
    [[UIApplication sharedApplication]openURL:url];
}

-(IBAction)showLinkedInPage:(id)sender{
    NSURL *url= [NSURL URLWithString:@"http://www.linkedin.com/company/ftth-council-asia-pacific"];
    [[UIApplication sharedApplication]openURL:url];
}

-(IBAction)showBloggerPage:(id)sender{
    NSURL *url= [NSURL URLWithString:@"http://ftthcouncilap.blogspot.com/"];
    [[UIApplication sharedApplication]openURL:url];
}
@end
