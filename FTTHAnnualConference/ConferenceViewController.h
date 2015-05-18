//
//  ConferenceViewController.h
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/26/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceViewController.h"
#import "SideMenuViewController.h"
#import "UIImageView+WebCache.h"
#import <MapKit/MKMapView.h>
#import <MapKit/MKPointAnnotation.h>


@interface ConferenceViewController : UIViewController{
    SideMenuViewController *smvc;
    NSMutableArray *directors;
    NSMutableArray *sponsors;
    
    NSString *upcoming;
}

@property(nonatomic, strong) IBOutlet UIButton *circularBtn1;
@property(nonatomic, strong) IBOutlet UIButton *circularBtn2;
@property(nonatomic, strong) IBOutlet UIButton *circularBtn3;
@property(nonatomic, strong) IBOutlet UIButton *circularBtn4;
@property(nonatomic, strong) IBOutlet UIButton *circularBtn5;
@property(nonatomic, strong) IBOutlet UIButton *circularBtn6;

@property(nonatomic, strong) IBOutlet UIButton *circularBtnMash;
@property(nonatomic, strong) IBOutlet UIImageView *circularBtnMashBg;

@property(nonatomic, strong) IBOutlet NSString *circularBtn1String;
@property(nonatomic, strong) IBOutlet NSString *circularBtn2String;
@property(nonatomic, strong) IBOutlet NSString *circularBtn3String;
@property(nonatomic, strong) IBOutlet NSString *circularBtn4String;
@property(nonatomic, strong) IBOutlet NSString *circularBtn5String;
@property(nonatomic, strong) IBOutlet NSString *circularBtn6String;

@property(nonatomic, strong) IBOutlet UILabel *titleOfScreen;
@property(nonatomic, strong) IBOutlet UITextView *detailText;

@property(nonatomic, strong) IBOutlet UIButton *upcomingbutton;
@property(nonatomic, strong) IBOutlet UIButton *previousbutton;

@property(nonatomic, strong) IBOutlet UITableView *conferenceTeamTable;
@property(nonatomic, strong) IBOutlet UITableView *sponsorsTeamTable;

@property(nonatomic, strong) IBOutlet UIView *venueView;
@property(nonatomic, strong) IBOutlet UIView *sponsorsView;

@property(nonatomic, strong) IBOutlet MKMapView *mapView;

@property(nonatomic, strong) IBOutlet UITableView *sponsorsTable;
@property(nonatomic, strong) IBOutlet UIImageView *logoPic;

@property(nonatomic, strong) IBOutlet UILabel *sponsorType;

@property(nonatomic, strong) NSString *upcoming;

@property(nonatomic, strong) IBOutlet UIImageView *hotelImage;
@property(nonatomic, strong) IBOutlet UILabel *hotelName;
@property(nonatomic, strong) IBOutlet UILabel *hotelAddress;
@property(nonatomic, strong) IBOutlet UILabel *hotelUrl;
@property(nonatomic, strong) IBOutlet UIButton *hotelPhone;

@property(nonatomic, strong) IBOutlet UITextView *conferencedescription;
@end
