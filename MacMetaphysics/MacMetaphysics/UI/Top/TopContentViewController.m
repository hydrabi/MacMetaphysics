//
//  TopContentViewController.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/11.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "TopContentViewController.h"
#import "UIConstantParameter.h"
@interface TopContentViewController ()

@end

@implementation TopContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self attributeConfig];
    // Do view setup here.
}

//配置属性
-(void)attributeConfig{
    [self.hideButton setTitle:@"●"];
    [self.hideButton setFont:[NSFont systemFontOfSize:titleFontSize_16]];
    
    self.gregorianYearTxt.delegate = self;
    self.gregorianMonthTxt.delegate = self;
    self.gregorianDayTxt.delegate = self;
    self.gregorianHourTxt.delegate = self;
    self.lunarYearTxt.delegate = self;
    self.lunarMonthTxt.delegate = self;
    self.lunarDayTxt.delegate = self;
    self.lunarHourTxt.delegate = self;
}

@end
