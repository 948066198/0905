//
//  MytabbarVc.m
//  0905
//
//  Created by spp on 16/9/6.
//  Copyright © 2016年 spp. All rights reserved.
//

#import "MytabbarVc.h"

#import "main1VC.h"

#import "wenzhangVC.h"

#import "wentiVC.h"

#import "dongxiVC.h"

#import "gerenVC.h"

@interface MytabbarVc ()

@end

@implementation MytabbarVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addController];
    
    
}

-(void)addController
{
//    person personSelected question questionSelected reading readingSelected thing thingSelected
    [self addcontroller:[[main1VC alloc]init] Title:@"首页" Image:@"home" SelectImgStr:@"homeSelected"];
    
    [self addcontroller:[[wenzhangVC alloc]init] Title:@"文章" Image:@"reading" SelectImgStr:@"readingSelected"];
    
    [self addcontroller:[[wentiVC alloc]init] Title:@"问题" Image:@"question" SelectImgStr:@"questionSelected"];
    
    [self addcontroller:[[dongxiVC alloc]init] Title:@"东西" Image:@"thing" SelectImgStr:@"thingSelected"];
    
    [self addcontroller:[[gerenVC alloc]init] Title:@"个人" Image:@"person" SelectImgStr:@"personSelected"];
}

-(void)addcontroller:(UIViewController *)VC Title:(NSString *)title Image:(NSString *)imgstr SelectImgStr:(NSString *)selectimgstr
{
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:imgstr];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectimgstr]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"perCenterNavBackImg"] forBarMetrics:UIBarMetricsDefault];
    
    [self addChildViewController:nav];
    
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
