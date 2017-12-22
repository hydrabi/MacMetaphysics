//
//  BottomCollectionViewDataSource.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/22.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BottomCollectionViewDataSource : NSObject<NSCollectionViewDelegate,NSCollectionViewDataSource>

-(instancetype)initWithCollectionView:(NSCollectionView*)collectionView;

@end
