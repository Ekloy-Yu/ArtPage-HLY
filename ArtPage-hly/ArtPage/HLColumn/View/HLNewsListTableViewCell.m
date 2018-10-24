//
//  HLNewsListTableViewCell.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/26.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLNewsListTableViewCell.h"
#import "GetDataBase.h"
@implementation HLNewsListTableViewCell

-(void)setNewsListModel:(NewsListModel *)obj
{
    [self.headerImageView updateConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(130, 90));
    }];
    UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/Caches/%@", NSHomeDirectory(), obj.IMAGE_URL]];
    [self.headerImageView setImage:image];
    self.titleLabel.text = obj.NAME_CN;
    if([gainUserDefault(@"lanuage") isEqualToString:@"English"])
    {
        self.titleLabel.text = obj.NAME_EN;
    }
    self.countLabel.text = [[[[GetDataBase shareDataBase] wzGainTableRecoderID:@"NewsListModel"] objectAtIndex:0] valueForKey:@"LASTUPDATEDATE"];
}
@end
