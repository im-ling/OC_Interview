//
//  WBLCornerShadowView.m
//
//  Created by liling on 2021/9/24.
//

#import "WBLCornerShadowView.h"
#import "Masonry.h"
@interface WBLCornerShadowView()
@property (nonatomic, strong) CAShapeLayer *containerViewShapeLayer;
@property (nonatomic, strong) UIView *shadowView;
//@property (nonatomic, strong) CALayer *shadowLayer;
@property (nonatomic, strong) CAShapeLayer *shadowShapeLayer;
@end

@implementation WBLCornerShadowView

#pragma mark: init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    [self addSubview:self.shadowView];
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
    [self addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
    self.clipsToBounds = FALSE;
    
    _shadowColor = [UIColor colorWithWhite:.7 alpha:1.0];
    _shadowRadius = 10;
    _shadowOpacity = 0.15;
    _shadowDirections = WBLShadowDirectionNone;
}


#pragma mark: override

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    self.containerView.backgroundColor = backgroundColor;
}

#pragma mark: setter
- (void)setCorners:(UIRectCorner)corners{
    _corners = corners;
    [self updateUI];
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    [self updateUI];
}

- (void)setShadowDirections:(WBLShadowDirection)shadowDirections{
    _shadowDirections = shadowDirections;
    [self updateUI];
}

- (void)setShadowRadius:(CGFloat)shadowRadius{
    _shadowRadius = shadowRadius;
    [self updateUI];
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity{
    _shadowOpacity = shadowOpacity;
    self.shadowView.layer.shadowOpacity = shadowOpacity;
}

- (void)setShadowColor:(UIColor *)shadowColor{
    _shadowColor = shadowColor;
    self.shadowView.layer.shadowColor = shadowColor.CGColor;
}

#pragma mark: lazyload
//- (CALayer *)shadowLayer{
//    if (!_shadowLayer) {
//        _shadowLayer = [[CALayer alloc] init];
//        _shadowLayer.frame = self.bounds;
//    }
//    return _shadowLayer;
//}

- (UIView *)shadowView{
    if (!_shadowView) {
        _shadowView = [[UIView alloc] initWithFrame:self.bounds];
        _shadowView.clipsToBounds = FALSE;
    }
    return _shadowView;
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:self.bounds];
        _containerView.clipsToBounds = TRUE;
    }
    return _containerView;
}

- (CAShapeLayer *)containerViewShapeLayer{
    if (!_containerViewShapeLayer) {
        _containerViewShapeLayer = [[CAShapeLayer alloc] init];
    }
    return _containerViewShapeLayer;
}

- (CAShapeLayer *)shadowShapeLayer{
    if (!_shadowShapeLayer) {
        _shadowShapeLayer = [[CAShapeLayer alloc] init];
    }
    return _shadowShapeLayer;
}

#pragma mark: update subviews
- (void)layoutSubviews{
//    NSLog(@"%s %@", __func__, NSStringFromCGRect(self.bounds));
    [super layoutSubviews];
    [self updateUI];
}

- (void)updateUI{
//    NSLog(@"%s %p", __func__, self);
    
    // 更新frame
    CGRect bounds = self.bounds;
    CGSize boundsSize = bounds.size;

    if (self.cornerRadius * 2 > boundsSize.width && self.cornerRadius * 2 > boundsSize.height) {
        return;
    }
    
    // 更新圆角
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:self.corners cornerRadii: CGSizeMake(self.cornerRadius, self.cornerRadius)];
    self.containerViewShapeLayer.frame = bounds;
    self.containerViewShapeLayer.path = path.CGPath;
    self.containerView.layer.mask = self.containerViewShapeLayer;
    
    // 更新阴影
    CALayer *layer = self.shadowView.layer;
    layer.shadowRadius = self.shadowRadius;
    layer.shadowOpacity = self.shadowOpacity;
    layer.shadowColor = self.shadowColor.CGColor;
    layer.shadowPath = path.CGPath;

    if (_shadowDirections == WBLShadowDirectionNone) {
        self.shadowShapeLayer.frame = bounds;
        self.shadowShapeLayer.path = path.CGPath;
        layer.mask = self.shadowShapeLayer;
        return;
    }

    CGFloat radius = self.shadowRadius;
    CGFloat top = (_shadowDirections & WBLShadowDirectionTop) ? -radius : 0;
    CGFloat left = (_shadowDirections & WBLShadowDirectionLeft) ? -radius : 0;
    CGFloat right = boundsSize.width - left + ((_shadowDirections & WBLShadowDirectionRight) ? radius : 0) ;
    CGFloat bottom = boundsSize.height - top + ((_shadowDirections & WBLShadowDirectionBottom) ? radius : 0);
    CGRect newRect = CGRectMake(left, top, right, bottom);
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:newRect byRoundingCorners:self.corners cornerRadii: CGSizeMake(self.cornerRadius, self.cornerRadius)];
    self.shadowShapeLayer.frame = newRect;
    self.shadowShapeLayer.path = path2.CGPath;
    layer.mask = self.shadowShapeLayer;
}

@end
