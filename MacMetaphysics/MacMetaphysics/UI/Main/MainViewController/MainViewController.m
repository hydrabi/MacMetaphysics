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
    [self bindViewModel];
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
    
    self.bottomContentView = [[BottomContentView alloc] init];
    [self addChildViewController:self.bottomContentView];
    [self.view addSubview:self.bottomContentView.view];
    
    self.bottomNoteTextView = [[NSTextView alloc] init];
    [self.bottomNoteTextView setMinSize:NSMakeSize(1000, bottomTextViewHeight)];
    [self.view addSubview:self.bottomNoteTextView];
    
    self.dateLabel = [[NSTextField alloc] init];
    self.dateLabel.font = [NSFont systemFontOfSize:titleFontSize_20];
    self.dateLabel.bordered = NO;
    self.dateLabel.textColor = [NSColor blackColor];
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.dateLabel.alignment = NSTextAlignmentRight;
    [self.view addSubview:self.dateLabel];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(resetDate)
                                                userInfo:nil
                                                 repeats:YES];
    
    self.currentTextView = nil;
    
    self.solarTermsView  = [SolarTermsCollectionView createSolarTermsCollectionView];
    self.solarTermsView.hidden = YES;
    [self.view addSubview:self.solarTermsView];
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

    [self.bottomContentView.view makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.secondVerLine.trailing).offset(0);
        make.top.equalTo(self.middleContentView.view.bottom).offset(contentViewOffset);
        make.trailing.equalTo(self.view.trailing).offset(0);
        make.height.equalTo(bottomViewHeight);
    }];
    
    [self.bottomNoteTextView makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.secondVerLine.trailing).offset(@(leftVerLineOffset));
        make.top.equalTo(self.bottomContentView.view.bottom).offset(leftVerLineOffset);
        make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset));
        make.height.equalTo(bottomTextViewHeight);
    }];
    
    [self.dateLabel makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.trailing.equalTo(self.view.trailing).offset(@(-offset_16));
        make.bottom.equalTo(self.view.bottom).offset(0);
        make.width.equalTo(300);
    }];
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
    [self.solarTermsView makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.secondVerLine.trailing).offset(leftVerLineOffset-1);
        make.top.equalTo(self.bottomContentView.view.top).offset(0);
        make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset+1));
        make.height.equalTo(bottomViewHeight);
    }];
//
//    [self.bottomNoteTextView makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self)
//        make.leading.equalTo(self.secondVerLine.trailing).offset(@(leftVerLineOffset));
//        make.top.equalTo(self.bottomContentView.bottom).offset(leftVerLineOffset);
//        make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset));
//        make.height.equalTo(bottomTextViewHeight);
//    }];
}

-(void)resetCurrentTextView:(NSView*)view{
    self.currentTextView.hidden = YES;
    if(view != nil){
        self.currentTextView = view;
        self.currentTextView.hidden = NO;
    }
}

-(void)resetDate{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.dateLabel.text = [format stringFromDate:[NSDate date]];
}

-(void)bindViewModel{
    @weakify(self)
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    //流年底部textView操作
    [[mainViewModel.LiuNianTextViewOperationSig
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
//         if([MainViewModel sharedInstance].hadShowLiuNianTextView){
//             self.liuNianTextView.hidden = NO;
//         }
//         else{
//             self.liuNianTextView.hidden = YES;
//         }
     }];
    
    //左边菜单底部选项选中操作
    [[[RACObserve(mainViewModel, currentBottomSectionMenuType)
       distinctUntilChanged]
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
         if(mainViewModel.currentBottomSectionMenuType == LeftSideMenuTypeEmpty){
             [self resetCurrentTextView:nil];
         }
         else{
             
             switch (mainViewModel.currentBottomSectionMenuType) {
                     //                 case LeftSideMenuTypeDaYun:
                     //                 {
                     //                     [self resetCurrentTextView:self.daYunTextView];
                     //                     [self.daYunTextView reloadData];
                     //                 }
                     //                     break;
                     //
                 default:
                 {
//                     [self resetCurrentTextView:self.normalTextView];
//                     [self.normalTextView reloadData];
                 }
                     break;
             }
         }
     }];
    
    //左边菜单上边部分选中
    [[mainViewModel.leftMenuTopSelectedOperationSig
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
//         if([mainViewModel.currentSelectTopSectionMenuTypeArr containsObject:@(LeftSideMenuTypeShuangZao)]){
//             self.shuangZaoTextView.hidden = NO;
//         }
//         else{
//             self.shuangZaoTextView.hidden = YES;
//         }
     }];
    
    //15运选中操作
    [[mainViewModel.fifteenYunTextViewOperationSig
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
//         if(mainViewModel.fifteenYunData.fifteenYunSelectedNumber != -1){
//             [self resetCurrentTextView:self.fifteenYunTextView];
//         }
//         else{
//             [self resetCurrentTextView:nil];
//         }
     }];
    
    //节气表选中操作
    [[RACObserve(mainViewModel, hadShowSolarTermsCollectionView)
      deliverOnMainThread]
     subscribeNext:^(id _){
         if(mainViewModel.hadShowSolarTermsCollectionView){
             [self resetCurrentTextView:self.solarTermsView];
         }
         else{
             [self resetCurrentTextView:nil];
         }
     }];
    
    //左边的菜单tableview刷新数据
    [[mainViewModel.reloadLeftTableSig
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
//         [self.leftSideMenuTabelView reloadData];
     }];
    
    //在双造中出现的底部空白textView
    [mainViewModel.bottomNoteTextViewOperationSig subscribeNext:^(id _){
        @strongify(self)
        self.bottomNoteTextView.hidden = !self.bottomNoteTextView.hidden;
    }];
}

@end
