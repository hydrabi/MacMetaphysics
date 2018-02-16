//
//  BottomGroupCollectionViewItem.h
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/12.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GroupBottomXiaoYunView.h"

@interface BottomGroupCollectionViewItem : NSCollectionViewItem

@property (weak) IBOutlet GroupBottomXiaoYunView *groupView;
-(void)reloadDataWithTag:(NSInteger)myTag;

@end
