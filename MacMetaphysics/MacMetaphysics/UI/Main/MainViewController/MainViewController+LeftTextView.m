//
//  MainViewController+LeftTextView.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/4/30.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "MainViewController+LeftTextView.h"

@implementation MainViewController (LeftTextView)

-(void)leftTextViewConfig{
    [self leftTextViewUIConfig];
    [self leftTextViewBindViewModel];
}

-(void)leftTextViewUIConfig{
    self.yongShenTextView = [[LiuNianTextView alloc] init];
    [self addChildViewController:self.yongShenTextView];
    self.yongShenTextView.view.hidden = YES;
    [self.view addSubview:self.yongShenTextView.view];
    
    self.geJuTextView = [[LiuNianTextView alloc] init];
    [self addChildViewController:self.geJuTextView];
    self.geJuTextView.view.hidden = YES;
    [self.view addSubview:self.geJuTextView.view];
    
    self.xiangMaoTextView = [[LiuNianTextView alloc] init];
    [self addChildViewController:self.xiangMaoTextView];
    self.xiangMaoTextView.view.hidden = YES;
    [self.view addSubview:self.xiangMaoTextView.view];
    
    self.wenPingTextView = [[LiuNianTextView alloc] init];
    [self addChildViewController:self.wenPingTextView];
    self.wenPingTextView.view.hidden = YES;
    [self.view addSubview:self.wenPingTextView.view];
    
    self.fuMuTextView = [[LiuNianTextView alloc] init];
    [self addChildViewController:self.fuMuTextView];
    self.fuMuTextView.view.hidden = YES;
    [self.view addSubview:self.fuMuTextView.view];
    
    self.xiongDiTextView = [[LiuNianTextView alloc] init];
    [self addChildViewController:self.xiongDiTextView];
    self.xiongDiTextView.view.hidden = YES;
    [self.view addSubview:self.xiongDiTextView.view];
    
    self.ziNvTextView = [[LiuNianTextView alloc] init];
    [self addChildViewController:self.ziNvTextView];
    self.ziNvTextView.view.hidden = YES;
    [self.view addSubview:self.ziNvTextView.view];
    
    self.hunYinTextView = [[LiuNianTextView alloc] init];
    [self addChildViewController:self.hunYinTextView];
    self.hunYinTextView.view.hidden = YES;
    [self.view addSubview:self.hunYinTextView.view];
    
    self.guanGuiTextView = [[LiuNianTextView alloc] init];
    [self addChildViewController:self.guanGuiTextView];
    self.guanGuiTextView.view.hidden = YES;
    [self.view addSubview:self.guanGuiTextView.view];
    
    self.caiFuTextView = [[LiuNianTextView alloc] init];
    [self addChildViewController:self.caiFuTextView];
    self.caiFuTextView.view.hidden = YES;
    [self.view addSubview:self.caiFuTextView.view];
    
    self.guanSiTextView = [[LiuNianTextView alloc] init];
    [self addChildViewController:self.guanSiTextView];
    self.guanSiTextView.view.hidden = YES;
    [self.view addSubview:self.guanSiTextView.view];
    
    self.bottomTextViewArr = @[].mutableCopy;
    [self.bottomTextViewArr addObject:self.yongShenTextView];
    [self.bottomTextViewArr addObject:self.geJuTextView];
    [self.bottomTextViewArr addObject:self.xiangMaoTextView];
    [self.bottomTextViewArr addObject:self.wenPingTextView];
    [self.bottomTextViewArr addObject:self.fuMuTextView];
    [self.bottomTextViewArr addObject:self.xiongDiTextView];
    [self.bottomTextViewArr addObject:self.ziNvTextView];
    [self.bottomTextViewArr addObject:self.hunYinTextView];
    [self.bottomTextViewArr addObject:self.guanGuiTextView];
    [self.bottomTextViewArr addObject:self.caiFuTextView];
    [self.bottomTextViewArr addObject:self.guanSiTextView];
    
    @weakify(self)
    for(LiuNianTextView *view in self.bottomTextViewArr){
        [view.view makeConstraints:^(MASConstraintMaker *make){
            @strongify(self)
            make.leading.equalTo(self.secondVerLine.trailing).offset(@(leftVerLineOffset));
            make.top.equalTo(self.bottomContentView.view.bottom).offset(leftVerLineOffset);
            make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset));
            make.height.equalTo(bottomTextViewHeight);
        }];
    }
}

-(void)leftTextViewBindViewModel{
    @weakify(self)
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    //流年底部textView操作
    [[mainViewModel.leftMenuClickTextViewOperationSig
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
         [self showBottomTextViewWithType:[MainViewModel sharedInstance].currentBottomSectionMenuType];
     }];
}

-(LiuNianTextView*)getSpecificBottomTextViewWithType:(LeftSideMenuType)type{
    LiuNianTextView *view = nil;
    
    //因为第一个LeftSideMenuTypeYongShen 用神忌神枚举值为3
    NSInteger index = type - 3;
    if(index >= 0 && self.bottomTextViewArr.count > index){
        view = self.bottomTextViewArr[index];
    }
    
    return view;
}

-(void)showBottomTextViewWithType:(LeftSideMenuType)type{
    self.currentBottomTextView.view.hidden = YES;
    LiuNianTextView *newCurrentView = [self getSpecificBottomTextViewWithType:type];
    self.currentBottomTextView = newCurrentView;
    self.currentBottomTextView.view.hidden = NO;
}

//清空所有textView
-(void)clearAllTextView{
    for(LiuNianTextView *view in self.bottomTextViewArr){
        view.myTextView.string = @"";
    }
}

//读取记录
-(void)readLeftTextRecordData{
    LeftMenuBottomTextData *data = [MainViewModel sharedInstance].leftMenuBottomTextData;
    for(LeftSideMenuType type = LeftSideMenuTypeYongShen;type <= LeftSideMenuTypeGuanSi;type++){
        NSString *result = data.bottomTextRecordDic[@(type)];
        if(result == nil){
            result = @"";
        }
        LiuNianTextView *view = [self getSpecificBottomTextViewWithType:type];
        view.myTextView.string = result;
    }
}

//将textView的数据保存入字典
-(void)saveLeftTextRecordData{
    LeftMenuBottomTextData *data = [MainViewModel sharedInstance].leftMenuBottomTextData;
    [data.bottomTextRecordDic removeAllObjects];
    
    for(LeftSideMenuType type = LeftSideMenuTypeYongShen;type <= LeftSideMenuTypeGuanSi;type++){
        LiuNianTextView *view = [self getSpecificBottomTextViewWithType:type];
        NSString *tempString = view.myTextView.string;
        if(tempString == nil){
            tempString = @"";
        }
        data.bottomTextRecordDic[@(type)] = tempString;
    }
}

@end
