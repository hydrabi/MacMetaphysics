//
//  SolarTermsNumberCell.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/12/28.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "SolarTermsNumberCell.h"
#import "UIConstantParameter.h"
#import "NSView+Addition.h"
@interface SolarTermsNumberCell ()

@end

@implementation SolarTermsNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [NSFont systemFontOfSize:titleFontSize_30];
    
}

-(void)isCurrentSelectedDay:(BOOL)isSelected{
    if(isSelected){
        [self.view setBackgroundColor:[NSColor lightGrayColor]];
    }
    else{
        [self.view setBackgroundColor:[NSColor whiteColor]];
    }
}
@end
