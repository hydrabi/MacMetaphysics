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
#import "NSView+Addition.h"

@interface MainViewController ()

@end

@implementation MainViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    [self makeConstraints];
    [self bindViewModel];
    [self setUpBorderLine];
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
    
    NSTextStorage *storage = [[NSTextStorage alloc] init];
    NSLayoutManager *layout = [[NSLayoutManager alloc] init];
    NSTextContainer *container = [NSTextContainer new];
    [layout addTextContainer:container];
    layout.delegate = self;
    [storage addLayoutManager:layout];
    self.bottomNoteTextView = [[NSTextView alloc] initWithFrame:NSZeroRect
                                                  textContainer:container];
    self.bottomNoteTextView.font = [NSFont systemFontOfSize:titleFontSize_20];
    [self.bottomNoteTextView setMinSize:NSMakeSize(1000, bottomTextViewHeight)];
    [[self.bottomNoteTextView textContainer]setContainerSize:NSMakeSize(screenWidth - leftSideTableViewWidth - leftVerLineWidth*2 - leftVerLineOffset*2, FLT_MAX)];
    [[self.bottomNoteTextView textContainer]setWidthTracksTextView:YES];
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
    
    self.shuangZaoTextView = [ShuangZaoTextView addWithParentViewController:self];
    self.shuangZaoTextView.view.hidden = YES;
    
    self.fifteenYunTextView = [[FifteenYunTextView alloc] init];
    self.fifteenYunTextView.view.hidden = YES;
    [self addChildViewController:self.fifteenYunTextView];
    [self.view addSubview:self.fifteenYunTextView.view];
    
    self.normalTextView = [[NormalTextView alloc] init];
    self.normalTextView.view.hidden = YES;
    [self addChildViewController:self.normalTextView];
    [self.view addSubview:self.normalTextView.view];
    
    self.liuNianTextView = [[LiuNianTextView alloc] init];
    [self addChildViewController:self.liuNianTextView];
    self.liuNianTextView.view.hidden = YES;
    [self.view addSubview:self.liuNianTextView.view];
    
    
}

-(void)setUpBorderLine{
    self.firHorline = [[NSBox alloc] init];
    [self.firHorline setBoxType:NSBoxOldStyle];
    [self.view addSubview:self.firHorline];
    
    self.secondHorline = [[NSBox alloc] init];
    [self.secondHorline setBoxType:NSBoxOldStyle];
    [self.view addSubview:self.secondHorline];
    
    self.firstBorderVerLine = [[NSBox alloc] init];
    [self.firstBorderVerLine setBoxType:NSBoxOldStyle];
    [self.view addSubview:self.firstBorderVerLine];
    
    self.secondBorderVerLine = [[NSBox alloc] init];
    [self.secondBorderVerLine setBoxType:NSBoxOldStyle];
    [self.view addSubview:self.secondBorderVerLine];
    
    [self.firHorline setBackgroundColor:[NSColor blackColor]];
    [self.secondHorline setBackgroundColor:[NSColor blackColor]];
    [self.firstBorderVerLine setBackgroundColor:[NSColor blackColor]];
    [self.secondBorderVerLine setBackgroundColor:[NSColor blackColor]];
    
    @weakify(self)
    [self.firHorline makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.trailing.top.equalTo(self.view).offset(0);
        make.height.equalTo(2);
    }];
    
    [self.secondHorline makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.trailing.bottom.equalTo(self.view).offset(0);
        make.height.equalTo(2);
    }];
    
    [self.firstBorderVerLine makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.top.bottom.equalTo(self.view).offset(0);
        make.width.equalTo(2);
    }];
    
    [self.secondBorderVerLine makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.trailing.top.bottom.equalTo(self.view).offset(0);
        make.width.equalTo(2);
    }];
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

    [self.liuNianTextView.view makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.secondVerLine.trailing).offset(@(leftVerLineOffset));
        make.top.equalTo(self.bottomContentView.view.bottom).offset(leftVerLineOffset);
        make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset));
        make.height.equalTo(bottomTextViewHeight);
    }];
//
//    
//    [self.daYunTextView makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self)
//        make.leading.equalTo(self.secondVerLine.trailing).offset(leftVerLineOffset);
//        make.top.equalTo(self.bottomContentView.top).offset(tableViewHeaderHeight);
//        make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset));
//        make.height.equalTo(daYunTextViewHeight);
//    }];
//    
    [self.fifteenYunTextView.view makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.secondVerLine.trailing).offset(leftVerLineOffset);
        make.top.equalTo(self.bottomContentView.view.top).offset(tableViewHeaderHeight - 10);
        make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset));
        make.height.equalTo(daYunSubTextViewHeight);
    }];

    [self.normalTextView.view makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.secondVerLine.trailing).offset(0);
        make.top.equalTo(self.bottomContentView.view.top).offset(tableViewHeaderHeight - 10);
        make.trailing.equalTo(self.view.trailing).offset(0);
        make.height.equalTo(normalTextViewHeight);
    }];

    [self.shuangZaoTextView.view makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.secondVerLine.trailing).offset(leftVerLineOffset);
        make.top.equalTo(self.view.top).offset(0);
        make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset));
        make.height.equalTo(topViewHeight);
    }];
    
    [self.solarTermsView makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.secondVerLine.trailing).offset(leftVerLineOffset-1);
        make.top.equalTo(self.bottomContentView.view.top).offset(0);
        make.trailing.equalTo(self.view.trailing).offset(@(-leftVerLineOffset+1));
        make.height.equalTo(bottomViewHeight);
    }];

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
    [[mainViewModel.leftMenuClickTextViewOperationSig
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
         if([MainViewModel sharedInstance].currentBottomSectionMenuType != LeftSideMenuTypeEmpty){
             [self.liuNianTextView reloadData];
             self.liuNianTextView.view.hidden = NO;
         }
         else{
             self.liuNianTextView.view.hidden = YES;
         }
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
//                     [self resetCurrentTextView:self.normalTextView.view];
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
         if([mainViewModel.currentSelectTopSectionMenuTypeArr containsObject:@(LeftSideMenuTypeShuangZao)]){
             self.shuangZaoTextView.view.hidden = NO;
         }
         else{
             self.shuangZaoTextView.view.hidden = YES;
         }
     }];
    
    //15运选中操作
    [[mainViewModel.fifteenYunTextViewOperationSig
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
         if(mainViewModel.fifteenYunData.fifteenYunSelectedNumber != -1){
             [self resetCurrentTextView:self.fifteenYunTextView.view];
         }
         else{
             [self resetCurrentTextView:nil];
         }
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
         [self.leftSideMenuCollectionView reloadData];
     }];
    
    //在双造中出现的底部空白textView
    [mainViewModel.bottomNoteTextViewOperationSig subscribeNext:^(id _){
        @strongify(self)
        self.bottomNoteTextView.hidden = !self.bottomNoteTextView.hidden;
    }];
}

#pragma mark - NSLayoutManagerDelegate
-(CGFloat)layoutManager:(NSLayoutManager *)layoutManager lineSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(NSRect)rect{
    return 5;
}

@end
