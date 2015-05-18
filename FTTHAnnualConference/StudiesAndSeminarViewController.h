//
//  StudiesAndSeminarViewController.h
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/19/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuViewController.h"

@interface StudiesAndSeminarViewController : UIViewController{
    SideMenuViewController *smvc;

}

@property(nonatomic, strong) IBOutlet UITextView *descriptionView;

@property(nonatomic, strong) IBOutlet UITextView *descriptionView1;
@property(nonatomic, strong) NSString *descriptionString;
@property(nonatomic, strong) NSString *urlString;

@property(nonatomic, strong) IBOutlet UIButton *latest;
@property(nonatomic, strong) IBOutlet UIButton *previous;
@end
