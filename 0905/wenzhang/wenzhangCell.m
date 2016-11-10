//
//  wenzhangCell.m
//  0905
//
//  Created by spp on 16/9/7.
//  Copyright © 2016年 spp. All rights reserved.
//

#import "wenzhangCell.h"

@implementation wenzhangCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)prepareForReuse
{
    self.dateLab.text = nil;
    self.titleLab.text = nil;
    self.AuthorLab.text = nil;
    self.contentLab.attributedText = nil;
    self.sAuthLab.attributedText = nil;
    self.sWbNLab.attributedText = nil;
    self.lineLab.backgroundColor = nil;
    self.line1Lab.backgroundColor = nil;
    [super prepareForReuse];
}


-(void)setup
{
    self.myscrollvew = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-113)];
    self.myscrollvew.backgroundColor = RGBColor(244, 245, 246);
    [self addSubview:self.myscrollvew];
    
    self.dateLab = [self inintWithLabFrame:CGRectMake(10, 10, kWidth-20, 30) Color:RGBColor(107, 107, 107) Font:13];

    self.lineLab = [self inintWithLabFrame:CGRectMake(10, 38, kWidth-20, 1) Color: RGBColor(107, 107, 107) Font:12];
    
    self.titleLab = [self inintWithLabFrame:CGRectMake(10, 45, kWidth-20, 40) Color:RGBColor(100, 100, 100) Font:25];
    
    self.AuthorLab = [self inintWithLabFrame:CGRectMake(10, 80, kWidth-20, 25) Color:RGBColor(150, 150, 150) Font:13];
    
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.textColor = RGBColor(102, 102, 102);
    self.contentLab.font = [UIFont systemFontOfSize:16];
    
    self.sWbNLab = [[UILabel alloc]init];
    
    self.sAuthLab = [[UILabel alloc]init];
    self.sAuthLab.textColor = RGBColor(102, 102, 102);
    
    self.line1Lab = [[UILabel alloc]init];
    
    
    [self.myscrollvew addSubview:self.dateLab];
    [self.myscrollvew addSubview:self.titleLab];
    [self.myscrollvew addSubview:self.AuthorLab];
    [self.myscrollvew addSubview:self.contentLab];
    [self.myscrollvew addSubview:self.sWbNLab];
    [self.myscrollvew addSubview:self.sAuthLab];
    [self.myscrollvew addSubview:self.lineLab];
    [self.myscrollvew addSubview:self.line1Lab];

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
