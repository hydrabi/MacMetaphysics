//
//  BottomTableViewDataSource.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/15.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BottomTableViewDataSource : NSObject<NSCollectionViewDelegate,NSCollectionViewDataSource>
-(instancetype)initWithCollectionViews:(NSMutableArray*)collectionViewArr;
@end
