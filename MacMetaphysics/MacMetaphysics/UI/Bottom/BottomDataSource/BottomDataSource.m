//
//  BottomDataSource.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/12.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "BottomDataSource.h"
#import "UIConstantParameter.h"
#import "BottomNormalTableViewHeader.h"
#import "NSView+Addition.h"
#import "BottomGroupCollectionViewItem.h"

static NSString *myCellReuseIdentifier = @"myCellReuseIdentifier";
static NSString *firstTableViewHeaderIdentifier = @"firstTableViewHeaderIdentifier";
static NSString *normalTableViewHeaderIdentifier = @"normalTableViewHeaderIdentifier";

@interface BottomDataSource()
@property (nonatomic,weak)NSCollectionView *collectionView;
@end

@implementation BottomDataSource

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
    flowLayout.itemSize = NSMakeSize(tableViewWidth, scrollViewHeight);
    flowLayout.minimumLineSpacing = bottomCollectionViewMinimumLineSpacing;
    flowLayout.scrollDirection = NSCollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = NSEdgeInsetsMake(0,
                                               bottomCollectionViewEdgeInset,
                                               0,
                                               bottomCollectionViewEdgeInset);
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView reloadData];
}

-(void)registerNib{
    
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([BottomGroupCollectionViewItem class])
                                                              bundle:nil]
               forItemWithIdentifier:myCellReuseIdentifier];
}

#pragma mark - delegate

-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return tableViewCount;
}

-(NSCollectionViewItem*)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{

    BottomGroupCollectionViewItem *cell = [collectionView makeItemWithIdentifier:myCellReuseIdentifier forIndexPath:indexPath];
    
    [cell reloadDataWithTag:indexPath.item];
    return cell;
}

- (NSView *)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *)indexPath{

    return nil;
}

@end
