//
//  ShuangZaoData.h
//  Metaphysics
//
//  Created by Hydra on 2017/2/13.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "SubViewData.h"
#import "UIConstantParameter.h"
@interface ShuangZaoData : SubViewData
/**
 乾坤
 */
@property (nonatomic,assign)UniverseType universeType;
@property (nonatomic,strong)NSString *mainTitle;
@property (nonatomic,strong)NSString *year;
@property (nonatomic,strong)NSString *month;
@property (nonatomic,strong)NSString *day;
@property (nonatomic,strong)NSString *hour;
@property (nonatomic,strong)NSString *text1;
@property (nonatomic,strong)NSString *text2;
@end
