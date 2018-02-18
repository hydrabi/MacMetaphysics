//
//  LiuNianData.m
//  Metaphysics
//
//  Created by Hydra on 2017/4/15.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "LiuNianData.h"
#import "BottomLocation.h"
#import "MainViewModel.h"
@implementation LiuNianData

-(void)initialize{
    self.bottomLocationDic = @{}.mutableCopy;
}

//-(void)bindViewModel{
//    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
//    
//    @weakify(self)
//    [RACObserve(mainViewModel.liuNianData, bottomLocationDic)
//     subscribeNext:^(id _){
//        
//     }];
//}

-(void)selectTableViewTag:(NSInteger)tag indexPath:(NSIndexPath*)indexPath{
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    BottomLocation *location = [[BottomLocation alloc] initWithTag:tag indexPath:indexPath];
    
    if([self.bottomLocationDic objectForKey:location.keyNumber] == nil){
        [self.bottomLocationDic setObject:location
                                               forKey:location.keyNumber];
        
    }
    else{
        [self.bottomLocationDic removeObjectForKey:location.keyNumber];
        if(self.bottomLocationDic.count == 0){
        }
    }
    
    [self fillCurrentLocation];
}

-(void)fillCurrentLocationWithSelectLoation:(BottomLocation*)location{
    if(!self.firstLocation){
        self.firstLocation = location;
    }
    else{
        if(!self.secondLocation){
            self.secondLocation = location;
        }
        else{
            if(location.keyNumber.integerValue < self.firstLocation.keyNumber.integerValue){
                self.firstLocation = location;
            }
            
            if(location.keyNumber.integerValue > self.secondLocation.keyNumber.integerValue){
                
            }
        }
    }
}

-(void)fillCurrentLocation{
    NSArray *sortedKeyArr = [self compareCurrentLocation];
    if(sortedKeyArr.count>0){
        self.firstLocation = [self.bottomLocationDic objectForKey:sortedKeyArr.firstObject];
    }
    else{
        self.firstLocation = nil;
    }
    
    if(sortedKeyArr.count>1){
        self.secondLocation = [self.bottomLocationDic objectForKey:sortedKeyArr.lastObject];
    }
    else{
        self.secondLocation = nil;
    }
}

-(NSArray*)compareCurrentLocation{
    NSArray *sortedKeyArr = [[self.bottomLocationDic allKeys] sortedArrayUsingComparator:^(NSNumber *keyNumber1, NSNumber *keyNumber2){
        if(keyNumber1.integerValue < keyNumber2.integerValue){
            return NSOrderedAscending;
        }
        else{
            return NSOrderedDescending;
        }
    }];
    return sortedKeyArr;
}

@end
