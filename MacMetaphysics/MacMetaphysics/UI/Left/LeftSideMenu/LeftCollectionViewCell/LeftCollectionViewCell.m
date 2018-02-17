//
//  LeftCollectionViewCell.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/5.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "LeftCollectionViewCell.h"

#import "NSTextField+Addition.h"
#import "MainViewModel.h"
@interface LeftCollectionViewCell ()

@end

@implementation LeftCollectionViewCell

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.textColor = [NSColor blackColor];
    self.titleLabel.font = [NSFont systemFontOfSize:titleFontSize_20];
    
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor clearColor].CGColor;
}

-(void)resetValueWithType:(LeftSideMenuType)type{
    MainViewModel *main = [MainViewModel sharedInstance];
    self.titleLabel.text = [main getSpecificMenuTitleWithType:type];
    if(main.currentBottomSectionMenuType == type ||
       [main.currentSelectTopSectionMenuTypeArr containsObject:@(type)]){
        [self.titleLabel setBoldFont];
    }
    else{
        [self.titleLabel setOriginalFont];
    }
    
    if(type == LeftSideMenuTypeCountQiYunUseHour){
        if(main.useHourCountQiYun){
            [self.titleLabel setBoldFont];
        }
        else{
            [self.titleLabel setOriginalFont];
        }
    }
}

@end
