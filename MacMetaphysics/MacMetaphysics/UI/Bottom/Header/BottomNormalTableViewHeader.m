//
//  BottomNormalTableViewHeader.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/15.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BottomNormalTableViewHeader.h"
#import "UIConstantParameter.h"
#import "NSString+Addition.h"
#import "MainViewModel.h"
#import "NSTextField+Addition.h"
#import "GroupBottomXiaoYunView.h"

static CGFloat alphaNumber = 0.3;

@implementation BottomNormalTableViewHeader

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.mainTitleLabel.font = [NSFont systemFontOfSize:titleFontSize_20];
    self.topTitleLabel.font = [NSFont systemFontOfSize:titleFontSize_14];
    self.bottomNumberTitleLabel.font = [NSFont systemFontOfSize:titleFontSize_14];
    
    self.hideTableViewButton.textColor = [NSColor blackColor];
    self.hideTableViewButton.font = [NSFont systemFontOfSize:titleFontSize_14];
    self.hideTableViewButton.text = @"●";
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

-(void)initialize{
    @weakify(self)
    
    //隐藏按钮点击
    [[self.hideTableViewButton rac_signalForSelector:@selector(mouseDown:)]
     subscribeNext:^(id _){
        @strongify(self)
         if(self.tableViewTag == 0){
             [self recoverAction];
         }
         else{
             [self hiddenAction];
         }
     }];
    
    [[self.bottomNumberButton rac_signalForSelector:@selector(mouseDown:)]
     subscribeNext:^(id _){
        @strongify(self)
         [self selectHeader];
     }];
    
    [[self.ganButton rac_signalForSelector:@selector(mouseDown:)]
     subscribeNext:^(id _){
         @strongify(self)
         [self ganButtonClick];
     }];
    
    [[self.zhiButton rac_signalForSelector:@selector(mouseDown:)]
     subscribeNext:^(id _){
         @strongify(self)
         [self zhiButtonClick];
     }];
}

//非第一列头部隐藏按钮点击
-(void)hiddenAction{
    [[MainViewModel sharedInstance] hiddenTableViewWithTag:self.tableViewTag];
}

//点击底部数字
-(void)selectHeader{
    MainViewModel *main = [MainViewModel sharedInstance];
    if(main.hadHiddenBottomTableView){
        //不是隐藏的部分才可以点击数字显示底部大运窗口
        if(self.tableViewTag < main.hiddenBottomTableViewTag){
            [[MainViewModel sharedInstance] selectTableViewHeaderWithTag:self.tableViewTag];
        }
    }
    else{
        [[MainViewModel sharedInstance] selectTableViewHeaderWithTag:self.tableViewTag];
    }
    
}

//第一纵列的头部不需要显示任何消息
-(void)clearFirstHeader{
    self.mainTitleLabel.text = @"";
    self.topTitleLabel.text = @"";
    self.bottomNumberTitleLabel.text = @"";
}

-(void)reloadData{
    
    if(self.tableViewTag == 0){
        [self clearFirstHeader];
        return;
    }
    
    MainViewModel *main = [MainViewModel sharedInstance];
    if(main.fifteenYunData.fifteenYunSelectedNumber == self.tableViewTag){
        [self.bottomNumberTitleLabel setBoldFont];
    }
    else{
        [self.bottomNumberTitleLabel setOriginalFont];
    }
    //是否隐藏了整一列
    if(main.hadHiddenBottomTableView){
        if(self.tableViewTag >= main.hiddenBottomTableViewTag){
            [self hideContent];
        }
        else{
            [self showContent];
        }
    }
    //展示
    else{
        [self showContent];
    }
    
    
    [self resetDaYun];
    [self resetLiuQin];
    [self resetQinYunNumber];
}

//重置六亲
-(void)resetLiuQin{
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    MiddleViewData *middleData = mainViewModel.middleData;
    BottomViewData *bottomData = mainViewModel.bottomData;
    if(self.mainTitleLabel.text.length>0 &&
       bottomData.canStart){
        LiuQinData *liuQinData = middleData.liuQinData;
        CurrentSelectDate *selectData = mainViewModel.selectedDate;
        self.topTitleLabel.text = [liuQinData getLiuQinValueWithRiGanZhi:selectData.ganZhiDay
                                                             otherGanZhi:self.mainTitleLabel.text];
    }
    
}

