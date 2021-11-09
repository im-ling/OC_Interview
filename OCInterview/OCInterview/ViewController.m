//
//  ViewController.m
//  OCInterview
//
//  Created by NowOrNever on 05/07/2021.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UILabel *label = [[UILabel alloc] init];
//    label.numberOfLines = 2;
//    label.attributedText = [self attStr];
//    [label sizeToFit];
//    [self.view addSubview:label];
//    label.center = self.view.center;
    // Do any additional setup after loading the view.
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [btn setAttributedTitle:[self attStr] forState:UIControlStateNormal];
    btn.titleLabel.numberOfLines = 2;
//    [btn sizeToFit];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    
}




- (NSAttributedString *)attStr{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]init];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"Title\n"];
    [title addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:18] range:NSMakeRange(0, title.length)];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
    
    NSMutableAttributedString *desc = [[NSMutableAttributedString alloc] initWithString:@"Desc"];
    [desc addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:12] range:NSMakeRange(0, desc.length)];
    
    [attStr appendAttributedString:title];
    [attStr appendAttributedString:desc];
    
    //3.设置段落样式
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineSpacing = 10;  //行间距
//    paragraph.paragraphSpacing = 20;  //段间距
    paragraph.alignment = NSTextAlignmentCenter; //对齐方式
//    paragraph.firstLineHeadIndent = 30;  //首行缩进
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, attStr.length)];
    return attStr;
}


@end
