//
//  ViewController.m
//  OCInterview
//
//  Created by NowOrNever on 05/07/2021.
//

#import "ViewController.h"

@interface ViewController ()

@end

typedef struct{
    int one;
    int two;
    int three;
}myStruct;

void test(void){
    char *str = "123456789012";
//    reinterpret_cast<char *>(str);
//    myStruct *fake_pointer = (myStruct *)str;
    myStruct *fake_pointer = reinterpret_cast<myStruct *>(str);
    myStruct my_struct = {1, 2, 3};
    myStruct *pointer = &my_struct;
    NSLog(@"%lu", sizeof(myStruct));
    NSLog(@"%lu", sizeof(*pointer));
    NSLog(@"%lu", sizeof(*fake_pointer));
    NSLog(@"%x", pointer->three);
    NSLog(@"%x %x %x",fake_pointer->one, fake_pointer->two, fake_pointer->three);
}


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    test();
}


@end
