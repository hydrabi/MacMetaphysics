//
//  MainViewController.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/4.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "MainViewController.h"
#import "UIConstantParameter.h"
#import "MainViewController+CollectionView.h"

@interface MainViewController ()

@end

@implementation MainViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    [self makeConstraints];
}

#pragma mark - UI
-(void)UIConfig{
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    [self collectionViewConfig];
    
    self.firstVerLine = [[NSView alloc] init];
    self.firstVerLine.wantsLayer = YES;
    self.firstVerLine.layer.backgroundColor = [NSColor blackColor].CGColor;
    [self.view addSubview:self.firstVerLine];
    
    self.secondVerLine = [[NSView alloc] init];
    self.secondVerLine.wantsLayer = YES;
    self.secondVerLine.layer.backgroundColor = [NSColor blackColor].CGColor;
    [self.view addSubview:self.secondVerLine];
    
    self.topContentView = [[TopContentViewController alloc] initWithNibName:NSStringFromClass([TopContentViewController class]) bundle:nil];
    [self addChildViewController:self.topContentView];
    [self.view addSubview:self.topContentView.view];
    
//    self.firstVerLine = [[UIView alloc] init];
//    self.firstVerLine.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:self.firstVerLine];
//    
//    self.secondVerLine = [[UIView alloc] init];
//    self.secondVerLine.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:self.secondVerLine];
//    
//    self.topContentView = [TopContentView instanceTopContentView];
//    [self.view addSubview:self.topContentView];
//    [self.topContentView bindViewModel];
//    
//    self.middleContentView = [[MiddleContentView alloc] init];
//    [self.view addSubview:self.middleContentView];
//    
//    self.bottomContentView = [[BottomContentView alloc] init];
//    [self.view addSubview:self.bottomContentView];
//    
//    self.liuNianTextView = [LiuNianTextView instanceLiuNianTextView];
//    self.liuNianTextView.layer.borderColor = [UIColor blackColor].CGColor;
//    self.liuNianTextView.layer.borderWidth = 1.0f;
//    self.liuNianTextView.hidden = YES;
//    [self.view addSubview:self.liuNianTextView];
//    
//    self.dateLabel = [[UILabel alloc] init];
//    self.dateLabel.font = [UIFont systemFontOfSize:titleFontSize_20];
//    self.dateLabel.textColor = [UIColor blackColor];
//    [self.view addSubview:self.dateLabel];
//    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
//                                                  target:self
//                                                selector:@selector(resetDate)
//                                                userInfo:nil
//                                                 repeats:YES];
//    
//    self.currentTextView = nil;
//    
//    self.daYunTextView = [[DaYunTextView alloc] init];
//    self.daYunTextView.hidden = YES;
//    [self.view addSubview:self.daYunTextView];
//    
//    self.fifteenYunTextView = [[FifteenYunTextView alloc] init];
//    self.fifteenYunTextView.hidden = YES;
//    [self.view addSubview:self.fifteenYunTextView];
//    
//    self.normalTextView = [NormalTextView instanceNormalTextView];
//    self.normalTextView.hidden = YES;
//    [self.view addSubview:self.normalTextView];
//    
//    self.shuangZaoTextView = [ShuangZaoTextView instanceShuangZaoTextView];
//    self.shuangZaoTextView.hidden = YES;
//    [self.view addSubview:self.shuangZaoTextView];
//    [self.shuangZaoTextView resetValue];
//    
//    self.solarTermsView  = [SolarTermsCollectionView createSolarTermsCollectionView];
//    self.solarTermsView.hidden = YES;
//    [self.view addSubview:self.solarTermsView];
//    
//    self.bottomNoteTextView = [LiuNianTextView instanceLiuNianTextView];
//    self.bottomNoteTextView.layer.borderColor = [UIColor blackColor].CGColor;
//    self.bottomNoteTextView.layer.borderWidth = 1.0f;
//    self.bottomNoteTextView.hidden = YES;
//    [self.view addSubview:self.bottomNoteTextView];
    
}

