//
//  BottomCollectionViewDataSource.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/22.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BottomCollectionViewDataSource.h"
#import "BottomTableViewCell.h"
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
    flowLayout.minimumLineSpacing = 0.0f;
    flowLayout.minimumInteritemSpacing = 0.0f;
    flowLayout.scrollDirection = NSCollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = flowLayout;
    
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([BottomCollectionViewItem class])
                                                         bundle:nil]
          forItemWithIdentifier:myCellReuseIdentifier];
    
//    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([BottomNormalTableViewHeader class])
//                                                         bundle:nil]
//     forSupplementaryViewOfKind:NSCollectionElementKindSectionHeader
//                 withIdentifier:firstTableViewHeaderIdentifier];
//
//    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([BottomNormalTableViewHeader class])
//                                                         bundle:nil]
//     forSupplementaryViewOfKind:NSCollectionElementKindSectionHeader
//                 withIdentifier:normalTableViewHeaderIdentifier];
    
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
//    cell.yearLabel.text = [NSString stringWithFormat:@"%d",indexPath.section];
//    cell.liuNianLabel.text = [NSString stringWithFormat:@"%d",indexPath.item];
    
    //    MainViewModel *main = [MainViewModel sharedInstance];
    //    if(main.hadHiddenBottomTableView){
    //        if(collectionView.myTag >= main.hiddenBottomTableViewTag){
    //            [cell hideContent];
    //        }
    //        else{
    //            [cell showContent];
    //        }
    //    }
    //    //展示
    //    else{
    //        [cell showContent];
    //    }
    //
    //    NSNumber *key = [BottomLocation createKeyNumberWithTag:collectionView.myTag
    //                                                 indexPath:indexPath];
    //    if([main.liuNianData.bottomLocationDic objectForKey:key]){
    //        [cell selectCell:YES];
    //    }
    //    else{
    //        [cell selectCell:NO];
    //    }
    //
    //    [self fillContentWithCell:cell
    //                    tableView:collectionView
    //                    indexPath:indexPath];
    return cell;
}

//- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    if(section == 0){
//        if(collectionView.myTag == 0){
//            return NSMakeSize(tableViewWidth, tableViewHeaderHeight);
//        }
//        else{
//            return NSMakeSize(tableViewWidth, tableViewHeaderHeight);
//        }
//    }
//    else{
//        return NSMakeSize(tableViewWidth, tableViewMiddleOffset);
//    }
//}
//
//-(NSView*)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.section == 0){
//        if(collectionView.myTag == 0){
//            BottomFirstTableViewHeader *header = [BottomFirstTableViewHeader instanceBasicNibView];
//            header.frame = NSMakeRect(0, 0, CGRectGetWidth(collectionView.frame), tableViewHeaderHeight);
//            return header;
//        }
//        else{
//            BottomNormalTableViewHeader *header = [BottomNormalTableViewHeader instanceBasicNibView];
//            header.frame = NSMakeRect(0, 0, CGRectGetWidth(collectionView.frame), tableViewHeaderHeight);
//            header.tableViewTag = collectionView.myTag;
//            [header reloadData];
//            return header;
//        }
//    }
//    else{
//        NSView *clearView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, CGRectGetWidth(collectionView.frame), tableViewMiddleOffset)];
//        [clearView setBackgroundColor:[NSColor whiteColor]];
//        return clearView;
//    }
//}

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
