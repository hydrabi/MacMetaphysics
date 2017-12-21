//
//  BottomNSTableViewDataSource.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/21.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BottomNSTableViewDataSource : NSObject<NSTableViewDelegate,NSTableViewDataSource>

-(instancetype)initWithTableViews:(NSMutableArray*)tableViewArr;

@end
