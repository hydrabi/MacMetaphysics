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
@interface MainViewController : BasicViewController

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

@end
