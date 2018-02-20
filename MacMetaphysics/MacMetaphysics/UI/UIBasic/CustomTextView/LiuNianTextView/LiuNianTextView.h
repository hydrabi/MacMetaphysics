//
//  LiuNianTextView.h
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/17.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LiuNianTextView : NSViewController<NSLayoutManagerDelegate>
@property (nonatomic,strong)NSTextView *myTextView;

-(void)reloadData;

@end
