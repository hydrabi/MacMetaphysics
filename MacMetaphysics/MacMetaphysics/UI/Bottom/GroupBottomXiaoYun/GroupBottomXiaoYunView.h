//
//  GroupBottomXiaoYunView.h
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/12.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SingleBottomXiaoYunView.h"
@class BottomGroupCollectionViewItem;
@interface GroupBottomXiaoYunView : NSView

@property (nonatomic,strong)NSMutableArray *subViewArr;
@property (nonatomic,weak)BottomGroupCollectionViewItem *parentViewItem;
-(void)resetValueWithTag:(NSInteger)tag;
//获取实际的item
-(NSInteger)getRow;
@end
