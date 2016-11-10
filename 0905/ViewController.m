//
//  ViewController.m
//  0905
//
//  Created by spp on 16/9/5.
//  Copyright © 2016年 spp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)UIImageView *iv;

@end

@implementation ViewController
{
    UIImage *_img;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _img = [UIImage imageNamed:@"contBack@2x"];
    
    self.iv = [[UIImageView alloc]init];
    
    [self.view addSubview:self.iv];
    
    NSString *str = @"我们总是追求故事的意义，想要从中学到做人的道理，而最终往往什么也没有得到，也许是因为，故事本身终究是作者的假话，生活却是大段大段的真话，虽然残酷无情，我们也只能努力向前，没有后退的空间，没有转换的余地。 by 张寒寺";
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    NSLog(@"%f",size.height);
    
    [self image:size.height];
    
    
    UILabel *lab = [[UILabel alloc]init];
    
    
    lab.frame = CGRectMake(10, 5, self.iv.frame.size.width-10, size.height);
    
    lab.text = str;
    
    lab.font = [UIFont systemFontOfSize:15];
    
    lab.textColor = [UIColor whiteColor];
    
    lab.numberOfLines = 0;
    
    [self.iv addSubview:lab];
    
}

-(void)image:(CGFloat)height{
    
    CGRect rect = CGRectMake(0, 0, _img.size.width*2, 30);

    CGImageRef fir = CGImageCreateWithImageInRect(_img.CGImage, rect);
    
    UIImage *img = [UIImage imageWithCGImage:fir];
    
    CGImageRelease(fir);
    
   
    CGRect rect1 = CGRectMake(0, 30, _img.size.width*2, 10);
    
    CGImageRef sec = CGImageCreateWithImageInRect(_img.CGImage, rect1);
    
    UIImage *img1 = [UIImage imageWithCGImage:sec];
    
    CGImageRelease(sec);
    
    
    CGRect rect2 = CGRectMake(0, 30, _img.size.width*2, 30);
    
    CGImageRef thir = CGImageCreateWithImageInRect(_img.CGImage, rect2);
    
    UIImage *img2 = [UIImage imageWithCGImage:thir];

    CGImageRelease(thir);
    
    UIGraphicsBeginImageContext(CGSizeMake(209*2, height+10));
    [img drawInRect:CGRectMake(0, 0, 209*2, 30)];
    [img1 drawInRect:CGRectMake(0, 30, 209*2, height-50)];
    [img2 drawInRect:CGRectMake(0, height-20, 209*2, 30)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    self.iv.frame = CGRectMake(30, 30, 300, height+10);
    self.iv.image = image;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
