//
//  SolarTermsFirstCell.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/12/28.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "SolarTermsFirstCell.h"
#import "UIConstantParameter.h"
@interface SolarTermsFirstCell ()

@end

@implementation SolarTermsFirstCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.font = [NSFont systemFontOfSize:titleFontSize_40];
}
@end
