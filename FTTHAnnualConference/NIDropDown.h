//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NIDropDown;
@protocol NIDropDownDelegate
- (void) niDropDownDelegateMethod: (NIDropDown *) sender;
@end

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>
{
    NSString *animationDirection;
    UIImageView *imgView;

}
@property (nonatomic, retain) id <NIDropDownDelegate> delegate;
@property (nonatomic, retain) NSString *animationDirection;
@property (nonatomic, retain) NSString *selection;
-(void)hideDropDown:(UIButton *)b;
-(id)showDropDownFromButton:(UIButton *)b dropDownHeight:(CGFloat *)height optionsArray:(NSArray *)arr dropDownoptionsImage:(NSArray *)imgArr dropDownDirectionString:(NSString *)direction;
@end
