//
//  BottomContentView.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/14.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BottomTableViewDataSource.h"
@interface BottomContentView : NSViewController
@property (nonatomic,strong)BottomTableViewDataSource *dataSorce;
@end
