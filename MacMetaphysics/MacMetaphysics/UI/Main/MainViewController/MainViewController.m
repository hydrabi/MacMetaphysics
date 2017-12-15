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
       
    self.middleContentView = [[MiddleContentView alloc] init];
    [self addChildViewController:self.middleContentView];
    [self.view addSubview:self.middleContentView.view];
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
 
    [self.middleContentView.view makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.secondVerLine.trailing).offset(0);
        make.top.equalTo(self.topContentView.view.bottom).offset(contentViewOffset);
        make.trailing.equalTo(self.view.trailing).offset(0);
        make.height.equalTo(middleViewHeight);
    }];
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
