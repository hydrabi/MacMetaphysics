//
//  LeftMenuBottomTextData.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/18.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "LeftMenuBottomTextData.h"
#import "MainViewModel.h"
#import "MainViewController.h"
@implementation LeftMenuBottomTextData

-(void)initialize{
    [super initialize];
    
    self.bottomTextRecordDic = @{}.mutableCopy;
}


-(void)clearData{
    [self.bottomTextRecordDic removeAllObjects];
}

//-(NSString*)getCurrentString{
//    LeftSideMenuType type = [MainViewModel sharedInstance].currentBottomSectionMenuType;
//    NSString *result = self.bottomTextRecordDic[@(type)];
//    if(result == nil){
//        result = @"";
//    }
//    return result;
//}

-(void)readRecord:(Record*)record{
    if(record.leftMenuTextDic){
        self.bottomTextRecordDic = record.leftMenuTextDic.mutableCopy;
    }
}

@end
