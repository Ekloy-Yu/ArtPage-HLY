//
//  HLInputView.m
//  ArtPage
//
//  Created by 何龙 on 2018/10/15.
//  Copyright © 2018 何龙. All rights reserved.
//

#import "HLInputView.h"

@implementation HLInputView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        NSArray *arr = @[@"1", @"2", @"3", @"X", @"4", @"5", @"6", @"0", @"7", @"8", @"9", @"完成"];
        for(int i = 0; i < 12; i++)
        {
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            btn.tag = i;
            
            
            /**    设置frame的复杂写法     */
//            if(i < 4)
//            {
//                btn.frame = CGRectMake(i * self.frame.size.width / 4, self.frame.size.height - 45 * 3, self.frame.size.width / 4, 45);
//            }
//            else if (i < 8)
//            {
//                btn.frame = CGRectMake((i - 4) * self.frame.size.width / 4, self.frame.size.height - 45 * 2, self.frame.size.width / 4, 45);
//            }
//            else
//            {
//                btn.frame = CGRectMake((i - 8) * self.frame.size.width / 4, self.frame.size.height - 45, self.frame.size.width / 4, 45);
//            }
            
            
            /**    设置frame的简便写法     */
            btn.frame = CGRectMake((self.frame.size.width / 4) * (i % 4), 60 * (i / 4), self.frame.size.width / 4, 60);
            
            
            [btn setTitle:arr[i] forState:(UIControlStateNormal)];
            btn.backgroundColor = [UIColor redColor];
            btn.alpha = 0.6;
            [btn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
            [btn addTarget:self action:@selector(btnSelected:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.showsTouchWhenHighlighted = YES;
            
            [self addSubview:btn];
        }
    }
    return self;
}
-(void)btnSelected:(UIButton *)btn
{
    //判断是否是删除按钮
    if(btn.tag == 3)
    {
        NSLog(@"点击了删除按钮");
        if(_deleteBlock)
        {
            _deleteBlock(self);
        }
    }
    else if(btn.tag == 11)
    {
        NSLog(@"点击了完成按钮");
        if(_doneBlock)
        {
            _doneBlock(self);
        }
    }
    else
    {
        if (self.delegate) {
            [self.delegate keyboardItemDidClicked:btn.titleLabel.text];
        }
    }

}
@end
