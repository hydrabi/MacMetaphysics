//
//  MainViewController+CollectionView.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/5.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "MainViewController+CollectionView.h"
#import "UIConstantParameter.h"
#import "LeftCollectionViewCell.h"
#import "MainViewModel+LeftMenu.h"

static NSString *cellIdentifier = @"cellIdentifier";
static NSString *headIdentifier = @"headIdentifier";

@implementation MainViewController (CollectionView)

-(void)collectionViewConfig{
    [self collectionUIConfig];
    [self layoutCollectionView];
    [self registerCell];
    [self registerHeaderView];
}

-(void)collectionUIConfig{
    self.leftSideMenuCollectionView = [[NSCollectionView alloc] initWithFrame:NSZeroRect];
    self.leftSideMenuCollectionView.delegate = self;
    self.leftSideMenuCollectionView.dataSource = self;
    self.leftSideMenuCollectionView.selectable = YES;
    
    
    
    NSCollectionViewFlowLayout *flowLayout = [[NSCollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = NSMakeSize(leftSideTableViewWidth, leftSideTableViewItemHeight);
    flowLayout.minimumLineSpacing = 0.0f;
    flowLayout.minimumInteritemSpacing = 0.0f;
    
    //通过这种方式设置颜色
    self.leftSideMenuCollectionView.backgroundColors = @[[NSColor whiteColor]];
    
    self.leftSideMenuCollectionView.collectionViewLayout = flowLayout;
    [self.view addSubview:self.leftSideMenuCollectionView];
}

-(void)layoutCollectionView{
    [self.leftSideMenuCollectionView makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(self.view.leading).offset(0);
        make.top.equalTo(self.view.top).offset(0);
        make.bottom.equalTo(self.view.bottom).offset(0);
        make.width.equalTo(leftSideTableViewWidth);
    }];
}

-(void)registerCell{
    [self.leftSideMenuCollectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([LeftCollectionViewCell class])
                                                                          bundle:nil]
                           forItemWithIdentifier:cellIdentifier];
}

-(void)registerHeaderView{
    [self.leftSideMenuCollectionView registerClass:[NSView class]
                        forSupplementaryViewOfKind:NSCollectionElementKindSectionHeader withIdentifier:headIdentifier];
}

#pragma mark - NSCollectionViewDelegate NSCollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return self.viewModel.leftMenuArr.count;
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *temp = self.viewModel.leftMenuArr[section];
    return temp.count;
}

-(NSCollectionViewItem*)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    LeftCollectionViewCell *cell = [collectionView makeItemWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    LeftSideMenuType type = [self.viewModel getSpecificMenuTypeWithIndexPath:indexPath];
    cell.titleLabel.text = [self.viewModel getSpecificMenuTitleWithType:type];
    return cell;
}

- (NSView *)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *)indexPath{
    //第一个section没有间隔
    if(indexPath.section == 0){
        return nil;
    }
    else{
        NSView *view = [collectionView makeSupplementaryViewOfKind:NSCollectionElementKindSectionHeader withIdentifier:headIdentifier
                                                      forIndexPath:indexPath];
        view.frame = NSMakeRect(0, 0, leftSideTableViewWidth, contentViewOffset);
        return view;
    }
    
}

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return NSZeroSize;
    }
    return NSMakeSize(leftSideTableViewWidth, contentViewOffset);
}

- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths{
    if(indexPaths.count>0){
        NSIndexPath *indexPath = [indexPaths anyObject];
        [[MainViewModel sharedInstance] selectMunuWithIndexPath:indexPath];
    }
    
    [collectionView deselectItemsAtIndexPaths:indexPaths];
}

@end
