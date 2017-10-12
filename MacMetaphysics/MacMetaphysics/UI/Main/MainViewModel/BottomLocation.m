//
//  BottomLocation.m
//  Metaphysics
//
//  Created by Hydra on 2017/2/2.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BottomLocation.h"
#import "BottomViewData.h"
@implementation BottomLocation

-(instancetype)initWithTag:(NSInteger)tag indexPath:(NSIndexPath*)indexPath{
    self = [super init];
    if(self){
        self.tag = tag;
        self.section = indexPath.section;
        self.row = indexPath.item;
        self.keyNumber = [BottomLocation createKeyNumberWithTag:tag indexPath:indexPath];
        NSLog(@"%ld",(long)self.keyNumber.integerValue);
    }
    return self;
}


+(NSNumber*)createKeyNumberWithTag:(NSInteger)tag indexPath:(NSIndexPath*)indexPath{
    NSInteger key = tag * rowPerVerticalLine + indexPath.section * rowPerSection + indexPath.item;
    return @(key);
}
@end
