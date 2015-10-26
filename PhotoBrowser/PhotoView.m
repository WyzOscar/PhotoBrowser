//
//  PhotoView.m
//
//
//  Created by wyz on 15/10/18.
//  Copyright (c) 2015年 wyz. All rights reserved.
//

#import "PhotoView.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

@interface PhotoView ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    MBProgressHUD *hud;
}

@end

@implementation PhotoView

-(id)initWithFrame:(CGRect)frame withPhotoUrl:(NSString *)photoUrl{
    self = [super initWithFrame:frame];
    if (self) {
        //添加scrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.minimumZoomScale = 1;
        _scrollView.maximumZoomScale = 3;
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        //添加图片
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        BOOL isCached = [manager cachedImageExistsForURL:[NSURL URLWithString:photoUrl]];
        if (!isCached) {//没有缓存
            hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.mode = MBProgressHUDModeDeterminate;
        }
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:photoUrl] placeholderImage:[UIImage imageNamed:@"comment_empty_img"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
            hud.progress = ((float)receivedSize)/expectedSize;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
            NSLog(@"图片加载完成");
            if (!isCached) {
                [hud hide:YES];
            }
        }];
        
        [self.imageView setUserInteractionEnabled:YES];
        [_scrollView addSubview:self.imageView];
        
        //添加手势
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
        
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        doubleTap.numberOfTapsRequired = 2;//需要点两下
        twoFingerTap.numberOfTouchesRequired = 2;//需要两个手指touch
        
        [self.imageView addGestureRecognizer:singleTap];
        [self.imageView addGestureRecognizer:doubleTap];
        [self.imageView addGestureRecognizer:twoFingerTap];
        [singleTap requireGestureRecognizerToFail:doubleTap];//如果双击了，则不响应单击事件
        
        [_scrollView setZoomScale:1];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame withPhotoImage:(UIImage *)image{
    self = [super initWithFrame:frame];
    if (self) {
        //添加scrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.minimumZoomScale = 1;
        _scrollView.maximumZoomScale = 3;
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        //添加图片
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.imageView setImage:image];
        
        [self.imageView setUserInteractionEnabled:YES];
        [_scrollView addSubview:self.imageView];
        
        //添加手势
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
        
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        doubleTap.numberOfTapsRequired = 2;//需要点两下
        twoFingerTap.numberOfTouchesRequired = 2;//需要两个手指touch
        
        [self.imageView addGestureRecognizer:singleTap];
        [self.imageView addGestureRecognizer:doubleTap];
        [self.imageView addGestureRecognizer:twoFingerTap];
        [singleTap requireGestureRecognizerToFail:doubleTap];//如果双击了，则不响应单击事件
        
        [_scrollView setZoomScale:1];
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
//scroll view处理缩放和平移手势，必须需要实现委托下面两个方法,另外 maximumZoomScale和minimumZoomScale两个属性要不一样
//1.返回要缩放的图片
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}
//2.重新确定缩放完后的缩放倍数
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    [scrollView setZoomScale:scale+0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
}


#pragma mark - 图片的点击，touch事件
-(void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer{
    NSLog(@"单击");
    if (gestureRecognizer.numberOfTapsRequired == 1) {
        [self.delegate TapHiddenPhotoView];
    }
}

-(void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer{
    NSLog(@"双击");
    if (gestureRecognizer.numberOfTapsRequired == 2) {
        if(_scrollView.zoomScale == 1){
            float newScale = [_scrollView zoomScale] *2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
            [_scrollView zoomToRect:zoomRect animated:YES];
        }else{
            float newScale = [_scrollView zoomScale]/2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
            [_scrollView zoomToRect:zoomRect animated:YES];
        }
    }
}

-(void)handleTwoFingerTap:(UITapGestureRecognizer *)gestureRecongnizer{
    NSLog(@"2手指操作");
    float newScale = [_scrollView zoomScale]/2;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecongnizer locationInView:gestureRecongnizer.view]];
    [_scrollView zoomToRect:zoomRect animated:YES];
}


#pragma mark - 缩放大小获取方法
-(CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    //大小
    zoomRect.size.height = [_scrollView frame].size.height/scale;
    zoomRect.size.width = [_scrollView frame].size.width/scale;
    //原点
    zoomRect.origin.x = center.x - zoomRect.size.width/2;
    zoomRect.origin.y = center.y - zoomRect.size.height/2;
    return zoomRect;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
