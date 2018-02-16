//
//  ShuangZaoTextView.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/2/8.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "ShuangZaoTextView.h"
#import "UIConstantParameter.h"
#import "NSView+Addition.h"
#import "MainViewModel.h"
#import "JiaZiCollectionViewController.h"

@interface ShuangZaoTextView ()

@end

@implementation ShuangZaoTextView

+(instancetype)addWithParentViewController:(NSViewController*)parentViewController{
    ShuangZaoTextView *textViewController = [[ShuangZaoTextView alloc] initWithNibName:NSStringFromClass([ShuangZaoTextView class]) bundle:nil];
    [parentViewController addChildViewController:textViewController];
    [parentViewController.view addSubview:textViewController.view];
    return textViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self UIConfig];
    [self bindViewModel];
}

-(void)UIConfig{
    self.mainButton.font              = [NSFont systemFontOfSize:titleFontSize_50];
    self.yearLabel.font               = [NSFont systemFontOfSize:titleFontSize_30];
    self.monthLabel.font              = [NSFont systemFontOfSize:titleFontSize_30];
    self.dayLabel.font                = [NSFont systemFontOfSize:titleFontSize_30];
    self.hourLabel.font               = [NSFont systemFontOfSize:titleFontSize_30];
    self.selectYearButton.font        = [NSFont systemFontOfSize:titleFontSize_16];
    self.selectYearButton.tag         = MiddleSubViewTypeYear;
    self.selectMonthButton.font       = [NSFont systemFontOfSize:titleFontSize_16];
    self.selectMonthButton.tag        = MiddleSubViewTypeMonth;
    self.selectDayButton.font         = [NSFont systemFontOfSize:titleFontSize_16];
    self.selectDayButton.tag          = MiddleSubViewTypeDay;
    self.selectHourButton.font        = [NSFont systemFontOfSize:titleFontSize_16];
    self.selectHourButton.tag         = MiddleSubViewTypeHour;
    self.daYunLabel1.font             = [NSFont systemFontOfSize:titleFontSize_20];
    self.daYunLabel2.font             = [NSFont systemFontOfSize:titleFontSize_20];
    self.daYunLabel3.font             = [NSFont systemFontOfSize:titleFontSize_20];
    self.daYunLabel4.font             = [NSFont systemFontOfSize:titleFontSize_20];
    self.daYunLabel5.font             = [NSFont systemFontOfSize:titleFontSize_20];
    self.daYunLabel6.font             = [NSFont systemFontOfSize:titleFontSize_20];
    self.daYunLabel7.font             = [NSFont systemFontOfSize:titleFontSize_20];
    self.textField1.font              = [NSFont systemFontOfSize:titleFontSize_20];
    self.textField2.font              = [NSFont systemFontOfSize:titleFontSize_20];

    self.yearLabel.wantsLayer         = YES;
    self.yearLabel.layer.borderWidth  = 1.0f;
    self.yearLabel.layer.borderColor  = [NSColor lightGrayColor].CGColor;

    self.monthLabel.wantsLayer        = YES;
    self.monthLabel.layer.borderWidth = 1.0f;
    self.monthLabel.layer.borderColor = [NSColor lightGrayColor].CGColor;

    self.dayLabel.wantsLayer          = YES;
    self.dayLabel.layer.borderWidth   = 1.0f;
    self.dayLabel.layer.borderColor   = [NSColor lightGrayColor].CGColor;

    self.hourLabel.wantsLayer         = YES;
    self.hourLabel.layer.borderWidth  = 1.0f;
    self.hourLabel.layer.borderColor  = [NSColor lightGrayColor].CGColor;

    [self.view setBackgroundColor:[NSColor whiteColor]];
    self.view.layer.borderColor       = [NSColor blackColor].CGColor;
    self.view.layer.borderWidth       = 1.0f;
}

