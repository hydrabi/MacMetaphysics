//
//  MiddleTableViewDataSource.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/9.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIConstantParameter.h"
@interface MiddleTableViewDataSource : NSObject<NSCollectionViewDelegate,NSCollectionViewDataSource>

-(instancetype)initWithCollectionView:(NSCollectionView*)collectionView subViewType:(MiddleSubViewType)subViewType;

@end
