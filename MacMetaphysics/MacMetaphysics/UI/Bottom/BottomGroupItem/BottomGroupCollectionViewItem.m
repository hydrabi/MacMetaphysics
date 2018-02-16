//
//  BottomGroupCollectionViewItem.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/12.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "BottomGroupCollectionViewItem.h"
#import "NSView+Addition.h"
@interface BottomGroupCollectionViewItem ()
/**
 用来标识大运小运是第几行 现在collectionView搬来cell里面了
 */
@property (nonatomic,assign)NSInteger myTag;
@end

@implementation BottomGroupCollectionViewItem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.groupView.parentViewItem = self;
}

-(void)reloadDataWithTag:(NSInteger)myTag{
    self.myTag = myTag;
    [self.groupView resetValueWithTag:myTag];
}

@end
