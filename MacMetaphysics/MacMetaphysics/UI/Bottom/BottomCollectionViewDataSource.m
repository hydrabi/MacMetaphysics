//
//  BottomCollectionViewDataSource.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/22.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BottomCollectionViewDataSource.h"
#import "BottomFirstTableViewHeader.h"
#import "BottomNormalTableViewHeader.h"
#import "UIConstantParameter.h"
#import "MainViewModel.h"
#import "BottomLocation.h"
#import "NSString+Addition.h"
#import "NSView+Addition.h"
#import "BottomCollectionViewItem.h"

static NSString *myCellReuseIdentifier = @"myCellReuseIdentifier";
static NSString *firstTableViewHeaderIdentifier = @"firstTableViewHeaderIdentifier";
static NSString *normalTableViewHeaderIdentifier = @"normalTableViewHeaderIdentifier";

@interface BottomCollectionViewDataSource()
@property (nonatomic,weak)NSCollectionView *collectionView;
@end

@implementation BottomCollectionViewDataSource

-(instancetype)initWithCollectionView:(NSCollectionView*)collectionView{
    self = [super init];
    if(self){
        _collectionView = collectionView;
        [self UIConfig];
    }
    return self;
}

-(void)UIConfig{
    
    NSCollectionViewFlowLayout *flowLayout = [[NSCollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = NSMakeSize(tableViewWidth, scrollViewHeight);
    flowLayout.minimumLineSpacing = 20.0f;
    flowLayout.scrollDirection = NSCollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = NSEdgeInsetsMake(0, 20, 0, 20);
    self.collectionView.collectionViewLayout = flowLayout;
    
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([BottomCollectionViewItem class])
                                                         bundle:nil]
          forItemWithIdentifier:myCellReuseIdentifier];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView reloadData];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return tableViewCount;
}

-(NSCollectionViewItem*)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    
    BottomCollectionViewItem *cell = [collectionView makeItemWithIdentifier:myCellReuseIdentifier forIndexPath:indexPath];
    [cell reloadDataWithTag:indexPath.item];
    return cell;
}


//-(void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths{
//
//    for(NSIndexPath *indexPath in indexPaths){
//        BottomTableViewCell *cell = (BottomTableViewCell*)[collectionView itemAtIndexPath:indexPath];
//
//        if(cell.liuNianLabel.text.length>0){
//            MainViewModel *main = [MainViewModel sharedInstance];
//            //隐藏的时候不能点击
//            if(main.hadHiddenBottomTableView){
//                if(collectionView.myTag < main.hiddenBottomTableViewTag){
//                    [[MainViewModel sharedInstance] selectTableViewTag:collectionView.myTag
//                                                             indexPath:indexPath];
//                }
//            }
//            //展示
//            else{
//                [[MainViewModel sharedInstance] selectTableViewTag:collectionView.myTag
//                                                         indexPath:indexPath];
//            }
//        }
//    }
//}

//-(void)fillContentWithCell:(BottomTableViewCell*)cell
//                 tableView:(NSCollectionView*)tableView
//                 indexPath:(NSIndexPath *)indexPath{
//    
//    MainViewModel *mainViewModle = [MainViewModel sharedInstance];
//    BottomViewData *bottomData = mainViewModle.bottomData;
//    
//    [bottomData fillContentWithTableIndex:tableView.myTag
//                             tableSection:indexPath.section
//                                 tableRow:indexPath.item
//                                    block:^(NSString *liuNian,NSString *xiaoYun,NSString *year){
//                                        cell.liuNianLabel.text = liuNian;
//                                        cell.yearLabel.text = year;
//                                    }];
//}

@end
