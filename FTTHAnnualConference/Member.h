//
//  Member.h
//  FTTHAnnualConference
//
//  Created by Mahbub Morshed on 5/3/14.
//  Copyright (c) 2014 Mahbub Morshed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject

@property(nonatomic, strong) NSString *memberid;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *logo;
@property(nonatomic, strong) NSString *category;
@property(nonatomic, strong) NSString *order;
@end
