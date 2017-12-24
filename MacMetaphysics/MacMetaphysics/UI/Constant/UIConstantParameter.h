//
//  UIConstantParameter.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/5.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#ifndef UIConstantParameter_h
#define UIConstantParameter_h

typedef NS_ENUM(NSInteger,LeftSideMenuType) {
    LeftSideMenuTypeEmpty = -1,     /**<空*/
    LeftSideMenuTypeChaoDai,        /**<朝代*/
    LeftSideMenuTypeShuangZao,      /**<双造*/
    LeftSideMenuTypeDaYun,          /**<大运*/
    LeftSideMenuTypeYongShen,       /**<用神-忌神*/
    LeftSideMenuTypeGeJu,           /**<格局-象意*/
    
    LeftSideMenuTypeXiangMao,       /**<相貌-性格*/
    LeftSideMenuTypeWenPin,         /**<文凭-特长*/
    LeftSideMenuTypeFuMu,           /**<父母*/
    LeftSideMenuTypeXiongDi,        /**<兄弟*/
    LeftSideMenuTypeZiNv,           /**<子女*/
    
    LeftSideMenuTypeHunYin,         /**<婚姻*/
    LeftSideMenuTypeGuanGui,        /**<官贵*/
    LeftSideMenuTypeCaiFu,          /**<财富*/
    LeftSideMenuTypeGuanSi,         /**<官司-牢狱*/
    LeftSideMenuTypeJiBing,         /**<疾病-灾祸*/
    
    LeftSideMenuTypeYanSe,           /**<颜色区分*/
    LeftSideMenuTypeShenSha,         /**<神煞表*/
    LeftSideMenuTypeVersion,         /**<版本*/
    LeftSideMenuTypeCountQiYunUseHour,  /**使用小时算起运*/
};

typedef NS_ENUM(NSInteger,MiddleSubViewType){
    MiddleSubViewTypeYear,          /**<年柱*/
    MiddleSubViewTypeMonth,         /**<月柱*/
    MiddleSubViewTypeDay,           /**<日柱*/
    MiddleSubViewTypeHour,          /**<时柱*/
};

typedef NS_ENUM(NSInteger,CalendarType){
    CalendarTypeGregorian,          /**<公历*/
    CalendarTypeLunar,              /**<农历*/
};

typedef NS_ENUM(NSInteger,SBType){
    SBTypeStems,                    /**<天干*/
    SBTypeBranches,                 /**<地支*/
};

typedef NS_ENUM(NSInteger,UniverseType) {
    UniverseTypeQian,               /**<乾*/
    UniverseTypeKun,                /**<坤*/
};

typedef NS_ENUM(NSInteger,liuQinType) {
    liuQinType_Bi,      /**<比*/
    liuQinType_Jie,     /**<劫*/
    liuQinType_Xiao,    /**<枭*/
    liuQinType_Yin,     /**<印*/
    liuQinType_CaiFu,   /**<财*/
    liuQinType_CaiHua,  /**<才*/
    liuQinType_Sha,     /**<杀*/
    liuQinType_Guan,    /**<官*/
    liuQinType_Shi,     /**<食*/
    liuQinType_Shang,   /**<伤*/
};

//1366 1024
static const CGFloat screenWidth = 1366.0f;
static const CGFloat screenHeight = 1024.0f;
static NSString *const iconFontName = @"17icon";

static const CGFloat offset_16 = 16.0f;
static const CGFloat contentViewOffset = 10.0f;         //左边菜单section之间的间距有用到
static const CGFloat textViewTitleHeight = 40.0f;

static const CGFloat topViewHeight = 110.0f;

//左边菜单
static const CGFloat leftSideTableViewWidth = 125.0f;
static const CGFloat leftSideTableViewItemHeight = 45.0f;
static const NSString *leftSideTableViewWidth_key = @"leftSideTableViewWidth_key";
static const NSString *leftVerLineOffset_key = @"leftVerLineOffset_key";
static const CGFloat leftVerLineWidth = 2.0f;
static const CGFloat leftVerLineOffset = 10.0f;
static const CGFloat rightContentWidth = screenWidth - leftSideTableViewWidth - leftVerLineOffset-2*leftVerLineWidth;//1229

