//
//  SolarTermsCollectionView.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/12/30.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "SolarTermsCollectionView.h"
#import "SolarTermsFirstCell.h"
#import "SolarTermsSecondCell.h"
#import "SolarTermsThirdCell.h"
#import "SolarTermsNumberCell.h"
#import "SolarTermsMulLineCell.h"
#import "SolarTermsMonthCell.h"
#import "RiZhuData.h"
#import "MainViewModel.h"

static NSString *firstCellIdentifier = @"firstCellIdentifier";
static NSString *secondCellIdentifier = @"secondCellIdentifier";
static NSString *thirdCellIdentifier = @"thirdCellIdentifier";
static NSString *numberCellIdentifier = @"numberCellIdentifier";
static NSString *numberCellIdentifier1 = @"numberCellIdentifier1";
static NSString *mulLineCellIdentifier = @"mulLineCellIdentifier";
static NSString *mulLineCellIdentifier1 = @"mulLineCellIdentifier1";
static NSString *emptyellIdentifier = @"emptyellIdentifier";
static NSString *monthCellIdentifier = @"monthCellIdentifier";

@implementation SolarTermsCollectionViewDataSource

-(instancetype)initWithCollectionView:(SolarTermsCollectionView*)collectionView{
    self = [super init];
    if(self){
        self.collectionView = collectionView;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.selectable = YES;
        [self.collectionView setBackgroundColors:@[[NSColor whiteColor]]];
        self.collectionView.wantsLayer = YES;
        self.collectionView.layer.borderColor = [NSColor blackColor].CGColor;
        self.collectionView.layer.borderWidth = 1.0f;
        
        NSCollectionViewFlowLayout *flowLayout = [[NSCollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0.0f;
        flowLayout.minimumInteritemSpacing = 0.0f;
        flowLayout.itemSize = NSMakeSize(10 , 10);
        self.collectionView.collectionViewLayout = flowLayout;
        
        [self initialize];
        [self bindViewModel];
        [self.collectionView reloadData];
    }
    return self;
}

-(void)initialize{
    
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([SolarTermsFirstCell class]) bundle:nil]
          forItemWithIdentifier:firstCellIdentifier];
    
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([SolarTermsSecondCell class]) bundle:nil]
               forItemWithIdentifier:secondCellIdentifier];

    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([SolarTermsThirdCell class]) bundle:nil]
               forItemWithIdentifier:thirdCellIdentifier];
    
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([SolarTermsNumberCell class]) bundle:nil]
               forItemWithIdentifier:numberCellIdentifier];
    
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([SolarTermsMulLineCell class]) bundle:nil]
               forItemWithIdentifier:mulLineCellIdentifier];
    
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([SolarTermsMonthCell class]) bundle:nil]
               forItemWithIdentifier:monthCellIdentifier];
    
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([SolarTermsNumberCell class]) bundle:nil]
               forItemWithIdentifier:numberCellIdentifier1];
    
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([SolarTermsMulLineCell class]) bundle:nil]
               forItemWithIdentifier:mulLineCellIdentifier1];
    
    [self.collectionView registerClass:[NSCollectionViewItem class]
                 forItemWithIdentifier:emptyellIdentifier];
    
}

-(void)bindViewModel{
    @weakify(self)
    RiZhuData *riZhuData = [[MainViewModel sharedInstance] riZhuData];
    [[[riZhuData rac_signalForSelector:@selector(dealWithRiZhuData)]
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
         [self.collectionView reloadData];
     }];
}

