//
//  UIButton+UIButton_Category.m
//  ArtPage
//
//  Created by 何龙 on 2018/10/13.
//  Copyright © 2018 何龙. All rights reserved.
//

#import "UIButton+UIButton_Category.h"

@implementation UIButton (UIButton_Category)

-(void)setBackgroundColor:(UIColor *)backgroundColor image:(NSString *)imageName text:(NSString *)text
{
//    NSLog(@"%@", self.bounds);
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 30)];
    backLabel.backgroundColor = [UIColor whiteColor];
    backLabel.layer.cornerRadius = 15;
    backLabel.layer.masksToBounds = YES;
    [self addSubview:backLabel];
    [self layoutIfNeeded];

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageName];
    [self addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backLabel.centerX);
        make.centerY.equalTo(backLabel.centerY);
        make.size.equalTo(CGSizeMake(self.bounds.size.width / 2, (self.bounds.size.height - 30) / 2));
    }];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)];
    titleLabel.text = text;
//    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
}
@end
