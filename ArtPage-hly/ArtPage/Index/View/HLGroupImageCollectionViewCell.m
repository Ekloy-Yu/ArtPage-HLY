//
//  HLGroupImageCollectionViewCell.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/22.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLGroupImageCollectionViewCell.h"

@implementation HLGroupImageCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 5, self.frame.size.height - 5)];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

-(void)setModel:(ArtWorksByGroupModel *)obj
{
    UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/Caches/%@/%@/%@.jpg", NSHomeDirectory(), gainUserDefault(@"model"), gainUserDefault(@"GroupID"), obj.ArtWorkID]];
    NSLog(@"%@", [NSString stringWithFormat:@"%@/Library/Caches/%@/%@/%@.jpg", NSHomeDirectory(), gainUserDefault(@"model"), gainUserDefault(@"GroupID"), obj.ArtWorkID]);
    [self.imageView setImage:image];
}
@end
