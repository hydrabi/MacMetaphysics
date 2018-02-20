//
//  BottomContentView.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/14.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BottomContentView.h"
#import "UIConstantParameter.h"
#import "MainViewModel.h"
#import "NSView+Addition.h"
#import "GALFlippedClipView.h"
#import "BottomDataSource.h"
static NSString *myCellReuseIdentifier = @"myCellReuseIdentifier";
static NSString *columnIdentifier = @"columnIdentifier";

@interface BottomContentView ()
//@property (nonatomic,strong)NSScrollView *scrollView;

@property (nonatomic,strong)NSView *testView;
@property (nonatomic,strong)NSClipView *scrollViewContentView;


@property (nonatomic,strong)NSCollectionView *collectionView;
@property (nonatomic,strong)BottomDataSource *collectionViewDataSource;
@end

@implementation BottomContentView

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self collectionViewConfig];
    [self bottomCollectionViewConfig];
    [self bindViewModel];
    
//    [self.bottomCollectionView setBackgroundColor:[NSColor greenColor]];
}

-(void)viewDidAppear{
    [super viewDidAppear];
    [self.bottomCollectionView reloadData];
}

-(void)bottomCollectionViewConfig{
    self.collectionViewDataSource = [[BottomDataSource alloc] initWithCollectionView:self.bottomCollectionView];
    [self.scrollView setBorderType:NSNoBorder];
    [self.scrollView setHasHorizontalScroller:YES];
}

-(void)bindViewModel{
    @weakify(self)
    [[[MainViewModel sharedInstance].reloadBottomTablesSig
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
         [self.bottomCollectionView reloadData];
     }];
    
    RACSignal *lToSSignal       = [[MainViewModel sharedInstance] rac_signalForSelector:@selector(lunarToSolar)];
    RACSignal *sToLSignal       = [[MainViewModel sharedInstance] rac_signalForSelector:@selector(solarToLunar)];
    //乾坤变化信号
    RACSignal *quankunSignal    = [RACObserve([MainViewModel sharedInstance].middleData, universeType) distinctUntilChanged];
    
    [[lToSSignal
      merge:sToLSignal]
     subscribeNext:^(id _){
         @strongify(self)
         [self.bottomCollectionView reloadData];
     }];
    
    [quankunSignal subscribeNext:^(id _){
        [[MainViewModel sharedInstance].bottomData resetData];
        [self.bottomCollectionView reloadData];
    }];
}

@end
