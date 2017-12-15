//
//  BasicNibView.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/15.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BasicNibView.h"

@implementation BasicNibView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

+(instancetype)instanceBasicNibView{
    NSArray *nibViews = nil;
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil topLevelObjects:&nibViews];
    if(nibViews.count>0){
        BasicNibView *view = (BasicNibView*)nibViews[0];
        [view initialize];
        return nibViews[0];
    }
    return nil;
}

-(void)initialize{
    
}

@end
