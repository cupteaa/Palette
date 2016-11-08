//
//  DrawView.m
//  Palette
//
//  Created by 于亚伟 on 2016/11/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "DrawView.h"
#import "DrawPath.h"

@interface DrawView ()

@property(nonatomic, strong) DrawPath *path;
@property(nonatomic, strong) NSMutableArray *paths;

@end

@implementation DrawView

- (NSMutableArray *)paths
{
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

// 清屏
- (void)clear
{
    [self.paths removeAllObjects];
    self.pathColor = [UIColor blackColor];
    self.lineWidth = 1;
    [self setNeedsDisplay];
}
// 撤销
- (void)undo
{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    // 添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    self.lineWidth = 1;
    self.pathColor = [UIColor blackColor];
}
// 当手指拖动的时候调用
- (void)pan:(UIPanGestureRecognizer *)pan
{
    // 获取手指的位置
    CGPoint curP = [pan locationInView:self];
    if (pan.state == UIGestureRecognizerStateBegan) {
        // 常见贝瑟尔路径
        self.path = [DrawPath bezierPath];
        // 线宽,颜色
        self.path.lineWidth = self.lineWidth;
        self.path.pathColor = self.pathColor;
        // 起点
        [self.path moveToPoint:curP];
        // 保存路径
        [self.paths addObject:self.path];
    }
    [self.path addLineToPoint:curP];
    // 重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    for (DrawPath *path in self.paths) {
        [path.pathColor set];
        [path stroke];
    }
}

























@end
