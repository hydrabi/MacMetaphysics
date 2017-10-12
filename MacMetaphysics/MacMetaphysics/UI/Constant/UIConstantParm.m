//
//  UIConstantParm.m
//  Metaphysics
//
//  Created by Hydra on 2017/1/31.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "UIConstantParm.h"
#import "UIConstantParameter.h"
@interface UIConstantParm()
@property (nonatomic,strong)NSMutableDictionary *paraDic;
@end

@implementation UIConstantParm

+(instancetype)shareInstance{
    static UIConstantParm *shared = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        shared = [[UIConstantParm alloc] init];
    });
    
    return shared;
}

-(instancetype)init{
    self = [super init];
    if(self){
        self.paraDic = @{
                         middleSubViewHeight_key    :   @(middleSubViewHeight),
                         leftSideTableViewWidth_key :   @(leftSideTableViewWidth),
                         leftVerLineOffset_key      :   @(leftVerLineOffset),
                         }.mutableCopy;
    }
    return self;
}

-(NSNumber*)getValueWithKey:(NSString*)key{
    return [self.paraDic objectForKey:key];
}

@end
