//
//  WorkshopViewController.h
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 4/19/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuViewController.h"

@interface WorkshopViewController : UIViewController{
    SideMenuViewController *smvc;
    
}
@property(nonatomic, strong) IBOutlet UIImageView *pictureView;
@property(nonatomic, strong) IBOutlet UITextView *description;
@property(nonatomic, strong) IBOutlet UILabel *title;
@property(nonatomic, strong) IBOutlet UIButton *details;

@property(nonatomic, strong) NSString *pdf;
@end
