//
//  ScreenShotManager.h
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/19.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 截图管理
 */
@interface ScreenShotManager : NSObject<NSOpenSavePanelDelegate>

-(void)start;

@end
