//
//  DrawView.m
//  OCInterview
//
//  Created by liling on 2021/9/28.
//

#import "DrawView.h"

static const CGFloat WBLECommerceGuideProductViewCornerRadius = 10.0f;
static const CGFloat WBLECommerceGuideProductViewPeakWidth = 14.0f;
static const CGFloat WBLECommerceGuideProductViewPeakHeight = 7.0f;

@interface DrawView ()
@property (nonatomic, assign) CGFloat peakPosition;
@property (nonatomic, strong) UIView *view;

@end

@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.peakPosition = 0.732;
        self.backgroundColor = [UIColor systemGreenColor];
        [self addSubview:self.view];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"%s %p", __func__, self);
    [self update];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.view.frame = self.bounds;
//    [self update];
}

- (void)update{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    UIBezierPath *path = [[UIBezierPath alloc] init];
//    UIColor *fillColor = [UIColor systemBlueColor];
//    [fillColor setFill];
    [path moveToPoint:CGPointMake(0, WBLECommerceGuideProductViewCornerRadius)];
    [path addArcWithCenter:CGPointMake(WBLECommerceGuideProductViewCornerRadius, WBLECommerceGuideProductViewCornerRadius)
                    radius:WBLECommerceGuideProductViewCornerRadius
                startAngle:M_PI
                  endAngle:M_PI_2*3
                 clockwise:YES];
    [path addLineToPoint:CGPointMake(width-WBLECommerceGuideProductViewCornerRadius, 0)];
    [path addArcWithCenter:CGPointMake(width-WBLECommerceGuideProductViewCornerRadius, WBLECommerceGuideProductViewCornerRadius)
                    radius:WBLECommerceGuideProductViewCornerRadius
                startAngle:M_PI_2*3
                  endAngle:M_PI*2
                 clockwise:YES];
    [path addLineToPoint:CGPointMake(width, height-WBLECommerceGuideProductViewPeakHeight-WBLECommerceGuideProductViewCornerRadius)];
    [path addArcWithCenter:CGPointMake(width-WBLECommerceGuideProductViewCornerRadius, height-WBLECommerceGuideProductViewPeakHeight-WBLECommerceGuideProductViewCornerRadius)
                    radius:WBLECommerceGuideProductViewCornerRadius
                startAngle:0
                  endAngle:M_PI_2
                 clockwise:YES];
    [path addLineToPoint:CGPointMake(width*self.peakPosition+WBLECommerceGuideProductViewPeakWidth/2.0, height-WBLECommerceGuideProductViewPeakHeight)];
    [path addLineToPoint:CGPointMake(width*self.peakPosition, height)];
    [path addLineToPoint:CGPointMake(width*self.peakPosition-WBLECommerceGuideProductViewPeakWidth/2.0, height-WBLECommerceGuideProductViewPeakHeight)];
    [path addLineToPoint:CGPointMake(WBLECommerceGuideProductViewCornerRadius, height-WBLECommerceGuideProductViewPeakHeight)];
    [path addArcWithCenter:CGPointMake(WBLECommerceGuideProductViewCornerRadius, height-WBLECommerceGuideProductViewCornerRadius-WBLECommerceGuideProductViewPeakHeight)
                    radius:WBLECommerceGuideProductViewCornerRadius
                startAngle:M_PI_2
                  endAngle:M_PI
                 clockwise:YES];
    [path closePath];
//    [path fill];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
    self.view.layer.shadowPath = path.CGPath;
}

- (UIView *)view{
    if (!_view) {
        _view = [[UIView alloc] init];
        _view.layer.shadowColor = [UIColor redColor].CGColor;
        _view.layer.shadowOpacity = 0.15;
    }
    return _view;
}

@end
