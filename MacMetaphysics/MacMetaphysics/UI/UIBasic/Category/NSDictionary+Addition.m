//
//  NSDictionary+Addition.m
//  Metaphysics
//
//  Created by Hydra on 2017/4/9.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "NSDictionary+Addition.h"
#import "NSString+Addition.h"
#import "NSArray+Addition.h"
@implementation NSDictionary (Addition)
+(NSDictionary*)liuQinDic{
    //@"甲乙丙丁戊己庚辛壬癸"
    NSString *stemsStr = [NSString stemsStr];
    NSMutableDictionary *mainDic = @{}.mutableCopy;
    for(NSInteger i = 0;i<stemsStr.length;i++){
        //日干
        NSString *riGankey = [stemsStr substringWithRange:NSMakeRange(i, 1)];
        NSMutableDictionary *subDic = @{}.mutableCopy;
        NSArray *subValues = [NSArray getLiuQinArrWithIndex:i];
        for(NSInteger j = 0;j<stemsStr.length;j++){
            NSString *subKey = [stemsStr substringWithRange:NSMakeRange(j, 1)];
            NSString *subValue = subValues[j];
            [subDic setObject:subValue
                       forKey:subKey];
        }
        [mainDic setObject:subDic
                    forKey:riGankey];
    }
    return mainDic;
}


@end
