//
//  AnalysisSolarTerm.m
//  Metaphysics
//
//  Created by Hydra on 2017/3/8.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "AnalysisSolarTerm.h"

@implementation AnalysisSolarTerm

+(NSMutableDictionary*)analysis{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SolarTerm"
                                                     ofType:@"csv"];
    NSString *fileContent = [NSString stringWithContentsOfFile:path
                                                      encoding:NSUTF8StringEncoding
                                                         error:nil];
    NSArray *solarTermsArr = [fileContent componentsSeparatedByString:@"\r\n"];
    NSMutableArray *finalSolarTermsArr = solarTermsArr.mutableCopy;
    //1900~2199年由立春到大寒的节气时间
    [finalSolarTermsArr removeObjectAtIndex:0];
    [finalSolarTermsArr removeLastObject];
    NSMutableDictionary *artifactualDic = @{}.mutableCopy;
    //表上每一行的最后两个时间是下一年的小寒和大寒时间
    NSArray *lastTwoArr = nil;
    for(NSInteger i = 0;i<finalSolarTermsArr.count;i++){
        NSString *eachYear = [finalSolarTermsArr objectAtIndex:i];
        NSMutableArray *temp = [eachYear componentsSeparatedByString:@","].mutableCopy;
        NSString *year = [temp objectAtIndex:0];
        [temp removeObjectAtIndex:0];
        //最后有个逗号，为空字符串
        [temp removeLastObject];
        
        //1900额外添加小寒，大寒时间，因为表上没有
        if(0 == i){
            [temp insertObject:@"19:32" atIndex:0];
            [temp insertObject:@"02:03" atIndex:0];
        }
        //2199年额外添加小寒，大寒时间，因为表上没有
        else if(finalSolarTermsArr.count-1 == i){
            [temp insertObject:@"09:31" atIndex:0];
            [temp insertObject:@"16:07" atIndex:0];
        }
        else{
            [temp insertObjects:lastTwoArr
                               atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
        }
        lastTwoArr = [temp subarrayWithRange:NSMakeRange(temp.count-2, 2)];
        [temp removeObjectsInRange:NSMakeRange(temp.count-2, 2)];
        
        //将小寒，大寒的时间移到最前面
        [artifactualDic setObject:temp
                           forKey:year];
    }
    return artifactualDic;
}

@end
