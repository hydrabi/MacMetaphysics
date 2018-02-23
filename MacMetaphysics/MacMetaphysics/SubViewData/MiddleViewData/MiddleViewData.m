//
//  MiddleViewData.m
//  Metaphysics
//
//  Created by Hydra on 2017/3/26.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "MiddleViewData.h"

@implementation MiddleViewData
-(void)initialize{
    self.liuQinData = [[LiuQinData alloc] init];
    self.cangGanData = [[CangGanData alloc] init];
    self.naYinData = [[NaYinData alloc] init];
    self.shenShaData = [[ShenShaData alloc] init];
    self.selectGanZhiData = [[MiddleSelectGanZhiData alloc] init];
}

-(void)resetData{
    [self.cangGanData resetData];
    [self.liuQinData resetData];
    [self.naYinData resetData];
    [self.shenShaData resetData];
    [self.selectGanZhiData clearData];
}
@end
