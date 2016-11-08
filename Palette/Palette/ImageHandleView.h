//
//  ImageHandleView.h
//  Palette
//
//  Created by 于亚伟 on 2016/11/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageHandleView : UIView
/** image */
@property (nonatomic,strong) UIImage *image;

/** 图片处理完成 */
@property (nonatomic,strong) void(^handleCompletionBlock)(UIImage *image);
/** 开始处理图片 */
@property (nonatomic,strong) void(^handleBeginBlock)();
@end
