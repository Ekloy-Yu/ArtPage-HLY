//
//  HLGroupImageCollectionViewCell.h
//  ArtPage
//
//  Created by 何龙 on 2018/9/22.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HLGroupImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

-(void)setModel:(ArtWorksByGroupModel *)obj;
@end
