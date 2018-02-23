//
//  MiddleSelectGanZhiData.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/2/23.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "MiddleSelectGanZhiData.h"

@implementation MiddleSelectGanZhiLocation

-(instancetype)init{
    self = [super init];
    if(self){
        [self clearData];
    }
    return self;
}

-(void)clearData{
    self.selectedGan = NO;
    self.selectedBranch = NO;
}

@end

@implementation MiddleSelectGanZhiData

-(void)initialize{

    self.selectLocationArr = @[].mutableCopy;
    for(NSInteger i=0;i<=MiddleSubViewTypeHour;i++){
        [self.selectLocationArr addObject:[[MiddleSelectGanZhiLocation alloc] init]];
    }
}

-(void)clearData{
    [self.selectLocationArr removeAllObjects];
    for(NSInteger i=0;i<=MiddleSubViewTypeHour;i++){
        [self.selectLocationArr addObject:[[MiddleSelectGanZhiLocation alloc] init]];
    }
}

#pragma mark - 选中（反选）操作
-(void)selectWithType:(MiddleSubViewType)type isGan:(BOOL)isGan{
    if(self.selectLocationArr.count>type){
        MiddleSelectGanZhiLocation *location = self.selectLocationArr[type];
        if(isGan){
            location.selectedGan = !location.selectedGan;
        }
        else{
            location.selectedBranch = !location.selectedBranch;
        }
    }
}

-(MiddleSelectGanZhiLocation*)getLocationWithType:(MiddleSubViewType)type{
    if(self.selectLocationArr.count>type){
        MiddleSelectGanZhiLocation *location = self.selectLocationArr[type];
        return location;
    }
    return nil;
}

@end
