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
    // Do view setup here.
}

-(instancetype)initWithType:(MiddleSubViewType)type{
    self = [super init];
    if(self){
        _type = type;
        [self attributeConfig];
        [self UIConfig];
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
    
    self.topLeftLabel.font = [NSFont systemFontOfSize:titleFontSize_26];
    self.topRightLabel.font = [NSFont systemFontOfSize:titleFontSize_20];
    self.bottomLeftLabel.font = [NSFont systemFontOfSize:titleFontSize_20];
    self.bottomRightLabel.font = [NSFont systemFontOfSize:titleFontSize_20];
    
    self.topLeftLabel.alignment = NSTextAlignmentCenter;
    //    self.topLeftLabel.layer.borderWidth = 1.0f;
    //    self.topLeftLabel.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.innerView.layer.borderWidth = 1.0f;
    self.innerView.layer.borderColor = [NSColor blackColor].CGColor;
   
    self.showFormButton.font = [NSFont systemFontOfSize:titleFontSize_16];
    self.showFormButton.stringValue = @"●";
    self.showFormButton.hidden = YES;
    
    
    self.verLineLabel.useTheSameColor = YES;
    
    [self clearData];
}

-(IBAction)showFormButtonAction:(id)sender{
    [MainViewModel sharedInstance].hadShowSolarTermsCollectionView = ![MainViewModel sharedInstance].hadShowSolarTermsCollectionView;
}

-(void)clearData{
    switch (self.type) {
        case MiddleSubViewTypeYear:
        {
            self.horLine1Label.stringValue = @"";
            self.horLine2Label.stringValue = @"";
            self.horLine3Label.stringValue = @"";
            self.verLineLabel.stringValue = @"";
            self.topLeftLabel.stringValue = @"";
            self.topRightLabel.stringValue = @"";
            self.bottomLeftLabel.stringValue = @"";
            self.bottomRightLabel.stringValue = @"";
        }
            break;
        case MiddleSubViewTypeMonth:
        {
            self.horLine1Label.stringValue = @"";
            self.horLine2Label.stringValue = @"";
            self.horLine3Label.stringValue = @"";
            self.verLineLabel.stringValue = @"";
            self.topLeftLabel.stringValue = @"";
            self.topRightLabel.stringValue = @"";
            self.bottomLeftLabel.stringValue = @"";
            self.bottomRightLabel.stringValue = @"";
        }
            break;
        case MiddleSubViewTypeDay:
        {
            self.horLine1Label.stringValue = @"";
            self.horLine2Label.stringValue = @"";
            self.horLine3Label.stringValue = @"";
            self.verLineLabel.stringValue = @"";
            self.topLeftLabel.stringValue = @"";
            self.topRightLabel.stringValue = @"";
            self.bottomLeftLabel.stringValue = @"";
            self.bottomRightLabel.stringValue = @"";
            self.showFormButton.hidden = NO;
        }
            break;
        case MiddleSubViewTypeHour:
        {
            self.horLine1Label.stringValue = @"";
            self.horLine2Label.stringValue = @"";
            self.horLine3Label.stringValue = @"";
            self.verLineLabel.stringValue = @"";
            self.topLeftLabel.stringValue = @"";
            self.topRightLabel.stringValue = @"";
            self.bottomLeftLabel.stringValue = @"";
            self.bottomRightLabel.stringValue = @"";
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
            self.horLine1Label.stringValue = current.ganZhiYear;
            self.horLine2Label.stringValue = cangGanData.yearCangGan;
            self.horLine3Label.stringValue = liuQinData.yearBottomLiuQin;
            self.verLineLabel.stringValue  = naYinData.yearNaYin;
            self.topLeftLabel.stringValue  = liuQinData.yearTopLiuQin;
        }
            break;
        case MiddleSubViewTypeMonth:
        {
            self.horLine1Label.stringValue = current.ganZhiMonth;
            self.horLine2Label.stringValue = cangGanData.monthCangGan;
            self.horLine3Label.stringValue = liuQinData.monthBottomLiuQin;
            self.verLineLabel.stringValue  = naYinData.monthNaYin;
            self.topLeftLabel.stringValue = liuQinData.monthTopLiuQin;
            
            if(shenShaData.bottomMonthShenShaArr.count>0){
                self.bottomRightLabel.stringValue = shenShaData.bottomMonthShenShaArr[0];
            }
            
            if(shenShaData.bottomMonthShenShaArr.count>1){
                self.bottomLeftLabel.stringValue = shenShaData.bottomMonthShenShaArr[1];
            }
        }
            break;
        case MiddleSubViewTypeDay:
        {
            self.horLine1Label.stringValue = current.ganZhiDay;
            self.horLine2Label.stringValue = cangGanData.dayCangGan;
            self.horLine3Label.stringValue = liuQinData.dayBottomLiuQin;
            self.verLineLabel.stringValue  = naYinData.dayNaYin;
            self.topLeftLabel.stringValue = liuQinData.dayTopLiuQin;
            
            if(shenShaData.bottomDayShenShaArr.count>0){
                self.bottomRightLabel.stringValue = shenShaData.bottomDayShenShaArr[0];
            }
            
            if(shenShaData.bottomDayShenShaArr.count>1){
                self.bottomLeftLabel.stringValue = shenShaData.bottomDayShenShaArr[1];
            }
        }
            break;
        case MiddleSubViewTypeHour:
        {
            self.horLine1Label.stringValue = current.ganZhiHour;
            self.horLine2Label.stringValue = cangGanData.hourCangGan;
            self.horLine3Label.stringValue = liuQinData.hourBottomLiuQin;
            self.verLineLabel.stringValue  = naYinData.hourNaYin;
            self.topLeftLabel.stringValue = liuQinData.hourTopLiuQin;
            if(shenShaData.topHourShenShaArr.count>0){
                self.topRightLabel.stringValue = shenShaData.topHourShenShaArr[0];
            }
            
            if(shenShaData.bottomHourShenShaArr.count>0){
                self.bottomRightLabel.stringValue = shenShaData.bottomHourShenShaArr[0];
            }
            
            if(shenShaData.bottomHourShenShaArr.count>1){
                self.bottomLeftLabel.stringValue = shenShaData.bottomHourShenShaArr[1];
            }
        }
            break;
            
        default:
            break;
    }
    
    [self.collectionView reloadData];
}

@end