-(CGFloat)getHeightWithSection:(NSInteger)section{
    CGFloat height = 0.0f;
    switch (section) {
        case 0:
            height = 53.0f;
            break;
        case 1:
            height = 40.0f;
            break;
        case 2:
            height = 40.0f;
            break;
        case 3:
            height = 40.0f;
            break;
        case 4:
            height = 80.0f;
            break;
        case 5:
            height = 51.0f;
            break;
        case 6:
            height = 51.0f;
            break;
        case 7:
            height = 101.0f;
            break;
            
        default:
            break;
    }
    return height;
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return 8;
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    RiZhuData *riZhuData = [[MainViewModel sharedInstance] riZhuData];
    if(section == 0){
        return 1;
    }
    else if (section == 1){
        return 2;
    }
    else if (section == 2){
        NSInteger day = 0;
        for(NSNumber *eachDay in riZhuData.separatorDayArr){
            day += eachDay.integerValue;
        }
        NSInteger item = 0;
        //一共有31个格子，如果分隔天数加起来小于31天，则有最后一个空格代表空余天数
        if(day<riZhuData.solarDate.count){
            item = riZhuData.separatorDayArr.count+1;
        }
        //否则直接等于队列项数
        else{
            item = riZhuData.separatorDayArr.count;
        }
        return item;
    }
    else if (section == 3){
        return riZhuData.solarDate.count;
    }
    else if (section == 4){
        return riZhuData.solarDate.count;
    }
    else if (section == 5){
        return 1;
    }
    else if (section == 6){
        return riZhuData.solarDate.count;
    }
    else if (section == 7){
        return riZhuData.solarDate.count;
    }
    
    return 1;
}


