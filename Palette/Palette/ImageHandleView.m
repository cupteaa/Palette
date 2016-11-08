//
//  ImageHandleView.m
//  Palette
//
//  Created by 于亚伟 on 2016/11/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ImageHandleView.h"

@interface ImageHandleView()<UIGestureRecognizerDelegate>

/** imageview */
@property (nonatomic,weak) UIImageView *imageView;

@end

@implementation ImageHandleView

// 懒加载imageView
- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.userInteractionEnabled = YES;
        _imageView = imageView;
        // 添加手势
        [self setupGestures];
        
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return self.imageView;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}

- (void)setupGestures
{
    // pan
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_imageView addGestureRecognizer:pan];
    // rotate
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    rotate.delegate = self;
    [_imageView addGestureRecognizer:rotate];
    // pinch
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pinch.delegate = self;
    [_imageView addGestureRecognizer:pinch];
    // longPress
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPress.delegate = self;
    [_imageView addGestureRecognizer:longPress];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint curP = [pan translationInView:self.imageView];
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, curP.x, curP.y);
    // 复位
    [pan setTranslation:CGPointZero inView:self.imageView];
}

- (void)rotate:(UIRotationGestureRecognizer *)rotate
{
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotate.rotation);
    rotate.rotation = 0;
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    // 复位
    pinch.scale = 1;
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    // 长按图片闪一下,结束图片处理
    if (longPress.state == UIGestureRecognizerStateBegan) {
        // 开始长按点击
        // 图片闪一下
        [UIView animateWithDuration:0.25 animations:^{
            self.imageView.alpha = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                self.imageView.alpha = 1;
            } completion:^(BOOL finished) {
                // 截屏 生成一张新的图片
                // 开启上下文
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
                // 获得上下文
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                // 将控件的layer渲染到上下文
                [self.layer renderInContext:ctx];
                // 得到新的图片
                UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                // 关闭上下文
                UIGraphicsEndImageContext();
                // 判断block是否实现
                if (self.handleCompletionBlock) {
                    // 调用block传递image
                    self.handleCompletionBlock(image);
                }
                // 移除父控件
                [self removeFromSuperview];
            }];
        }];
        
    }
}


#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}





















@end
