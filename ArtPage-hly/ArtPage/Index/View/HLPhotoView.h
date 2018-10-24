//
//  HLPhotoView.h
//  CollectionView进入照片查看器
//
//  Created by 何龙 on 2018/9/26.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLPhotoView : UIView<UIScrollViewDelegate>
/** 图片url数组 */
@property (strong, nonatomic) NSArray *iconArray;
/** index 模型在数组中的下标；或者说cell的row */
@property (assign, nonatomic) NSInteger index;
/** rectArray */
@property (strong, nonatomic) NSArray<NSString *> *rectArray;
/** scrollView 用来展示图片的scrollView */
@property (weak, nonatomic) UIScrollView *scrollView;

@end
