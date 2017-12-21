//
//  BottomFirstTableViewHeader.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/15.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BottomFirstTableViewHeader.h"
#import "UIConstantParameter.h"
#import "MainViewModel.h"
@implementation BottomFirstTableViewHeader

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(void)initialize{
    self.recoverButton.editable = NO;
    self.translatesAutoresizingMaskIntoConstraints = YES;
}

//恢复操作
- (IBAction)recoverAction:(id)sender {
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    //隐藏流年窗口
    LiuNianData *liuNianData = mainViewModel.liuNianData;
    [liuNianData.bottomLocationDic removeAllObjects];
    liuNianData.firstLocation = nil;
    liuNianData.secondLocation = nil;
    mainViewModel.hadShowLiuNianTextView = NO;
    //隐藏底部大运窗口
    [mainViewModel selectTableViewHeaderWithTag:mainViewModel.fifteenYunData.fifteenYunSelectedNumber];
    //清空15运
    FifteenYunData *fifteenData = mainViewModel.fifteenYunData;
    [fifteenData clearData];
    
    [(RACSubject*)mainViewModel.LiuNianTextViewOperationSig sendNext:nil];
    [(RACSubject*)mainViewModel.reloadBottomTablesSig sendNext:nil];
}

@end
