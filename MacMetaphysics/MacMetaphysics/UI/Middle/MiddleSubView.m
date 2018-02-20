//
//  MiddleSubView.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/9.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "MiddleSubView.h"
#import "UIConstantParameter.h"
#import "NSString+Addition.h"
#import "MainViewModel.h"
#import "MiddleTableViewDataSource.h"
@interface MiddleSubView ()
@property (nonatomic,strong)MiddleTableViewDataSource *tableViewDataSource;
@end

@implementation MiddleSubView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self attributeConfig];
    [self UIConfig];
    
    // Do view setup here.
}

-(instancetype)initWithType:(MiddleSubViewType)type{
    self = [super initWithNibName:NSStringFromClass([MiddleSubView class]) bundle:nil];
    if(self){
        _type = type;
        
    }
    return self;
}

-(void)attributeConfig{
    self.tableViewDataSource = [[MiddleTableViewDataSource alloc] initWithCollectionView:self.collectionView subViewType:self.type];
}

-(void)UIConfig{
    
    self.horLine1Label.font = [NSFont systemFontOfSize:titleFontSize_50];
    self.horLine2Label.font = [NSFont systemFontOfSize:titleFontSize_20];
    self.horLine3Label.font = [NSFont systemFontOfSize:titleFontSize_20];
    self.verLineLabel.font = [NSFont systemFontOfSize:titleFontSize_20];
    
    self.topLeftLabel.font = [NSFont systemFontOfSize:titleFontSize_24];
    self.topRightLabel.font = [NSFont systemFontOfSize:titleFontSize_20];
    self.bottomLeftLabel.font = [NSFont systemFontOfSize:titleFontSize_20];
    self.bottomRightLabel.font = [NSFont systemFontOfSize:titleFontSize_20];
    
    self.topLeftLabel.alignment = NSTextAlignmentCenter;
//        self.topLeftLabel.layer.borderWidth = 1.0f;
//        self.topLeftLabel.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.innerView.layer.borderWidth = 1.0f;
    self.innerView.layer.borderColor = [NSColor blackColor].CGColor;
   
    self.showFormButton.font = [NSFont systemFontOfSize:titleFontSize_16];
    self.showFormButton.text = @"●";
    self.showFormButton.hidden = YES;
    
    @weakify(self)
    [[self.showFormButton
      rac_signalForSelector:@selector(mouseDown:)]
     subscribeNext:^(id _){
         @strongify(self)
         [self showFormButtonAction];
     }];
    
    self.view.wantsLayer = YES;
    self.view.layer.borderWidth = 1.0f;
    self.view.layer.borderColor = [NSColor blackColor].CGColor;
    
    self.verLineLabel.useTheSameColor = YES;
    
    [self clearData];
}

-(void)showFormButtonAction{
    [MainViewModel sharedInstance].hadShowSolarTermsCollectionView = ![MainViewModel sharedInstance].hadShowSolarTermsCollectionView;
}

-(void)clearData{
    switch (self.type) {
        case MiddleSubViewTypeYear:
        {
            self.horLine1Label.text = @"";
            self.horLine2Label.text = @"";
            self.horLine3Label.text = @"";
            self.verLineLabel.text = @"";
            self.topLeftLabel.text = @"";
            self.topRightLabel.text = @"";
            self.bottomLeftLabel.text = @"";
            self.bottomRightLabel.text = @"";
        }
            break;
        case MiddleSubViewTypeMonth:
        {
            self.horLine1Label.text = @"";
            self.horLine2Label.text = @"";
            self.horLine3Label.text = @"";
            self.verLineLabel.text = @"";
            self.topLeftLabel.text = @"";
            self.topRightLabel.text = @"";
            self.bottomLeftLabel.text = @"";
            self.bottomRightLabel.text = @"";
        }
            break;
        case MiddleSubViewTypeDay:
        {
            self.horLine1Label.text = @"";
            self.horLine2Label.text = @"";
            self.horLine3Label.text = @"";
            self.verLineLabel.text = @"";
            self.topLeftLabel.text = @"";
            self.topRightLabel.text = @"";
            self.bottomLeftLabel.text = @"";
            self.bottomRightLabel.text = @"";
            self.showFormButton.hidden = NO;
        }
            break;
        case MiddleSubViewTypeHour:
        {
            self.horLine1Label.text = @"";
            self.horLine2Label.text = @"";
            self.horLine3Label.text = @"";
            self.verLineLabel.text = @"";
            self.topLeftLabel.text = @"";
            self.topRightLabel.text = @"";
            self.bottomLeftLabel.text = @"";
            self.bottomRightLabel.text = @"";
        }
            break;

        default:
            break;
    }
}

