//
//  FifteenYunData.m
//  Metaphysics
//
//  Created by Hydra on 2017/4/15.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "FifteenYunData.h"
#import "UIConstantParameter.h"
@implementation DaYunTitleSelectLocation

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


@implementation FifteenYunData
-(void)initialize{
    self.fifteenYunSelectedNumber = -1;
    self.fifteenYunDic = @{}.mutableCopy;
    self.selectLocationArr = @[].mutableCopy;
    for(NSInteger i=0;i<tableViewCount;i++){
        [self.selectLocationArr addObject:[[DaYunTitleSelectLocation alloc] init]];
    }
}

-(void)clearData{
    [self.selectLocationArr removeAllObjects];
    for(NSInteger i=0;i<tableViewCount;i++){
        [self.selectLocationArr addObject:[[DaYunTitleSelectLocation alloc] init]];
    }
    self.fifteenYunSelectedNumber = -1;
}
@end
