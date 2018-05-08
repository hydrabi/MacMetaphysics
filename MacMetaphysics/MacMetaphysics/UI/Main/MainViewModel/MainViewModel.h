//
//  MainViewModel.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/5.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BasicViewModel.h"
#import "UIConstantParameter.h"
#import "ShuangZaoData.h"
#import "CurrentSelectDate.h"
#import "UIConstantParameter.h"
#import "RiZhuData.h"
#import "MiddleViewData.h"
#import "BottomViewData.h"
#import "FifteenYunData.h"
#import "LiuNianData.h"
#import "LeftMenuBottomTextData.h"
#import "RecordEventHandler.h"


@interface MainViewModel : BasicViewModel
//左边的菜单页面
@property (nonatomic,strong)NSArray *leftMenuArr;
//当前选中顶部的菜单类型
@property (nonatomic,strong)NSMutableArray *currentSelectTopSectionMenuTypeArr;
//当前选中底部的菜单类型
@property (nonatomic,assign)LeftSideMenuType currentBottomSectionMenuType;
//是否使用小时来计算起运
@property (nonatomic,assign)BOOL useHourCountQiYun;
//底部textView操作信号
//@property (nonatomic,strong)RACSignal *currentBottomTextViewOperationSig;
//左边菜单选中上面部分的操作信号
@property (nonatomic,strong)RACSignal *leftMenuTopSelectedOperationSig;
//节气显示与否
@property (nonatomic,assign)BOOL hadShowSolarTermsCollectionView;
//左边菜单tableview操作信号
@property (nonatomic,strong)RACSignal *reloadLeftTableSig;

//天干
@property (nonatomic,strong)NSArray *stemsArr;
@property (nonatomic,strong)NSString *stemsStr;
//地支
@property (nonatomic,strong)NSArray *branchesArr;
@property (nonatomic,strong)NSString *branchesStr;
//60甲子
@property (nonatomic,strong)NSMutableArray *jiaZiArr;



//是否正在隐藏底部的tableView
@property (nonatomic,assign)BOOL hadHiddenBottomTableView;
//正在隐藏的tableview的标记
@property (nonatomic,assign)NSInteger hiddenBottomTableViewTag;
//隐藏或者显示的操作信号
@property (nonatomic,strong)RACSignal *reloadBottomTablesSig;

//隐藏或者显示最底部textView的操作信号 左边菜单点击时出现在底部
@property (nonatomic,strong)RACSignal *leftMenuClickTextViewOperationSig;

//隐藏或者显示15运的操作信号
@property (nonatomic,strong)RACSignal *fifteenYunTextViewOperationSig;

//在双造中出现的底部空白textView
@property (nonatomic,strong)RACSubject *bottomNoteTextViewOperationSig;

//中间视图的数据
@property (nonatomic,strong)MiddleViewData *middleData;
//双造数据
@property (nonatomic,strong)ShuangZaoData *shuangZaoData;
//日期数据
@property (nonatomic,strong)CurrentSelectDate *selectedDate;
//日柱数据
@property (nonatomic,strong)RiZhuData *riZhuData;
//底部数据
@property (nonatomic,strong)BottomViewData *bottomData;
//十五运数据
@property (nonatomic,strong)FifteenYunData *fifteenYunData;
//流年数据
@property (nonatomic,strong)LiuNianData *liuNianData;
//左边菜单点击对应选项后出现在底部的textView 记录每个不同选项对应的数据
@property (nonatomic,strong)LeftMenuBottomTextData *leftMenuBottomTextData;
//1900~2100年节气精确到分的时间集合
@property (nonatomic,strong)NSMutableDictionary *solarTermsTimeDic;

@property (nonatomic, strong) RecordEventHandler * recordEventHandler;
//从搜索中点击进来的记录 保存时询问是否删除
@property (nonatomic, strong) Record *clickFromRecord;

+(instancetype)sharedInstance;
-(NSString*)getSpecificMenuTitleWithType:(LeftSideMenuType)type;
-(LeftSideMenuType)getSpecificMenuTypeWithIndexPath:(NSIndexPath*)indexPath;
-(void)hiddenTableViewWithTag:(NSInteger)tag;
-(void)selectTableViewTag:(NSInteger)tag indexPath:(NSIndexPath*)indexPath;
-(void)selectTableViewHeaderWithTag:(NSInteger)tag;
-(NSString*)getGanZhiWithYear:(int32_t)year
                        month:(int32_t)month
                          day:(int32_t)day
               middleViewType:(MiddleSubViewType)type;


/**
 公历转农历
 */
-(void)solarToLunar;

/**
 农历转公历
 */
-(void)lunarToSolar;

/**
 获取该年的闰月月份数
 
 @param year 年份
 @return 若该年存在闰月，返回闰月月份，否则返回0
 */
-(int32_t)getLeapMonthWithYear:(int32_t)year;

/**
 获取该年闰月的日数
 
 @param year 年份
 @return 若该年存在闰月，返回闰月日数，否则返回0
 */
-(int32_t)getLeapDayWithYear:(int32_t)year;

/**
 获取农历月份日数
 
 @param year 年
 @param month 农历月份
 @return 农历月份日数
 */
-(int32_t)getLunarDayWithYear:(int32_t)year month:(int32_t)month;

/**
 获取该年所有节气日期
 
 @param year 选定的年
 @return 所有节气日期
 */
-(NSMutableArray*)getTremWithYear:(int32_t)year;

-(NSWindow*)getMainWindow;

@end
