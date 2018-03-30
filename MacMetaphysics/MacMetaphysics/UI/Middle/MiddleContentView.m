//
//  MiddleContentView.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/9.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "MiddleContentView.h"
#import "MiddleSubView.h"
#import "UIConstantParameter.h"
@interface MiddleContentView ()
//乾坤
@property (nonatomic,strong)NSTextField *genderButton;
@property (nonatomic,strong)MiddleSubView *yearSubView;
@property (nonatomic,strong)MiddleSubView *monthSubView;
@property (nonatomic,strong)MiddleSubView *daySubView;
@property (nonatomic,strong)MiddleSubView *hourSubView;
@end

@implementation MiddleContentView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    [self bindViewModel];
}

-(void)UIConfig{
    self.genderButton = [NSTextField textFieldWithString:@"乾"];
    [self.genderButton setTextColor:[NSColor blackColor]];
    [self.genderButton setFont:[NSFont systemFontOfSize:titleFontSize_70]];
    self.genderButton.selectable = NO;
    self.genderButton.bordered = NO;
    [self.view addSubview:self.genderButton];

    self.yearSubView = [[MiddleSubView alloc] initWithType:MiddleSubViewTypeYear];
    [self addChildViewController:self.yearSubView];
    [self.view addSubview:self.yearSubView.view];

    self.monthSubView = [[MiddleSubView alloc] initWithType:MiddleSubViewTypeMonth];
    [self addChildViewController:self.monthSubView];
    [self.view addSubview:self.monthSubView.view];

    self.daySubView = [[MiddleSubView alloc] initWithType:MiddleSubViewTypeDay];
    [self addChildViewController:self.daySubView];
    [self.view addSubview:self.daySubView.view];

    self.hourSubView = [[MiddleSubView alloc] initWithType:MiddleSubViewTypeHour];
    [self addChildViewController:self.hourSubView];
    [self.view addSubview:self.hourSubView.view];

    [self makeConstraints];
}

-(void)makeConstraints{
    @weakify(self)
    [self.genderButton makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.view.leading).offset(offset_16);
        make.top.equalTo(self.view.top).offset(offset_16);
        make.width.and.height.equalTo(middleMainButtonWidthAndheight);
        make.trailing.equalTo(self.yearSubView.view.leading).offset(-(middleViewOffset));
    }];

    NSArray *tempArr = @[self.yearSubView,
                         self.monthSubView,
                         self.daySubView,
                         self.hourSubView];
    MiddleSubView *lastView = nil;

    for(NSInteger i = 0;i < tempArr.count; i++){
        MiddleSubView *subView = tempArr[i];
        [subView.view makeConstraints:^(MASConstraintMaker *make){
            @strongify(self)
            make.top.equalTo(self.view.top).offset(0);
            make.bottom.equalTo(self.view.bottom).offset(0);
            if(lastView){
                make.leading.equalTo(lastView.view.trailing).offset(middleViewOffset);
                make.width.equalTo(lastView.view.width);
            }

            if(i == tempArr.count - 1){
                make.trailing.equalTo(self.view.trailing).offset(@(-(middleViewOffset)));
            }
        }];

        lastView = subView;
    }
}

-(void)bindViewModel{

    RACSignal *lToSSignal       = [[MainViewModel sharedInstance] rac_signalForSelector:@selector(lunarToSolar)];
    RACSignal *sToLSignal       = [[MainViewModel sharedInstance] rac_signalForSelector:@selector(solarToLunar)];
    //乾坤变化信号
    RACSignal *quankunSignal    = [RACObserve([MainViewModel sharedInstance].middleData, universeType) distinctUntilChanged];
    @weakify(self)
    [[[lToSSignal
       merge:sToLSignal]
      merge:quankunSignal]
     subscribeNext:^(id _){
         @strongify(self)
         [self.yearSubView reloadData];
         [self.monthSubView reloadData];
         [self.daySubView reloadData];
         [self.hourSubView reloadData];
     }];

    MiddleViewData *middleData = [[MainViewModel sharedInstance] middleData];
    [[self.genderButton
      rac_signalForSelector:@selector(mouseDown:)]
     subscribeNext:^(id _){
         @strongify(self)
         if(middleData.universeType == UniverseTypeQian){
             middleData.universeType = UniverseTypeKun;
             [self.genderButton setStringValue:@"坤"];
         }
         else{
             middleData.universeType = UniverseTypeQian;
             [self.genderButton setStringValue:@"乾"];
         }
     }];
    
    //接收到清空通知
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:notificationKey_clearAllData
                                                            object:nil]
      takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(id _){
        @strongify(self)
         [self.yearSubView clearData];
         [self.monthSubView clearData];
         [self.daySubView clearData];
         [self.hourSubView clearData];
    }];
}

@end
