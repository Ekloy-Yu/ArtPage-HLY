//
//  HLSettingUpBodyView.h
//  ArtPage
//
//  Created by 何龙 on 2018/9/22.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLSettingUpBodyView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
-(id)initWithFrame:(CGRect)frame andContentArr:(NSArray *)arr;
@end
