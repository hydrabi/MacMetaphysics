//
//  SolarTermsMonthCell.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/12/28.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "SolarTermsMonthCell.h"
#import "UIConstantParameter.h"
@interface SolarTermsMonthCell ()

@end

@implementation SolarTermsMonthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [NSFont systemFontOfSize:titleFontSize_30];
}

@end
