//
//  BottomContentView.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/14.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@interface BottomContentView : NSViewController<NSTableViewDelegate,NSTableViewDataSource>
@property (weak) IBOutlet NSCollectionView *bottomCollectionView;
@property (weak) IBOutlet NSScrollView *scrollView;

@end
