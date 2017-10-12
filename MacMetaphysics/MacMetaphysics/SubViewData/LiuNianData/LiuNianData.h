//
//  LiuNianData.h
//  Metaphysics
//
//  Created by Hydra on 2017/4/15.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "SubViewData.h"
@class BottomLocation;
@interface LiuNianData : SubViewData
//选择的位置
@property (nonatomic,strong)NSMutableDictionary *bottomLocationDic;
//第一个location
@property (nonatomic,strong)BottomLocation *firstLocation;
//第二个location
@property (nonatomic,strong)BottomLocation *secondLocation;

//点击底部tableView的某行
-(void)selectTableViewTag:(NSInteger)tag indexPath:(NSIndexPath*)indexPath;
@end
