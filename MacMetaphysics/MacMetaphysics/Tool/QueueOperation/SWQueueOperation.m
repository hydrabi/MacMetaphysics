//
//  SWQueueOperation.m
//  SameWay
//
//  Created by zhihuihl on 2017/7/26.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SWQueueOperation.h"

@implementation SWQueueOperation

+(void)getGloblQueueWithBlock:(void(^)(void))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if(block){
            block();
        }
    });
}

+(void)getMainQueueWithBlock:(void(^)(void))block{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(block){
            block();
        }
    });
}

+(void)getMainQueueAfterSecond:(CGFloat)second block:(void(^)(void))block{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(block){
            block();
        };
    });
}
@end
