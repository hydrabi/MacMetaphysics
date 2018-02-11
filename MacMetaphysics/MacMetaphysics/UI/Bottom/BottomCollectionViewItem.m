//
//  BottomCollectionViewItem.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/22.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BottomCollectionViewItem.h"
#import "BottomFirstTableViewHeader.h"
#import "BottomNormalTableViewHeader.h"
#import "UIConstantParameter.h"
#import "MainViewModel.h"
#import "BottomLocation.h"
#import "NSString+Addition.h"
#import "NSView+Addition.h"
#import "BottomTableViewCell.h"
static NSString *myCellReuseIdentifier = @"myCellReuseIdentifier";
static NSString *firstTableViewHeaderIdentifier = @"firstTableViewHeaderIdentifier";
static NSString *normalTableViewHeaderIdentifier = @"normalTableViewHeaderIdentifier";

@interface BottomCollectionViewItem ()<NSCollectionViewDelegate,NSCollectionViewDataSource>
@property (nonatomic,strong)NSCollectionView *myCollectionView;

/**
 用来标识大运小运是第几行 现在collectionView搬来cell里面了
 */
@property (nonatomic,assign)NSInteger myTag;
@end

@implementation BottomCollectionViewItem

-(void)awakeFromNib{
    [super awakeFromNib];
    if(!self.collectionView){
        [self collectionViewConfig];
    }
    
}

-(void)collectionViewConfig{
    self.myCollectionView = [[NSCollectionView alloc] initWithFrame:NSMakeRect(0, 0, tableViewWidth, scrollViewHeight)];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    self.myCollectionView.backgroundViewScrollsWithContent = NO;
    self.myCollectionView.translatesAutoresizingMaskIntoConstraints = YES;
    
    NSCollectionViewFlowLayout *flowLayout = [[NSCollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = NSMakeSize(tableViewWidth, tableViewCellHeight);
    flowLayout.minimumLineSpacing = 0.0f;
    flowLayout.minimumInteritemSpacing = 0.0f;
    flowLayout.sectionInset = NSEdgeInsetsZero;
    self.myCollectionView.collectionViewLayout = flowLayout;
    
    [self.myCollectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([BottomTableViewCell class])
                                                         bundle:nil]
          forItemWithIdentifier:myCellReuseIdentifier];
    
    
    [self.myCollectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([BottomFirstTableViewHeader class])
                                                         bundle:nil]
     forSupplementaryViewOfKind:NSCollectionElementKindSectionHeader
                 withIdentifier:firstTableViewHeaderIdentifier];
    
    [self.myCollectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([BottomNormalTableViewHeader class])
                                                         bundle:nil]
     forSupplementaryViewOfKind:NSCollectionElementKindSectionHeader
                 withIdentifier:normalTableViewHeaderIdentifier];
    
    [self.view addSubview:self.myCollectionView];
    
    [self.myCollectionView makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view);
    }];
    
    [self.myCollectionView setBackgroundColors:@[[NSColor redColor]]];

}

-(void)reloadDataWithTag:(NSInteger)myTag{
    self.myTag = myTag;
    self.myCollectionView.myTag = myTag;
    [self.myCollectionView updateConstraints];
    [self.myCollectionView setNeedsDisplay:YES];
    [self.myCollectionView layoutSubtreeIfNeeded];
    [self.myCollectionView reloadData];
}

#pragma mark - delegate

-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return tableViewSection;
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return rowPerSection;
}

-(NSCollectionViewItem*)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    
    BottomTableViewCell *cell = [collectionView makeItemWithIdentifier:myCellReuseIdentifier forIndexPath:indexPath];
    [cell.view setBackgroundColor:[NSColor yellowColor]];
    
        MainViewModel *main = [MainViewModel sharedInstance];
        if(main.hadHiddenBottomTableView){
            if(collectionView.myTag >= main.hiddenBottomTableViewTag){
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
    
        NSNumber *key = [BottomLocation createKeyNumberWithTag:collectionView.myTag
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

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 0){
        if(collectionView.myTag == 0){
            return NSMakeSize(tableViewWidth, tableViewHeaderHeight);
        }
        else{
            return NSMakeSize(tableViewWidth, tableViewHeaderHeight);
        }
    }
    else{
        return NSMakeSize(tableViewWidth, tableViewMiddleOffset);
    }
}

-(NSView*)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(collectionView.myTag == 0){
            BottomFirstTableViewHeader *header = [collectionView makeSupplementaryViewOfKind:NSCollectionElementKindSectionHeader withIdentifier:firstTableViewHeaderIdentifier forIndexPath:indexPath];
//            header.frame = NSMakeRect(0, 0, CGRectGetWidth(collectionView.frame), tableViewHeaderHeight);
            return header;
        }
        else{
            BottomNormalTableViewHeader *header = [collectionView makeSupplementaryViewOfKind:NSCollectionElementKindSectionHeader withIdentifier:normalTableViewHeaderIdentifier forIndexPath:indexPath];
//            header.frame = NSMakeRect(0, 0, CGRectGetWidth(collectionView.frame), tableViewHeaderHeight);
            header.tableViewTag = collectionView.myTag;
            [header reloadData];
            return header;
        }
    }
    else{
        NSView *clearView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, CGRectGetWidth(collectionView.frame), tableViewMiddleOffset)];
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
                if(collectionView.myTag < main.hiddenBottomTableViewTag){
                    [[MainViewModel sharedInstance] selectTableViewTag:collectionView.myTag
                                                             indexPath:indexPath];
                }
            }
            //展示
            else{
                [[MainViewModel sharedInstance] selectTableViewTag:collectionView.myTag
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
    
    [bottomData fillContentWithTableIndex:tableView.myTag
                             tableSection:indexPath.section
                                 tableRow:indexPath.item
                                    block:^(NSString *liuNian,NSString *xiaoYun,NSString *year){
                                        cell.liuNianLabel.text = liuNian;
                                        cell.yearLabel.text = year;
                                    }];
}

@end
