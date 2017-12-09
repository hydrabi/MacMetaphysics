//
//  MiddleTableViewDataSource.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/9.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "MiddleTableViewDataSource.h"
#import "MiddleTableViewCell.h"
#import "MainViewModel.h"

static NSString *cellIdentifier = @"cellIdentifier";
static CGFloat collectionWidth = 53.0f;
static CGFloat collectionHeight = 26.0f;

@interface MiddleTableViewDataSource()
@property (nonatomic,weak)NSCollectionView *collectionView;
@property (nonatomic,assign)MiddleSubViewType subViewType;
@end

@implementation MiddleTableViewDataSource

-(instancetype)initWithCollectionView:(NSCollectionView*)collectionView subViewType:(MiddleSubViewType)subViewType{
    self = [super init];
    if(self){
        self.collectionView = collectionView;
        self.subViewType = subViewType;
        [self collectionUIConfig];
        [self registerNib];
    }
    return self;
}

-(void)collectionUIConfig{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    NSCollectionViewFlowLayout *flowLayout = [[NSCollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = NSMakeSize(collectionWidth, collectionHeight);
    flowLayout.minimumLineSpacing = 0.0f;
    flowLayout.minimumInteritemSpacing = 0.0f;
    self.collectionView.collectionViewLayout = flowLayout;
}

-(void)registerNib{
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([MiddleTableViewCell class])
                                                              bundle:nil]
         forItemWithIdentifier:cellIdentifier];
}

-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    MiddleViewData *middle = [MainViewModel sharedInstance].middleData;
    return [middle.shenShaData.totalShenShaArr[self.subViewType] count];
}

-(NSCollectionViewItem*)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    MiddleTableViewCell *cell = [collectionView makeItemWithIdentifier:cellIdentifier forIndexPath:indexPath];
    MiddleViewData *middle = [MainViewModel sharedInstance].middleData;
    NSMutableArray *shenShaArr = middle.shenShaData.totalShenShaArr[self.subViewType];
    if(shenShaArr.count>indexPath.item){
        cell.shenShaLabel.stringValue = shenShaArr[indexPath.item];
    }
    return cell;
}

@end
