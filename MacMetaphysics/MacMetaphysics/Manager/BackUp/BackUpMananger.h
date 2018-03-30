//
//  BackUpMananger.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/29.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackUpMananger : NSObject<NSOpenSavePanelDelegate>

-(void)showSavePath;

@end
