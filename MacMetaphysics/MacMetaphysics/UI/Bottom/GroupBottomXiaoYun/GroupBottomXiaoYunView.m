//
//  GroupBottomXiaoYunView.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/12.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "GroupBottomXiaoYunView.h"
#import "UIConstantParameter.h"
#import "MainViewModel.h"
#import "BottomLocation.h"
#import "NSView+Addition.h"
#import "BottomNormalTableViewHeader.h"
#import "BottomGroupCollectionViewItem.h"
#import "MainViewController.h"
#import "AppDelegate.h"
@interface GroupBottomXiaoYunView()
@property (nonatomic,assign)NSInteger myTag;
@property (nonatomic,strong)BottomNormalTableViewHeader *headerView;
@end

@implementation GroupBottomXiaoYunView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(instancetype)init{
    self = [super init];
    if(self){
        [self UIConfig];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)decoder{
    self = [super initWithCoder:decoder];
    if(self){
        [self UIConfig];
    }
    return self;
}

-(void)resetValueWithTag:(NSInteger)tag{
    self.myTag = tag;
    self.headerView.tableViewTag = tag;
    [self.headerView reloadData];
    [self resetValue];
}

-(void)mouseDown:(NSEvent *)event{
    [super mouseDown:event];
    NSPoint point = event.locationInWindow;
    NSPoint convertPoint = [self convertPoint:point fromView:nil];
    
    for(NSInteger i = 0;i<self.subViewArr.count;i++){
        SingleBottomXiaoYunView *singleView = self.subViewArr[i];
        if(NSPointInRect(convertPoint, singleView.frame)){
            [self singleViewClick:singleView];
            break;
        }
    }
}

-(void)UIConfig{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self setUpSubView];
    [self headerViewConfig];
    [self layoutMySubView];
}

-(void)headerViewConfig{
    self.headerView = [BottomNormalTableViewHeader instanceBasicNibView];
    self.headerView.parentGroupView = self;
    [self addSubview:self.headerView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.trailing.top.equalTo(self);
        make.height.equalTo(tableViewHeaderHeight);
    }];
}

-(void)setUpSubView{
    self.subViewArr = @[].mutableCopy;
    
    for(NSInteger i = 0 ; i< tableViewSection * rowPerSection ; i++){
        SingleBottomXiaoYunView *singleView = [SingleBottomXiaoYunView instanceBasicNibView];
        singleView.parentGroupView = self;
        singleView.hidden = YES;
        singleView.myTag = i;
        [self.subViewArr addObject:singleView];
        [self addSubview:singleView];
    }
}


-(void)layoutMySubView{
    
    NSView *lastView = nil;
    for(NSInteger i = 0;i<self.subViewArr.count;i++){
        SingleBottomXiaoYunView *singleView = self.subViewArr[i];
        singleView.hidden = NO;
        [singleView mas_makeConstraints:^(MASConstraintMaker *make){
            make.leading.trailing.equalTo(self);
            make.height.equalTo(tableViewCellHeight);
            if(lastView){
                if(i == 5){
                    make.top.equalTo(lastView.bottom).offset(tableViewMiddleOffset);
                }
                else{
                    make.top.equalTo(lastView.bottom);
                }
            }
            else{
                make.top.equalTo(self.headerView.bottom);
            }
        }];
        
        lastView = singleView;
    }
}

-(void)resetValue{
    
    for(NSInteger row = 0 ; row < self.subViewArr.count;row ++){
        SingleBottomXiaoYunView *singleView = self.subViewArr[row];
        
        MainViewModel *main = [MainViewModel sharedInstance];
        if(main.hadHiddenBottomTableView){
            if(self.myTag >= main.hiddenBottomTableViewTag){
                [singleView hideContent];
            }
            else{
                [singleView showContent];
            }
        }
        //展示
        else{
            [singleView showContent];
        }
        
        NSInteger section = row<=4?0:1;
        NSInteger item = row<=4?row:row-5;
        
        NSNumber *key = [BottomLocation createKeyNumberWithTag:self.myTag
                                                     indexPath:[NSIndexPath indexPathForItem:item inSection:section]];
        if([main.liuNianData.bottomLocationDic objectForKey:key]){
            [singleView selectCell:YES];
        }
        else{
            [singleView selectCell:NO];
        }
        
        [self fillContentWithCell:singleView
                        indexPath:[NSIndexPath indexPathForItem:item inSection:section]];
    }
}

-(void)fillContentWithCell:(SingleBottomXiaoYunView*)cell
                 indexPath:(NSIndexPath *)indexPath{
    
    MainViewModel *mainViewModle = [MainViewModel sharedInstance];
    BottomViewData *bottomData = mainViewModle.bottomData;
    
    [bottomData fillContentWithTableIndex:self.myTag
                             tableSection:indexPath.section
                                 tableRow:indexPath.item
                                    block:^(NSString *liuNian,NSString *xiaoYun,NSString *year){
                                        cell.liuNianLabel.text = liuNian;
                                        cell.yearLabel.text = year;
                                    }];
}

//获取实际的item
-(NSInteger)getRow{
    MainViewModel *viewModel = [MainViewModel sharedInstance];
    MainViewController *viewController = (MainViewController*)viewModel.viewController;
    NSInteger row = [viewController.bottomContentView.bottomCollectionView indexPathForItem:self.parentViewItem].item;
    return row;
}

-(void)singleViewClick:(SingleBottomXiaoYunView*)signleView{
    if(signleView.liuNianLabel.text.length>0){
        MainViewModel *main = [MainViewModel sharedInstance];
        
        NSInteger section = signleView.myTag <=4?0:1;
        NSInteger item = signleView.myTag<=4?signleView.myTag:signleView.myTag-5;
        
        //隐藏的时候不能点击
        if(main.hadHiddenBottomTableView){
            if(self.myTag < main.hiddenBottomTableViewTag){
                [[MainViewModel sharedInstance] selectTableViewTag:self.myTag
                                                         indexPath:[NSIndexPath indexPathForItem:item inSection:section]];
            }
        }
        //展示
        else{
            [[MainViewModel sharedInstance] selectTableViewTag:self.myTag
                                                     indexPath:[NSIndexPath indexPathForItem:item inSection:section]];
        }
        
        [self resetValue];
    }
}

@end
