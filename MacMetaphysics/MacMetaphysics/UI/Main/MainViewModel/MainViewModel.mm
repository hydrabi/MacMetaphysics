//
//  MainViewModel.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/5.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "MainViewModel.h"


@implementation MainViewModel

+(instancetype)sharedInstance{
    static MainViewModel *main = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        main = [[MainViewModel alloc] init];
    });
    return main;
}

-(void)initialize{
    [super initialize];
    
    self.leftMenuArr = @[
                         @[
                             @(LeftSideMenuTypeChaoDai),
                             @(LeftSideMenuTypeYanSe),
                             @(LeftSideMenuTypeShenSha),
                             @(LeftSideMenuTypeShuangZao),
                             ],
                         
                         @[
                             @(LeftSideMenuTypeDaYun),
                             
                             @(LeftSideMenuTypeYongShen),
                             @(LeftSideMenuTypeGeJu),
                             @(LeftSideMenuTypeXiangMao),
                             @(LeftSideMenuTypeWenPin),
                             @(LeftSideMenuTypeFuMu),
                             
                             @(LeftSideMenuTypeXiongDi),
                             @(LeftSideMenuTypeZiNv),
                             @(LeftSideMenuTypeHunYin),
                             @(LeftSideMenuTypeGuanGui),
                             @(LeftSideMenuTypeCaiFu),
                             
                             @(LeftSideMenuTypeGuanSi),
                             @(LeftSideMenuTypeJiBing),
                             @(LeftSideMenuTypeCountQiYunUseHour),
                             @(LeftSideMenuTypeVersion),
                             ]
                         ];
    
//    self.stemsStr = [NSString stemsStr];
//    self.branchesStr = [NSString branchesStr];
//    self.jiaZiArr = [NSArray jiaZiArr];
//    
//    self.hadShowSolarTermsCollectionView = NO;
//    self.hadHiddenBottomTableView = NO;
//    self.hiddenBottomTableViewTag = 0;
//    
//    self.currentBottomSectionMenuType = LeftSideMenuTypeEmpty;
//    self.currentSelectTopSectionMenuTypeArr = @[].mutableCopy;
//    self.shuangZaoData = [[ShuangZaoData alloc] init];
//    self.selectedDate = [[CurrentSelectDate alloc] init];
//    self.riZhuData = [[RiZhuData alloc] init];
//    self.middleData = [[MiddleViewData alloc] init];
//    self.bottomData = [[BottomViewData alloc] init];
//    self.fifteenYunData = [[FifteenYunData alloc] init];
//    self.liuNianData = [[LiuNianData alloc] init];
//    self.lunar = new Lunar();
//    
//    self.solarTermsTimeDic = [AnalysisSolarTerm analysis];
//    
//    [self bindOperation];
}



@end
