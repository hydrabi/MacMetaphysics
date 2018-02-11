//
//  JiaZiCollectionViewController.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/1/14.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "JiaZiCollectionViewController.h"
#import "UIConstantParameter.h"
#import "JiaZiCollectionViewCell.h"
#import "NSString+Addition.h"
#import "NSArray+Addition.h"
#import "NSPopover+Addition.h"

static NSString *myCellReuseIdentifier = @"myCellReuseIdentifier";

@interface JiaZiCollectionViewController ()
@end

@implementation JiaZiCollectionViewController

+(NSPopover*)presentViewControllerWithRect:(NSRect)rect view:(NSViewController*)viewController type:(MiddleSubViewType)type{
    JiaZiCollectionViewController *jiaZi = [[JiaZiCollectionViewController alloc] init];
    jiaZi.type = type;
    
    if(type == MiddleSubViewTypeYear ||
       type == MiddleSubViewTypeDay){
        jiaZi.view.frame = NSMakeRect(0,
                                      0,
                                      jiaZiCellWidth*jiaZiCollectionColumn+jiaZiCellOffset*(jiaZiCollectionColumn+1),
                                      jiaZiCellHeight*jiaZiCollectionRow+jiaZiCellOffset*(jiaZiCollectionRow+1));
    }
    else{
        jiaZi.view.frame = NSMakeRect(0,
                                      0,
                                      jiaZiCellWidth*6 + jiaZiCellOffset*(6+1),
                                      jiaZiCellHeight*2 + jiaZiCellOffset*(2+1));
    }
    
    NSPopover *popover = [NSPopover popoverWithRect:rect
                              contentViewController:jiaZi
                                           delegate:nil
                                           rectEdge:NSRectEdgeMaxY
                                         attachView:viewController.view];
    return popover;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpCollecitonView];
    [self registerNib];
    [self layoutMySubView];
}

#pragma mark - collectionView

-(void)setUpCollecitonView{
    NSCollectionViewFlowLayout *flowLayout   = [[NSCollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing            = jiaZiCellOffset;
    flowLayout.minimumInteritemSpacing       = jiaZiCellOffset;
    flowLayout.sectionInset                  = NSEdgeInsetsZero;
    flowLayout.scrollDirection               = NSCollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize                      = NSMakeSize(jiaZiCellWidth, jiaZiCellHeight);

    self.collectionView                      = [[NSCollectionView alloc] init];
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.selectable = YES;
    [self.view addSubview:self.collectionView];
}

-(void)layoutMySubView{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view);
    }];
}

-(void)registerNib{
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([JiaZiCollectionViewCell class])
                                                              bundle:nil]
               forItemWithIdentifier:myCellReuseIdentifier];
}

#pragma mark - 属性

-(void)setType:(MiddleSubViewType)type{
    _type = type;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.type == MiddleSubViewTypeYear ||
       self.type == MiddleSubViewTypeDay){
        return [MainViewModel sharedInstance].jiaZiArr.count;
    }
    else{
        return 12;
    }
}

-(NSCollectionViewItem*)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    JiaZiCollectionViewCell *cell = [collectionView makeItemWithIdentifier:myCellReuseIdentifier
                                                              forIndexPath:indexPath];
    
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    ShuangZaoData *shuangZao = mainViewModel.shuangZaoData;
    
    if(self.type == MiddleSubViewTypeYear ||
       self.type == MiddleSubViewTypeDay){
        if(mainViewModel.jiaZiArr.count>indexPath.item){
            cell.titleLabel.text = mainViewModel.jiaZiArr[indexPath.item];
        }
    }
    else if(self.type == MiddleSubViewTypeMonth){
        cell.titleLabel.text = [NSArray getMonthGanZhiArrWithStems:[shuangZao.year getStems]][indexPath.item];
    }
    else{
        NSInteger hour = indexPath.item * 2;
        cell.titleLabel.text = [NSString ganZhiHourWithHour:hour
                                                        day:shuangZao.day];
    }
    
    return cell;
}

-(void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths{
    
    if(indexPaths.count>0){
        NSIndexPath *indexPath = [indexPaths anyObject];
        
        ShuangZaoData *data = [MainViewModel sharedInstance].shuangZaoData;
        NSString *result = [MainViewModel sharedInstance].jiaZiArr[indexPath.item];
        switch (self.type) {
            case MiddleSubViewTypeYear:
                data.year = result;
                break;
            case MiddleSubViewTypeMonth:
            {
                data.month = [NSArray getMonthGanZhiArrWithStems:[data.year getStems]][indexPath.item];
            }
                break;
            case MiddleSubViewTypeDay:
                data.day = result;
                break;
            case MiddleSubViewTypeHour:
            {
                NSInteger hour = indexPath.item * 2;
                data.hour = [NSString ganZhiHourWithHour:hour
                                                     day:data.day];
            }
                
                break;
            default:
                break;
        }
        NSLog(@"%@",result);
        
    }
    [collectionView deselectItemsAtIndexPaths:indexPaths];
}
@end
