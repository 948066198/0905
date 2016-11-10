//
//  BaseVC.m
//  0905
//
//  Created by spp on 16/9/6.
//  Copyright © 2016年 spp. All rights reserved.
//

#import "BaseVC.h"



@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"horizontalLine"] forBarMetrics:UIBarMetricsDefault];

    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.navigationController.navigationBar.backgroundColor = RGBColor(230, 230, 230);
    
    
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 84, 25)];
    iv.image = [UIImage imageNamed:@"navLogo"];
    self.navigationItem.titleView = iv;
    
}

-(void)backBtn
{
    //返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 18);
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//navBar右边按钮
- (void)setRightBtnSecolor:(SEL)sel{
    //设置导航条右边按钮
    UIButton *rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightbtn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [rightbtn setImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    
}


//自定义lab
-(UILabel *)inintWithLabFrame:(CGRect)rect withTitle:(NSString *)title Color:(UIColor *)color Font:(CGFloat)font
{
    UILabel *lab = [[UILabel alloc]initWithFrame:rect];
    lab.text = title;
    lab.textColor = color;
    lab.font = [UIFont systemFontOfSize:font];
    return lab;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