-(void)reloadData{
    [self clearData];
    
    CurrentSelectDate *current = [MainViewModel sharedInstance].selectedDate;
    LiuQinData *liuQinData = [MainViewModel sharedInstance].middleData.liuQinData;
    CangGanData *cangGanData = [MainViewModel sharedInstance].middleData.cangGanData;
    NaYinData *naYinData = [MainViewModel sharedInstance].middleData.naYinData;
    ShenShaData *shenShaData = [MainViewModel sharedInstance].middleData.shenShaData;
    switch (self.type) {
        case MiddleSubViewTypeYear:
        {
            self.horLine1Label.text = current.ganZhiYear?:@"";
            self.horLine2Label.text = cangGanData.yearCangGan?:@"";
            self.horLine3Label.text = liuQinData.yearBottomLiuQin?:@"";
            self.verLineLabel.text  = naYinData.yearNaYin?:@"";
            self.topLeftLabel.text  = liuQinData.yearTopLiuQin?:@"";
        }
            break;
        case MiddleSubViewTypeMonth:
        {
            self.horLine1Label.text = current.ganZhiMonth?:@"";
            self.horLine2Label.text = cangGanData.monthCangGan?:@"";
            self.horLine3Label.text = liuQinData.monthBottomLiuQin?:@"";
            self.verLineLabel.text  = naYinData.monthNaYin?:@"";
            self.topLeftLabel.text = liuQinData.monthTopLiuQin?:@"";
            
            if(shenShaData.bottomMonthShenShaArr.count>0){
                self.bottomRightLabel.text = shenShaData.bottomMonthShenShaArr[0];
            }
            
            if(shenShaData.bottomMonthShenShaArr.count>1){
                self.bottomLeftLabel.text = shenShaData.bottomMonthShenShaArr[1];
            }
        }
            break;
        case MiddleSubViewTypeDay:
        {
            self.horLine1Label.text = current.ganZhiDay?:@"";
            self.horLine2Label.text = cangGanData.dayCangGan?:@"";
            self.horLine3Label.text = liuQinData.dayBottomLiuQin?:@"";
            self.verLineLabel.text  = naYinData.dayNaYin?:@"";
            self.topLeftLabel.text = liuQinData.dayTopLiuQin?:@"";
            
            if(shenShaData.bottomDayShenShaArr.count>0){
                self.bottomRightLabel.text = shenShaData.bottomDayShenShaArr[0];
            }
            
            if(shenShaData.bottomDayShenShaArr.count>1){
                self.bottomLeftLabel.text = shenShaData.bottomDayShenShaArr[1];
            }
        }
            break;
        case MiddleSubViewTypeHour:
        {
            self.horLine1Label.text = current.ganZhiHour?:@"";
            self.horLine2Label.text = cangGanData.hourCangGan?:@"";
            self.horLine3Label.text = liuQinData.hourBottomLiuQin?:@"";
            self.verLineLabel.text  = naYinData.hourNaYin?:@"";
            self.topLeftLabel.text  = liuQinData.hourTopLiuQin?:@"";
            if(shenShaData.topHourShenShaArr.count>0){
                self.topRightLabel.text = shenShaData.topHourShenShaArr[0];
            }
            
            if(shenShaData.bottomHourShenShaArr.count>0){
                self.bottomRightLabel.text = shenShaData.bottomHourShenShaArr[0];
            }
            
            if(shenShaData.bottomHourShenShaArr.count>1){
                self.bottomLeftLabel.text = shenShaData.bottomHourShenShaArr[1];
            }
        }
            break;
            
        default:
            break;
    }
    
    [self.collectionView reloadData];
}

@end
