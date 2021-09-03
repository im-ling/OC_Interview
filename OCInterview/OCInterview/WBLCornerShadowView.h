//
//  WBLCornerShadowView.h
//
//  Created by liling on 2021/9/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, WBLShadowDirection) {
    WBLShadowDirectionNone      = 0,
    WBLShadowDirectionTop       = 1 << 0,
    WBLShadowDirectionLeft      = 1 << 1,
    WBLShadowDirectionRight     = 1 << 2,
    WBLShadowDirectionBottom    = 1 << 3,
    WBLShadowDirectionAll       = ~0UL
};

@interface WBLCornerShadowView : UIView
@property (nonatomic, strong) UIView *containerView;

// 圆角
@property (nonatomic, assign) UIRectCorner corners;
@property (nonatomic, assign) CGFloat cornerRadius;

//阴影
@property (nonatomic, assign) WBLShadowDirection shadowDirections;
@property (nonatomic, assign) CGFloat shadowRadius;
@property (nonatomic, assign) CGFloat shadowOpacity;
@property (nonatomic, strong) UIColor *shadowColor;
@end

NS_ASSUME_NONNULL_END
