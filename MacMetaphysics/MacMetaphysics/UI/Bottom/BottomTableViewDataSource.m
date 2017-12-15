//
//  BottomTableViewDataSource.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/15.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BottomTableViewDataSource.h"
#import "BottomTableViewCell.h"
#import "BottomFirstTableViewHeader.h"
#import "BottomNormalTableViewHeader.h"
#import "UIConstantParameter.h"
#import "MainViewModel.h"
#import "BottomLocation.h"
#import "NSString+Addition.h"
#import "NSView+Addition.h"
static NSString *cellReuseIdentifier = @"cellReuseIdentifier";
static NSString *firstTableViewHeaderIdentifier = @"firstTableViewHeaderIdentifier";
static NSString *normalTableViewHeaderIdentifier = @"normalTableViewHeaderIdentifier";

@interface BottomTableViewDataSource()
@property (nonatomic,weak)NSMutableArray<NSCollectionView*> *collectionViews;
@end

@implementation BottomTableViewDataSource

-(instancetype)initWithCollectionViews:(NSMutableArray*)collectionViewArr{
    self = [super init];
    if(self){
        self.collectionViews = collectionViewArr;
        [self UIConfig];
    }
    return self;
}

-(void)UIConfig{
    for(NSCollectionView *collectionView in self.collectionViews){
        [collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([BottomTableViewCell class])
                                                             bundle:nil]
              forItemWithIdentifier:cellReuseIdentifier];
        
        [collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([BottomNormalTableViewHeader class])
                                                             bundle:nil]
         forSupplementaryViewOfKind:NSCollectionElementKindSectionHeader
                     withIdentifier:firstTableViewHeaderIdentifier];
        
        [collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([BottomNormalTableViewHeader class])
                                                             bundle:nil]
         forSupplementaryViewOfKind:NSCollectionElementKindSectionHeader
                     withIdentifier:normalTableViewHeaderIdentifier];
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        NSCollectionViewFlowLayout *flowLayout = [[NSCollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = NSMakeSize(tableViewWidth, tableViewCellHeight);
        flowLayout.minimumLineSpacing = 0.0f;
        flowLayout.minimumInteritemSpacing = 0.0f;
        collectionView.collectionViewLayout = flowLayout;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return tableViewSection;
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return rowPerSection;
}

-(NSCollectionViewItem*)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    BottomTableViewCell *cell = [collectionView makeItemWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];

    MainViewModel *main = [MainViewModel sharedInstance];
    if(main.hadHiddenBottomTableView){
        if(collectionView.tag >= main.hiddenBottomTableViewTag){
            [cell hideContent];
        }
        else{
            [cell showContent];
        }
    }
    //展示
    else{
        [cell showContent];
    }
    
    NSNumber *key = [BottomLocation createKeyNumberWithTag:collectionView.tag
                                                 indexPath:indexPath];
    if([main.liuNianData.bottomLocationDic objectForKey:key]){
        [cell selectCell:YES];
    }
    else{
        [cell selectCell:NO];
    }
    
    [self fillContentWithCell:cell
                    tableView:collectionView
                    indexPath:indexPath];
    return cell;
}

-(NSView*)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(collectionView.tag == 0){
            BottomFirstTableViewHeader *header = [BottomFirstTableViewHeader instanceBasicNibView];
            header.frame = CGRectMake(0, 0, CGRectGetWidth(collectionView.frame), tableViewHeaderHeight);
            return header;
        }
        else{
            BottomNormalTableViewHeader *header = [BottomNormalTableViewHeader instanceBasicNibView];
            header.frame = CGRectMake(0, 0, CGRectGetWidth(collectionView.frame), tableViewHeaderHeight);
            header.tableViewTag = collectionView.tag;
            [header reloadData];
            return header;
        }
    }
    else{
        NSView *clearView = [[NSView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(collectionView.frame), tableViewMiddleOffset)];
        [clearView setBackgroundColor:[NSColor whiteColor]];
        return clearView;
    }
}

-(void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths{
    
    for(NSIndexPath *indexPath in indexPaths){
        BottomTableViewCell *cell = (BottomTableViewCell*)[collectionView itemAtIndexPath:indexPath];
        
        if(cell.liuNianLabel.text.length>0){
            MainViewModel *main = [MainViewModel sharedInstance];
            //隐藏的时候不能点击
            if(main.hadHiddenBottomTableView){
                if(collectionView.tag < main.hiddenBottomTableViewTag){
                    [[MainViewModel sharedInstance] selectTableViewTag:collectionView.tag
                                                             indexPath:indexPath];
                }
            }
            //展示
            else{
                [[MainViewModel sharedInstance] selectTableViewTag:collectionView.tag
                                                         indexPath:indexPath];
            }
        }
    }
    
    
}

-(void)fillContentWithCell:(BottomTableViewCell*)cell
                 tableView:(NSCollectionView*)tableView
                 indexPath:(NSIndexPath *)indexPath{
    
    MainViewModel *mainViewModle = [MainViewModel sharedInstance];
    BottomViewData *bottomData = mainViewModle.bottomData;
    
    [bottomData fillContentWithTableIndex:tableView.tag
                             tableSection:indexPath.section
                                 tableRow:indexPath.item
                                    block:^(NSString *liuNian,NSString *xiaoYun,NSString *year){
                                        cell.liuNianLabel.text = liuNian;
                                        cell.yearLabel.text = year;
                                    }];
}

@end
