//
//  ViewController.m
//  OCInterview
//
//  Created by NowOrNever on 05/07/2021.
//

#import "ViewController.h"
#import "TestProxyViewController.h"
#import "TestProxy.h"
#import "NSPointerArray+Helper.h"
#import "TestDispatch.h"

#define getDispatcher(__protocol__) \
(TestProxy<__protocol__> *)[self.testDispatch getDispatcher:@protocol(__protocol__)]

@interface ViewController ()
@property (nonatomic, strong, readonly) TestDispatch *testDispatch;            // 事件分发
@end

@implementation ViewController{
    TestProxyViewController *testVc1;
    TestProxyViewController *testVc2;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [getDispatcher(TestProtocol) say];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBlueColor];
    // Do any additional setup after loading the view.
    
    testVc1 = [[TestProxyViewController alloc] init];
    testVc1.name = @"testVc1";
    testVc2 = [[TestProxyViewController alloc] init];
    testVc2.name = @"testVc2";
    
    
    _testDispatch = [[TestDispatch alloc] init];
    [_testDispatch add:@protocol(TestProtocol) listener:testVc1];
    [_testDispatch add:@protocol(TestProtocol) listener:testVc2];
    
//    NSMethodSignature *signature = [TestProxyViewController instanceMethodSignatureForSelector:@selector(say)];
//    NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
//    invocation.selector = @selector(say);
//    [invocation invokeWithTarget:testVc1];
    
    //    [self invocationTest];

}

- (void)sendMessageWithNumber:(NSString *)number WithContent:(NSString *)content{
    NSLog(@"%s %@ %@", __func__, number, content);
}


- (void)invocationTest{
    //NSInvocation;用来包装方法和对应的对象，它可以存储方法的名称，对应的对象，对应的参数,
    /*
     NSMethodSignature：签名：再创建NSMethodSignature的时候，必须传递一个签名对象，签名对象的作用：用于获取参数的个数和方法的返回值
     */
    //创建签名对象的时候不是使用NSMethodSignature这个类创建，而是方法属于谁就用谁来创建
    NSMethodSignature*signature = [ViewController instanceMethodSignatureForSelector:@selector(sendMessageWithNumber:WithContent:)];
    //1、创建NSInvocation对象
    NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    //invocation中的方法必须和签名中的方法一致。
    invocation.selector = @selector(sendMessageWithNumber:WithContent:);
    /*第一个参数：需要给指定方法传递的值
           第一个参数需要接收一个指针，也就是传递值的时候需要传递地址*/
    //第二个参数：需要给指定方法的第几个参数传值
    NSString*number = @"1111";
    //注意：设置参数的索引时不能从0开始，因为0已经被self占用，1已经被_cmd占用
    [invocation setArgument:&number atIndex:2];
    NSString*number2 = @"啊啊啊";
    [invocation setArgument:&number2 atIndex:3];
    //2、调用NSInvocation对象的invoke方法
    //只要调用invocation的invoke方法，就代表需要执行NSInvocation对象中制定对象的指定方法，并且传递指定的参数
    [invocation invoke];
}


@end
