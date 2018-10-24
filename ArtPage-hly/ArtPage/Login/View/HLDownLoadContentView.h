//
//  HLDownLoadContentView.h
//  ArtPage
//
//  Created by 何龙 on 2018/9/20.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLDownLoadContentView : UIView
@property (nonatomic, strong) UILabel *contentLabel;
-(id)initWithFrame:(CGRect)frame andStr:(NSString *)str;
@end
