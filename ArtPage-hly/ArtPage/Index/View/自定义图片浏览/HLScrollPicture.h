//
//  HLScrollPicture.h
//  ArtPage
//
//  Created by 何龙 on 2018/10/20.
//  Copyright © 2018 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLScrollPicture : UIView<UIScrollViewDelegate>



-(id)initWithFrame:(CGRect)frame
          andImage:(UIImage *)image;
-(void)updateFrame:(CGRect)frame;
-(void)oldFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