-(void)bindViewModel{
    MainViewModel *main = [MainViewModel sharedInstance];
    
    @weakify(self)
    [[[RACSignal combineLatest:@[RACObserve(main.shuangZaoData, year),
                                 RACObserve(main.shuangZaoData, month),
                                 RACObserve(main.shuangZaoData, day),
                                 RACObserve(main.shuangZaoData, hour),]
                        reduce:^id(NSString *year,
                                   NSString *month,
                                   NSString *day,
                                   NSString *hour){
                            
                            return nil;
                        }]
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
         [self resetValue];
         [self resetDaYun];
     }];
    
    ShuangZaoData *shuangZaoData = [[MainViewModel sharedInstance] shuangZaoData];
    [[self.mainButton
      rac_signalForSelector:@selector(mouseDown:)]
     subscribeNext:^(id _){
         @strongify(self)
         if(shuangZaoData.universeType == UniverseTypeQian){
             shuangZaoData.universeType = UniverseTypeKun;
             [self.mainButton setStringValue:@"坤"];
         }
         else{
             shuangZaoData.universeType = UniverseTypeQian;
             [self.mainButton setStringValue:@"乾"];
         }
         [self resetDaYun];
     }];
    
    [[self.bottomNoteTextViewButton rac_signalForSelector:
      @selector(mouseDown:)]
     subscribeNext:^(id _){
         [main.bottomNoteTextViewOperationSig sendNext:nil];
     }];
    
    [[self.selectYearButton rac_signalForSelector:@selector(mouseDown:)] subscribeNext:^(id _){
        @strongify(self)
        [self selectButtonAction:self.selectYearButton];
    }];
    
    [[self.selectMonthButton rac_signalForSelector:@selector(mouseDown:)] subscribeNext:^(id _){
        @strongify(self)
        
        ShuangZaoData *data = [MainViewModel sharedInstance].shuangZaoData;
        if(data.year.length==2){
            [self selectButtonAction:self.selectMonthButton];
        }
        
    }];
    
    [[self.selectDayButton rac_signalForSelector:@selector(mouseDown:)] subscribeNext:^(id _){
        @strongify(self)
        [self selectButtonAction:self.selectDayButton];
    }];
    
    [[self.selectHourButton rac_signalForSelector:@selector(mouseDown:)] subscribeNext:^(id _){
        @strongify(self)
        [self selectButtonAction:self.selectHourButton];
    }];
}

-(void)resetValue{
    ShuangZaoData *data = [MainViewModel sharedInstance].shuangZaoData;
    self.yearLabel.text = data.year;
    self.monthLabel.text = data.month;
    self.dayLabel.text = data.day;
    self.hourLabel.text = data.hour;
}

-(void)resetDaYun{
    ShuangZaoData *data = [MainViewModel sharedInstance].shuangZaoData;
    BottomViewData *bottomData = [MainViewModel sharedInstance].bottomData;
    NSArray *daYunLabelArr = @[self.daYunLabel1,
                               self.daYunLabel2,
                               self.daYunLabel3,
                               self.daYunLabel4,
                               self.daYunLabel5,
                               self.daYunLabel6,
                               self.daYunLabel7,];
    
    NSArray *jiaZiArr = [MainViewModel sharedInstance].jiaZiArr;
    if(data.month.length>0){
        NSInteger yueZhuIndex = [jiaZiArr indexOfObject:data.month];
        for(NSInteger i = 0;i<daYunLabelArr.count;i++){
            NSTextField *label = daYunLabelArr[i];
            label.text = [bottomData getDaYunWithTableIndex:i+1
                                               universeType:data.universeType
                                                     ganZhi:data.year
                                                yueZhuIndex:yueZhuIndex];
        }
    }
    
}

-(void)selectButtonAction:(NSButton*)sender{
     [JiaZiCollectionViewController presentViewControllerWithRect:sender.frame
                                                             view:self
                                                             type:sender.tag];
}

@end