//中间年月日时柱
static const CGFloat middleViewHeight = 220.0f;
static const CGFloat middleSubViewHeight = 160.0f;
static const CGFloat middleMainButtonWidthAndheight = 90.0f;
static const CGFloat middleViewOffset = (rightContentWidth - middleMainButtonWidthAndheight - 4*210)/5;//56.0f
static const NSString *middleSubViewHeight_key = @"middleSubViewHeight_key";

//日期
static const CGFloat dateLabelHeight = 25.0f;//日期标签占用30高度

//底部整体
static const CGFloat bottomTextViewHeight = topViewHeight;
static const CGFloat bottomViewHeight = screenHeight - topViewHeight - contentViewOffset - middleViewHeight - contentViewOffset - bottomTextViewHeight - dateLabelHeight - contentViewOffset;
static const CGFloat scrollViewWidth = rightContentWidth;
static const CGFloat scrollViewHeight = bottomViewHeight;

//底部所有tableView的数据
static const CGFloat tableViewWidth = 105.0f;
static const CGFloat tableViewFirstVerOffset = 16.0f;
static const CGFloat tableViewOffset = 48.0f;
static const CGFloat tableViewMiddleOffset = 10.0f;
static const NSInteger tableViewCount = 15;
static const CGFloat tableViewHeaderHeight = 115.0f;
static const CGFloat tableViewCellHeight = (bottomViewHeight - tableViewHeaderHeight - tableViewMiddleOffset)/10;

//大运
static const CGFloat daYunTextViewHeight = bottomViewHeight - tableViewHeaderHeight + bottomTextViewHeight+leftVerLineOffset;
static const NSInteger daYunTableViewCount = 10;
static const CGFloat daYunTableCellHeight = (daYunTextViewHeight-textViewTitleHeight) / daYunTableViewCount;
static const CGFloat daYunTableViewWidth = 123.0f;

//十五运
static const CGFloat daYunSubTableViewWidth = 164.0f;
static const CGFloat daYunSubTextViewHeight = daYunTextViewHeight;
static const NSInteger daYunSubTableViewCount = 10;
static const CGFloat daYunSubTableViewMiddleOffset = 10.0f;
static const CGFloat daYunSubTitleViewHeight = 70.0f;
static const CGFloat daYunSubTableCellHeight = (daYunSubTextViewHeight-daYunSubTitleViewHeight - daYunSubTableViewMiddleOffset) / daYunSubTableViewCount;

//另外13个textView
static const CGFloat normalTextViewHeight = daYunTextViewHeight;

//双造
static const CGFloat jiaZiCellWidth = 60.0f;
static const CGFloat jiaZiCellHeight = 30.0f;
static const CGFloat jiaZiCellOffset = 10.0f;
static const NSInteger jiaZiCollectionRow = 10;
static const NSInteger jiaZiCollectionColumn = 6;

#pragma mark - 日期选择
static const CGFloat yearComponentWidth = 100.0f;
static const CGFloat monthComponentWidth = 50.0f;
static const CGFloat dayComponentWidth = 50.0f;
static const CGFloat hourComponentWidth = 50.0f;
static const CGFloat datePickerRowHeight = 40.0f;
static const CGFloat datePickerWidth = 300.0f;
static const CGFloat datePickerHeight = 300.0f;

#pragma mark - 字体
static const CGFloat titleFontSize_80 =  80.0f;
static const CGFloat titleFontSize_55 =  55.0f;
static const CGFloat titleFontSize_50 =  50.0f;
static const CGFloat titleFontSize_40 =  40.0f;
static const CGFloat titleFontSize_30 =  30.0f;
static const CGFloat titleFontSize_26 =  26.0f;
static const CGFloat titleFontSize_24 =  24.0f;
static const CGFloat titleFontSize_21 =  21.0f;
static const CGFloat titleFontSize_20 =  20.0f;
static const CGFloat titleFontSize_18 =  18.0f;
static const CGFloat titleFontSize_16 =  16.0f;
static const CGFloat titleFontSize_14 =  14.0f;

//改变颜色key
static NSString *notificationKey_changeColor = @"notificationKey_changeColor";

#endif /* UIConstantParameter_h */
