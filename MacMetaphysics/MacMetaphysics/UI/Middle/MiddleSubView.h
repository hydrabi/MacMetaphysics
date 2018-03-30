//
//  MiddleSubView.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/9.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainViewModel.h"
#import "CustomColorLabel.h"
@interface MiddleSubView : NSViewController

@property (nonatomic,assign)MiddleSubViewType type;

@property (nonatomic,weak)IBOutlet CustomColorLabel *topLeftLabel;
@property (nonatomic,weak)IBOutlet CustomColorLabel *topRightLabel;
@property (nonatomic,weak)IBOutlet CustomColorLabel *bottomLeftLabel;
@property (nonatomic,weak)IBOutlet CustomColorLabel *bottomRightLabel;
@property (nonatomic,weak)IBOutlet CustomColorLabel *horLine1Label;
@property (nonatomic,weak)IBOutlet NSTextField *horLine2Label;
@property (nonatomic,weak)IBOutlet CustomColorLabel *horLine3Label;
@property (nonatomic,weak)IBOutlet CustomColorLabel *verLineLabel;
@property (nonatomic,weak)IBOutlet NSTextField *showFormButton;
@property (nonatomic,weak)IBOutlet NSCollectionView *collectionView;
@property (nonatomic,weak)IBOutlet NSView *innerView;
@property (nonatomic,weak)IBOutlet NSTextField *ganButton;
@property (nonatomic,weak)IBOutlet NSTextField *zhiButton;

-(instancetype)initWithType:(MiddleSubViewType)type;

/**
 重新加载数据
 */
-(void)reloadData;

/**
 清空数据
 */
-(void)clearData;

@end
