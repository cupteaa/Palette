//
//  DrawView.h
//  Palette
//
//  Created by 于亚伟 on 2016/11/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

/** path color */
@property (nonatomic,strong) UIColor *pathColor;
/** line width */
@property (nonatomic,assign) NSInteger lineWidth;
/** image */
@property (nonatomic,strong) UIImage *image;

// 清屏
- (void)clear;

// 撤销
- (void)undo;


@end