-(void)makeConstraints{
    @weakify(self)

    [self.firstVerLine makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.leftSideMenuCollectionView.trailing).offset(0);
        make.top.equalTo(self.view.top).offset(0);
        make.bottom.equalTo(self.view.bottom).offset(0);
        make.width.equalTo(leftVerLineWidth);
    }];
    
    [self.secondVerLine makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.leftSideMenuCollectionView.trailing).offset(leftVerLineOffset);
        make.top.equalTo(self.view.top).offset(0);
        make.bottom.equalTo(self.view.bottom).offset(0);
        make.width.equalTo(leftVerLineWidth);
    }];
    
    [self.topContentView.view makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.secondVerLine.trailing).offset(0);
        make.top.equalTo(self.view.top).offset(0);
        make.trailing.equalTo(self.view.trailing).offset(0);
        make.height.equalTo(topViewHeight);
    }];
//
//    [self.topContentView makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self)
//        make.leading.equalTo(self.secondVerLine.trailing).offset(0);
//        make.top.equalTo(self.view.top).offset(0);
//        make.trailing.equalTo(self.view.trailing).offset(0);
//        make.height.equalTo(topViewHeight);
//    }];
//    
//    [self.middleContentView makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self)
//        make.leading.equalTo(self.secondVerLine.trailing).offset(0);
//        make.top.equalTo(self.topContentView.bottom).offset(contentViewOffset);
//        make.trailing.equalTo(self.view.trailing).offset(0);
//        make.height.equalTo(middleViewHeight);
//    }];
//    
//    [self.bottomContentView makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self)
//        make.leading.equalTo(self.secondVerLine.trailing).offset(0);
//        make.top.equalTo(self.middleContentView.bottom).offset(contentViewOffset);
//        make.trailing.equalTo(self.view.trailing).offset(0);
//        make.height.equalTo(bottomViewHeight);
//    }];
//    
//    [self.liuNianTextView makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self)
//        make.leading.equalTo(self.secondVerLine.trailing).offset(@(leftVerLineOffset));
//        make.top.equalTo(self.bottomContentView.bottom).offset(leftVerLineOffset);
//        make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset));
//        make.height.equalTo(bottomTextViewHeight);
//    }];
//    
//    [self.dateLabel makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self)
//        make.trailing.equalTo(self.view.trailing).offset(@(-offset_16));
//        make.bottom.equalTo(self.view.bottom).offset(0);
//    }];
//    
//    [self.daYunTextView makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self)
//        make.leading.equalTo(self.secondVerLine.trailing).offset(leftVerLineOffset);
//        make.top.equalTo(self.bottomContentView.top).offset(tableViewHeaderHeight);
//        make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset));
//        make.height.equalTo(daYunTextViewHeight);
//    }];
//    
//    [self.fifteenYunTextView makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self)
//        make.leading.equalTo(self.secondVerLine.trailing).offset(leftVerLineOffset);
//        make.top.equalTo(self.bottomContentView.top).offset(tableViewHeaderHeight);
//        make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset));
//        make.height.equalTo(daYunSubTextViewHeight);
//    }];
//    
//    [self.normalTextView makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self)
//        make.leading.equalTo(self.secondVerLine.trailing).offset(leftVerLineOffset);
//        make.top.equalTo(self.bottomContentView.top).offset(tableViewHeaderHeight);
//        make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset));
//        make.height.equalTo(normalTextViewHeight);
//    }];
//    
//    [self.shuangZaoTextView makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self)
//        make.leading.equalTo(self.secondVerLine.trailing).offset(leftVerLineOffset);
//        make.top.equalTo(self.view.top).offset(0);
//        make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset));
//        make.height.equalTo(topViewHeight);
//    }];
//    
//    [self.solarTermsView makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self)
//        make.leading.equalTo(self.secondVerLine.trailing).offset(leftVerLineOffset-1);
//        make.top.equalTo(self.bottomContentView.top).offset(0);
//        make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset+1));
//        make.height.equalTo(bottomViewHeight);
//    }];
//    
//    [self.bottomNoteTextView makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self)
//        make.leading.equalTo(self.secondVerLine.trailing).offset(@(leftVerLineOffset));
//        make.top.equalTo(self.bottomContentView.bottom).offset(leftVerLineOffset);
//        make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset));
//        make.height.equalTo(bottomTextViewHeight);
//    }];
}

@end
