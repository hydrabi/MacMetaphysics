//
//  UILabel+Addition.h
//  Metaphysics
//
//  Created by Hydra on 2017/2/7.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSTextField (Addition)
@property (nonatomic,assign)CGFloat originalSize;
@property (nonatomic,strong)NSString *text;

-(void)setBoldFont;
-(void)setOriginalFont;
-(void)setText:(NSString*)text;
@end
