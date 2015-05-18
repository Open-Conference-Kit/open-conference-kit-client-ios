//
//  StudiesAndPresentationExtraViewController.h
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 5/17/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuViewController.h"

@interface StudiesAndPresentationExtraViewController : UIViewController{
    SideMenuViewController *smvc;
    NSMutableArray *studiesArray;
}

@property(nonatomic, retain) IBOutlet UITableView *previousStudies;
@end
