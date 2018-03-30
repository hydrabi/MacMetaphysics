//
//  TopContentViewController+Clear.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/27.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "TopContentViewController+Clear.h"

@implementation TopContentViewController (Clear)

-(void)clearContent{
    self.gregorianYearTxt.text = @"";
    self.gregorianMonthTxt.text = @"";
    self.gregorianDayTxt.text = @"";
    self.gregorianHourTxt.text = @"";
    
    self.lunarYearTxt.text = @"";
    self.lunarMonthTxt.text = @"";
    self.lunarDayTxt.text = @"";
    self.lunarHourTxt.text = @"";
    
    self.taiYuanLabel.text = @"";
    self.mingGongLabel.text = @"";
    
    self.firstTextField.text = @"";
    self.secondTextField.text = @"";
    self.thirdTextField.text = @"";
    
    self.leapMonthLabel.hidden = YES;
}

@end