//重置大运
-(void)resetDaYun{
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    BottomViewData *bottomData = mainViewModel.bottomData;
    FifteenYunData *fifteenData = mainViewModel.fifteenYunData;
    if(bottomData.canStart){
        self.mainTitleLabel.text = [bottomData getDaYunWithTableIndex:self.tableViewTag];
        
        //设置选中颜色
        if(fifteenData.selectLocationArr.count>self.tableViewTag){
            DaYunTitleSelectLocation *location = fifteenData.selectLocationArr[self.tableViewTag];
            if(self.mainTitleLabel.text.length>0){
                NSMutableAttributedString *attributeString = nil;
                if(self.mainTitleLabel.attributedStringValue.length>0){
                    attributeString = self.mainTitleLabel.attributedStringValue.mutableCopy;
                }
                else{
                    attributeString = [[NSMutableAttributedString alloc] initWithString:self.mainTitleLabel.text];
                }
                
                if(location.selectedGan){
                    
                    [attributeString addAttribute:NSBackgroundColorAttributeName
                                            value:[NSColor grayColor]
                                            range:NSMakeRange(0, 1)];
                    self.mainTitleLabel.attributedStringValue = attributeString;
                }
                else{
                    [attributeString addAttribute:NSBackgroundColorAttributeName
                                            value:[NSColor whiteColor]
                                            range:NSMakeRange(0, 1)];
                    self.mainTitleLabel.attributedStringValue = attributeString;
                }
                
                if(location.selectedBranch){
                    [attributeString addAttribute:NSBackgroundColorAttributeName
                                            value:[NSColor grayColor]
                                            range:NSMakeRange(1, 1)];
                    self.mainTitleLabel.attributedStringValue = attributeString;
                }
                else{
                    [attributeString addAttribute:NSBackgroundColorAttributeName
                                            value:[NSColor whiteColor]
                                            range:NSMakeRange(1, 1)];
                    self.mainTitleLabel.attributedStringValue = attributeString;
                }
            }
        }
    }
}

//重置起运数目
-(void)resetQinYunNumber{
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    BottomViewData *bottomData = mainViewModel.bottomData;
    if(bottomData.canStart){
        self.bottomNumberTitleLabel.text = [NSString stringWithFormat:@"%ld",(self.tableViewTag - 1) * 10 + bottomData.qiYunShu] ;
    }
}

#pragma mark - 第一列头部点击事件
//恢复操作
-(void)recoverAction{
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    //隐藏流年窗口
    LiuNianData *liuNianData = mainViewModel.liuNianData;
    [liuNianData.bottomLocationDic removeAllObjects];
    liuNianData.firstLocation = nil;
    liuNianData.secondLocation = nil;
    //隐藏底部大运窗口
    [mainViewModel selectTableViewHeaderWithTag:mainViewModel.fifteenYunData.fifteenYunSelectedNumber];
    //清空15运
    FifteenYunData *fifteenData = mainViewModel.fifteenYunData;
    [fifteenData clearData];
    
//    [(RACSubject*)mainViewModel.LiuNianTextViewOperationSig sendNext:nil];
    [(RACSubject*)mainViewModel.reloadBottomTablesSig sendNext:nil];
}

#pragma mark - 隐藏
-(void)hideContent{
    self.alphaValue = alphaNumber;
}

-(void)showContent{
    self.alphaValue = 1;
}

#pragma mark - 干支按钮点击
-(void)ganButtonClick{
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    FifteenYunData *fifteenData = mainViewModel.fifteenYunData;
    if(fifteenData.selectLocationArr.count>self.tableViewTag){
        DaYunTitleSelectLocation *location = fifteenData.selectLocationArr[self.tableViewTag];
        location.selectedGan = !location.selectedGan;
//        [(RACSubject*)mainViewModel.reloadBottomTablesSig sendNext:nil];
        
        NSLog(@"点中的干：%d",self.tableViewTag);
        NSLog(@"实际的item：%d",[self.parentGroupView getRow]);
        [self reloadData];
    }
}

-(void)zhiButtonClick{
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    FifteenYunData *fifteenData = mainViewModel.fifteenYunData;
    if(fifteenData.selectLocationArr.count>self.tableViewTag){
        DaYunTitleSelectLocation *location = fifteenData.selectLocationArr[self.tableViewTag];
        location.selectedBranch = !location.selectedBranch;
//        [(RACSubject*)mainViewModel.reloadBottomTablesSig sendNext:nil];
        [self reloadData];
    }
}

@end
