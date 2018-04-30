//
//  MainViewController.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/4.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BasicViewController.h"
#import "MainViewModel.h"
#import "TopContentViewController.h"
#import "MiddleContentView.h"
#import "BottomContentView.h"
#import "SolarTermsCollectionView.h"
#import "ShuangZaoTextView.h"
#import "FifteenYunTextView.h"
#import "NormalTextView.h"
#import "LiuNianTextView.h"

@interface MainViewController : BasicViewController<NSLayoutManagerDelegate>

/**
 主要的viewModel
 */
@property (nonatomic,strong)MainViewModel *viewModel;

/**
 左边的菜单的collectionView
 */
@property (nonatomic,strong)NSCollectionView *leftSideMenuCollectionView;

/**
 两条竖的分割线
 */
@property (nonatomic,strong)NSView *firstVerLine;
@property (nonatomic,strong)NSView *secondVerLine;

/**
 中间的四个命柱
 */
@property (nonatomic,strong)MiddleContentView *middleContentView;

/**
 顶部输入视图控制器
 */
@property (nonatomic,strong)TopContentViewController *topContentView;

/**
 底部包含小运大运的视图控制器
 */
@property (nonatomic,strong)BottomContentView *bottomContentView;

/**
 在双造中出现的底部空白textView,笔记的作用
 */
@property (nonatomic,strong)NSTextView *bottomNoteTextView;

/**
 日期时间
 */
@property (nonatomic,strong)NSTextField *dateLabel;

/**
 日期计时器
 */
@property (nonatomic,strong)NSTimer *timer;

@property (nonatomic,weak)NSView *currentTextView;

/**
 节气视图
 */
@property (nonatomic,strong)SolarTermsCollectionView *solarTermsView;

/**
 双造视图
 */
@property (nonatomic,strong)ShuangZaoTextView *shuangZaoTextView;

/**
 十五运
 */
@property (nonatomic,strong)FifteenYunTextView *fifteenYunTextView;

/**
 普通窗口
 */
@property (nonatomic,strong)NormalTextView *normalTextView;

///**
// 在双造中出现的底部空白textView,笔记的作用
// */
//@property (nonatomic,strong)LiuNianTextView *liuNianTextView;

#pragma mark - 左边用神到官司共11个textView

/**
 用神textView
 */
@property (nonatomic,strong)LiuNianTextView *yongShenTextView;

/**
 格局textView
 */
@property (nonatomic,strong)LiuNianTextView *geJuTextView;

/**
 相貌textView
 */
@property (nonatomic,strong)LiuNianTextView *xiangMaoTextView;

/**
 文凭textView
 */
@property (nonatomic,strong)LiuNianTextView *wenPingTextView;

/**
 父母textView
 */
@property (nonatomic,strong)LiuNianTextView *fuMuTextView;

/**
 兄弟textView
 */
@property (nonatomic,strong)LiuNianTextView *xiongDiTextView;

/**
 子女textView
 */
@property (nonatomic,strong)LiuNianTextView *ziNvTextView;

/**
 婚姻textView
 */
@property (nonatomic,strong)LiuNianTextView *hunYinTextView;

/**
 官贵textView
 */
@property (nonatomic,strong)LiuNianTextView *guanGuiTextView;

/**
 财富textView
 */
@property (nonatomic,strong)LiuNianTextView *caiFuTextView;

/**
 官司textView
 */
@property (nonatomic,strong)LiuNianTextView *guanSiTextView;

/**
 当前底部的textView
 */
@property (nonatomic,strong)LiuNianTextView *currentBottomTextView;

/**
 底部的textView集合
 */
@property (nonatomic,strong)NSMutableArray *bottomTextViewArr;

#pragma mark - 分界线

@property (nonatomic,strong) NSBox *firHorline;
@property (nonatomic,strong) NSBox *secondHorline;
@property (nonatomic,strong) NSBox *firstBorderVerLine;
@property (nonatomic,strong) NSBox *secondBorderVerLine;

@end
