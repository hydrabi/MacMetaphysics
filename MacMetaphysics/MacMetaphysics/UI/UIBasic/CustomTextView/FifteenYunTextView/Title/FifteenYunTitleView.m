//
//  FifteenYunTitleView.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/16.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "FifteenYunTitleView.h"
#import "UIConstantParameter.h"
#import "MainViewModel.h"
@implementation FifteenYunTitleView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.font = [NSFont boldSystemFontOfSize:titleFontSize_26];
    self.textField.font = [NSFont boldSystemFontOfSize:titleFontSize_14];
}

-(void)reloadData{
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    BottomViewData *bottomData = mainViewModel.bottomData;
    if(bottomData.canStart && mainViewModel.fifteenYunData.fifteenYunSelectedNumber >=0){
        NSString *ganZhi = [bottomData getDaYunWithTableIndex:mainViewModel.fifteenYunData.fifteenYunSelectedNumber];
        NSString *qiYun = [NSString stringWithFormat:@"%ld",(mainViewModel.fifteenYunData.fifteenYunSelectedNumber - 1) * 10 + bottomData.qiYunShu] ;
        self.titleLabel.text = [NSString stringWithFormat:@"%@ %@",ganZhi,qiYun];
    }
    
}

@end
