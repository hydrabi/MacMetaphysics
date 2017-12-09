//
//  MiddleSubView.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/9.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainViewModel.h"
@interface MiddleSubView : NSViewController

@property (nonatomic,assign)MiddleSubViewType type;

@property (nonatomic,weak)IBOutlet NSTextField *topLeftLabel;
@property (nonatomic,weak)IBOutlet NSTextField *topRightLabel;
@property (nonatomic,weak)IBOutlet NSTextField *bottomLeftLabel;
@property (nonatomic,weak)IBOutlet NSTextField *bottomRightLabel;
@property (nonatomic,weak)IBOutlet NSTextField *horLine1Label;
@property (nonatomic,weak)IBOutlet NSTextField *horLine2Label;
@property (nonatomic,weak)IBOutlet NSTextField *horLine3Label;
@property (nonatomic,weak)IBOutlet NSTextField *verLineLabel;
@property (nonatomic,weak)IBOutlet NSTextField *showFormButton;
@property (nonatomic,weak)IBOutlet NSCollectionView *collectionView;
@property (nonatomic,weak)IBOutlet NSView *innerView;

/**
 重新加载数据
 */
-(void)reloadData;

@end
