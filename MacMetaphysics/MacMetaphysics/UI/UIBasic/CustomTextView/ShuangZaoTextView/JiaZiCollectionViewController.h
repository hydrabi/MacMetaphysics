//
//  JiaZiCollectionViewController.h
//  MacMetaphysics
//
//  Created by Hydra on 2018/1/14.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "BasicViewController.h"
#import "MainViewModel.h"
@interface JiaZiCollectionViewController : BasicViewController<NSCollectionViewDelegate,NSCollectionViewDataSource>
@property (nonatomic,strong)NSCollectionView *collectionView;

@property (nonatomic,assign)MiddleSubViewType type;

+(NSPopover*)presentViewControllerWithRect:(NSRect)rect view:(NSViewController*)viewController type:(MiddleSubViewType)type;
@end
