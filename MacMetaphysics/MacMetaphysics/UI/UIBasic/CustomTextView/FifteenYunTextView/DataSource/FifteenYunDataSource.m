//
//  FifteenYunDataSource.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/16.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "FifteenYunDataSource.h"
#import "UIConstantParameter.h"
#import "NSView+Addition.h"
#import "FifteenYunCollectionViewItem.h"
#import "MainViewModel.h"

static NSString *myCellReuseIdentifier = @"myCellReuseIdentifier";

@interface FifteenYunDataSource()
@property (nonatomic,weak)NSCollectionView *collectionView;
@end

@implementation FifteenYunDataSource

-(instancetype)initWithCollectionView:(NSCollectionView*)collectionView{
    self = [super init];
    if(self){
        _collectionView = collectionView;
        [self UIConfig];
        [self registerNib];
    }
    return self;
}

-(void)UIConfig{
    
    NSCollectionViewFlowLayout *flowLayout = [[NSCollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = NSMakeSize(daYunSubTableViewWidth, daYunSubTableCellHeight);
    flowLayout.minimumLineSpacing = 0.0f;
    flowLayout.scrollDirection = NSCollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = NSEdgeInsetsZero;
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView reloadData];
}

-(void)registerNib{
    
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([FifteenYunCollectionViewItem class])
                                                              bundle:nil]
               forItemWithIdentifier:myCellReuseIdentifier];
}

#pragma mark - delegate

-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return daYunSubTableViewCount/2;
}

-(NSCollectionViewItem*)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    
    FifteenYunCollectionViewItem *cell = [collectionView makeItemWithIdentifier:myCellReuseIdentifier forIndexPath:indexPath];
    
    [self fillContentWithCell:cell
                    indexPath:indexPath];
    return cell;
}

-(NSView*)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        NSView *clearView = [[NSView alloc] init];
        [clearView setBackgroundColor:[NSColor clearColor]];
        return clearView;
    }
    else{
        return nil;
    }
}

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return NSMakeSize(daYunSubTableViewWidth, daYunSubTableViewMiddleOffset);
    }
    return NSZeroSize;
}

-(void)fillContentWithCell:(FifteenYunCollectionViewItem*)cell
                 indexPath:(NSIndexPath *)indexPath{
    
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    BottomViewData *bottomData = mainViewModel.bottomData;
    
    [bottomData fillContentWithTableIndex:mainViewModel.fifteenYunData.fifteenYunSelectedNumber
                             tableSection:indexPath.section
                                 tableRow:indexPath.item
                                    block:^(NSString *liuNian,NSString *xiaoYun,NSString *year){
                                        cell.yearLabel.text = year;
                                        cell.liuNianLabel.text = liuNian;
                                        cell.xiaoYunLabel.text = xiaoYun;
                                    }];
}

@end
