//
//  BottomDataSource.h
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/12.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BottomDataSource : NSObject<NSCollectionViewDelegate,NSCollectionViewDataSource>
-(instancetype)initWithCollectionView:(NSCollectionView*)collectionView;
@end
