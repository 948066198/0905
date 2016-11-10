//
//  thingCell.m
//  0905
//
//  Created by spp on 16/9/8.
//  Copyright © 2016年 spp. All rights reserved.
//

#import "thingCell.h"

@implementation thingCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)prepareForReuse
{
    self.imgview.image = nil;
    self.titleLab.text = nil;
    self.contentLab.attributedText = nil;
    self.dateLab.text = nil;
    self.lineLab.backgroundColor = nil;
    [super prepareForReuse];
}

-(void)setup
{
    self.myscrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-113)];
    self.myscrollview.backgroundColor = RGBColor(244, 245, 246);
    [self addSubview:self.myscrollview];
    
    self.dateLab = [self inintWithLabFrame:CGRectMake(10, 10, kWidth-20, 30) Color:RGBColor(107, 107, 107) Font:13];
    
    self.lineLab = [self inintWithLabFrame:CGRectMake(10, 38, kWidth-20, 1) Color: RGBColor(107, 107, 107) Font:12];
    CGFloat firHeight = (kWidth-20)/19*20;
    self.imgview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 45, kWidth-20, firHeight)];
    
    self.titleLab = [self inintWithLabFrame:CGRectMake(10, firHeight+65, kWidth-2, 30) Color:RGBColor(100, 100, 100) Font:18];
    
    self.contentLab = [[UILabel alloc]init];
    
    [self addSubview:self.myscrollview];
    [self.myscrollview addSubview:self.dateLab];
    [self.myscrollview addSubview:self.lineLab];
    [self.myscrollview addSubview:self.imgview];
    [self.myscrollview addSubview:self.titleLab];
    [self.myscrollview addSubview:self.contentLab];
}

//自定义lab
-(UILabel *)inintWithLabFrame:(CGRect)rect Color:(UIColor *)color Font:(CGFloat)font
{
    UILabel *lab = [[UILabel alloc]initWithFrame:rect];
    lab.textColor = color;
    lab.font = [UIFont systemFontOfSize:font];
    return lab;
}

@end
