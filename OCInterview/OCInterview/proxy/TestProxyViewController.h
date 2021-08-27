//
//  TestProxyViewController.h
//  OCInterview
//
//  Created by liling on 2021/8/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol TestProtocol <NSObject>
- (void)say;
@end

@interface TestProxyViewController : UIViewController<TestProtocol>
@property (nonatomic, copy) NSString *name;

- (void)say;

@end

NS_ASSUME_NONNULL_END
