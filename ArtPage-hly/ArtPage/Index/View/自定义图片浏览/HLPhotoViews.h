//
//  HLPhotoViews.h
//  ArtPage
//
//  Created by 何龙 on 2018/10/20.
//  Copyright © 2018 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLPhotoViews : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectView;


-(id)initWithFrame:(CGRect)frame
               pageCount:(NSInteger)totalPage
             index:(NSInteger)index
            objArr:(NSMutableArray *)objectArr;
@end

NS_ASSUME_NONNULL_END