-(NSCollectionViewItem*)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    RiZhuData *riZhuData = [[MainViewModel sharedInstance] riZhuData];
    
    if(indexPath.section == 0){
        SolarTermsFirstCell *cell = [collectionView makeItemWithIdentifier:firstCellIdentifier
                                                                              forIndexPath:indexPath];
        cell.titleLabel.text = riZhuData.monthName;
        return cell;
    }
    else if(indexPath.section == 1){
        SolarTermsSecondCell *cell = [collectionView makeItemWithIdentifier:secondCellIdentifier
                                                                               forIndexPath:indexPath];
        //有值才赋值，否则为空
        cell.titleLabel.text = @"";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
        //左边
        if(indexPath.item == 0){
            cell.titleLabel.alignment = NSTextAlignmentLeft;
            NSString *leftDate = [dateFormatter stringFromDate:riZhuData.leftTerm];
            if(leftDate.length>0){
                cell.titleLabel.text = [NSString stringWithFormat:@"%@:%@",riZhuData.leftTermName,leftDate];
            }
            
        }
        //右边
        else{
            cell.titleLabel.alignment = NSTextAlignmentRight;
            NSString *rightDate = [dateFormatter stringFromDate:riZhuData.rightTerm];
            if(rightDate.length>0){
                cell.titleLabel.text = [NSString stringWithFormat:@"%@:%@",riZhuData.rightTermName,rightDate];
            }
            
        }
        return cell;
    }
    else if(indexPath.section == 2){
        SolarTermsThirdCell *cell = [collectionView makeItemWithIdentifier:thirdCellIdentifier
                                                                              forIndexPath:indexPath];
        NSArray *nameArr = riZhuData.separatorDayNameArr;
        if(nameArr.count>indexPath.item){
            cell.titleLabel.text = nameArr[indexPath.item];
        }
        else{
            cell.titleLabel.text = @"";
        }
        return cell;
    }
    else if(indexPath.section == 3){
        SolarTermsNumberCell *cell = [collectionView makeItemWithIdentifier:numberCellIdentifier
                                                                               forIndexPath:indexPath];
        cell.titleLabel.text = [NSString stringWithFormat:@"%ld",indexPath.item+1] ;
        
        return cell;
    }
    else if(indexPath.section == 4){
        SolarTermsMulLineCell *cell = [collectionView makeItemWithIdentifier:mulLineCellIdentifier
                                                                                forIndexPath:indexPath];
        NSMutableArray *ganZhiArr = [MainViewModel sharedInstance].jiaZiArr;
        NSInteger index = [MainViewModel sharedInstance].riZhuData.indexOfTermsBranchName;
        index += indexPath.item;
        if(index>=ganZhiArr.count){
            index -= ganZhiArr.count;
        }
        cell.titleLabel.text = [ganZhiArr objectAtIndex:index];
        
        if(riZhuData.indexOfCurrentDay == indexPath.item){
            [cell isCurrentSelectedDay:YES];
        }
        else{
            [cell isCurrentSelectedDay:NO];
        }
        return cell;
    }
    else if(indexPath.section == 5){
        SolarTermsMonthCell *cell = [collectionView makeItemWithIdentifier:monthCellIdentifier
                                                                              forIndexPath:indexPath];
        CGFloat cloumn = CGRectGetWidth(collectionView.frame)/31;
        cell.leadingConstraint.constant = cloumn*riZhuData.monthLeadingConstraint;
        cell.titleLabel.text = [NSString stringWithFormat:@"%ld月",riZhuData.monthNumber];
        return cell;
    }
    else if(indexPath.section == 6){
        SolarTermsNumberCell *cell = [collectionView makeItemWithIdentifier:numberCellIdentifier1
                                                                               forIndexPath:indexPath];
        if(riZhuData.solarDate.count>indexPath.item){
            cell.titleLabel.text = [[riZhuData.solarDate objectAtIndex:indexPath.item] stringValue];
        }
        else{
            cell.titleLabel.text = @"";
        }
        
        if(riZhuData.indexOfCurrentDay == indexPath.item){
            [cell isCurrentSelectedDay:YES];
        }
        else{
            [cell isCurrentSelectedDay:NO];
        }
        
        return cell;
    }
    else if(indexPath.section == 7){
        SolarTermsMulLineCell *cell = [collectionView makeItemWithIdentifier:mulLineCellIdentifier1
                                                                                forIndexPath:indexPath];
        if(riZhuData.lunarDate.count>indexPath.item){
            cell.titleLabel.text = [riZhuData.lunarDate objectAtIndex:indexPath.item];
        }
        else{
            cell.titleLabel.text = @"";
        }
        
        if(riZhuData.indexOfCurrentDay == indexPath.item){
            [cell isCurrentSelectedDay:YES];
        }
        else{
            [cell isCurrentSelectedDay:NO];
        }
        
        return cell;
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegate
- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //每行的高度
    CGFloat height = [self getHeightWithSection:indexPath.section];
    RiZhuData *riZhuData = [[MainViewModel sharedInstance] riZhuData];
    //每个格子的宽度
    CGFloat cloumn = CGRectGetWidth(collectionView.frame)/riZhuData.solarDate.count;
    cloumn = floorf(cloumn);
    //第三行分隔日数
    NSArray *separatorDayArr = riZhuData.separatorDayArr;
    
    if(indexPath.section == 0){
        return CGSizeMake(CGRectGetWidth(collectionView.frame), height);
    }
    else if(indexPath.section == 1){
        return CGSizeMake((CGRectGetWidth(collectionView.frame)-1)/2, height);
    }
    else if(indexPath.section == 2){
        NSInteger totalDay = 0;
        for(NSNumber *eachDay in riZhuData.separatorDayArr){
            totalDay += eachDay.integerValue;
        }
        
        if(separatorDayArr.count>indexPath.item){
            NSInteger day = [separatorDayArr[indexPath.item] integerValue];
            //加上间隔线1*格数的宽度
            CGFloat width = cloumn*day;
            return CGSizeMake(width, height);
        }
        //不足31天的剩余天数
        else{
            NSInteger leftDay = riZhuData.solarDate.count - totalDay;
            return CGSizeMake(cloumn*leftDay, height);
        }
    }
    else if(indexPath.section == 3){
        return CGSizeMake(cloumn, height);
    }
    else if(indexPath.section == 4){
        return CGSizeMake(cloumn, height);
    }
    else if(indexPath.section == 5){
        return CGSizeMake(CGRectGetWidth(collectionView.frame),height);
    }
    else if(indexPath.section == 6){
        return CGSizeMake(cloumn, height);
    }
    else if(indexPath.section == 7){
        return CGSizeMake(cloumn, height);
    }
    return CGSizeZero;
}



@end

@implementation SolarTermsCollectionView

+(SolarTermsCollectionView*)createSolarTermsCollectionView{
    SolarTermsCollectionView *view = [[SolarTermsCollectionView alloc] initWithFrame:CGRectZero];
    view.myDataSource = [[SolarTermsCollectionViewDataSource alloc] initWithCollectionView:view];
    return view;
}

@end
