//
//  HLScrollPicture.m
//  ArtPage
//
//  Created by 何龙 on 2018/10/20.
//  Copyright © 2018 何龙. All rights reserved.
//

#import "HLScrollPicture.h"

@implementation HLScrollPicture{
    UIImageView *_enlargeImageView;
    CGFloat _scale;//记录上次手势结束的放大倍数
    CGFloat _realScale;//当前手势应该放大的倍数
    UIScrollView *_scrollView;
    
    UIImage *_image;  //为传入的照片
}
-(id)initWithFrame:(CGRect)frame
          andImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = image;
        [self initScrollView];
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchEvent:)];
        [self addGestureRecognizer:pinchGesture];
    }
    return self;
}
#pragma mark - 初始化scrollView
-(void)initScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.minimumZoomScale = 0.5;
    _scrollView.maximumZoomScale = 10;
    
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    [self initImageView];
}

#pragma mark - 初始化ImageView
-(void)initImageView{
    _enlargeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _enlargeImageView.image = _image;
    _enlargeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_enlargeImageView];
}

#pragma mark - 捏合手势方法
-(void)pinchEvent:(UIPinchGestureRecognizer *)pinch{
    //当前的放大倍数是上次的放大倍数加上当前手势pinch程度
    _realScale = _scale + (pinch.scale - 1);
    
    if (_realScale > 5) {
        _realScale = 5;
    } else if (_realScale < 1){
        _realScale = 1;
    }
    
    _enlargeImageView.transform = CGAffineTransformMakeScale(_realScale, _realScale);
    
    if (pinch.state == UIGestureRecognizerStateEnded) {//当结束捏合手势时记录当前d图片放大倍数
        _scale = _realScale;
    }
    NSLog(@"_scale = %f,  _realScale = %f", _scale, _realScale);
}

#pragma mark - scrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _enlargeImageView;
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGRect frame = _enlargeImageView.frame;
    
    frame.origin.y = (_scrollView.frame.size.height - _enlargeImageView.frame.size.height) > 0 ?
    (_scrollView.frame.size.height - _enlargeImageView.frame.size.height) * 0.5 : 0;
    frame.origin.x = (_scrollView.frame.size.width - _enlargeImageView.frame.size.width) > 0 ? (_scrollView.frame.size.width - _enlargeImageView.frame.size.width) * 0.5 : 0;
    _enlargeImageView.frame = frame;
    
    _scrollView.contentSize = CGSizeMake(_enlargeImageView.frame.size.width + 30, _enlargeImageView.frame.size.height + 30);
}

#pragma mark - updateFrame
-(void)updateFrame:(CGRect)frame
{
    _enlargeImageView.frame = frame;
    _scrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
}
-(void)oldFrame:(CGRect)frame
{
    _enlargeImageView.frame = frame;
    _scrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
}
@end
