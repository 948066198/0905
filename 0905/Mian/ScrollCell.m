//
//  ScrollCell.m
//  0905
//
//  Created by spp on 16/9/7.
//  Copyright © 2016年 spp. All rights reserved.
//

#import "ScrollCell.h"

#define picHeight (kWidth-20)/1.25


@implementation ScrollCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)prepareForReuse
{
    self.AuthorLab.text = nil;
    self.iv.image = nil;
    self.imgiv.image = nil;
    self.strHpTitleLab.text = nil;
    self.dayLab.text = nil;
    self.yearLab.text = nil;
    [super prepareForReuse];
    
    
}

-(void)setup
{
    _FirScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-113)];
    _FirScrollview.backgroundColor = RGBColor(244, 245, 246);
    _FirScrollview.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:_FirScrollview];
    
    self.strHpTitleLab =[self inintWithLabFrame:CGRectMake(10, 15, 100, 30) Color:RGBColor(62, 62, 62) Font:16];
    
    self.imgiv = [[UIImageView alloc]init];
    [self.FirScrollview addSubview:self.imgiv];
    

    self.AuthorLab = [self inintWithLabFrame:CGRectMake(kWidth-160, picHeight+75, 150, 50) Color:[UIColor lightGrayColor] Font:16];
    self.AuthorLab.numberOfLines = 2;
    self.AuthorLab.textAlignment = NSTextAlignmentRight;
    
    self.dayLab = [self inintWithLabFrame:CGRectMake(10, picHeight+135, 60, 40) Color:RGBColor(83, 223, 255) Font:38];
    self.dayLab.font = [UIFont boldSystemFontOfSize:38];
    
    
    self.iv = [[UIImageView alloc]init];
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.textColor = [UIColor whiteColor];
    self.contentLab.font = [UIFont systemFontOfSize:16];
    self.contentLab.numberOfLines = 0;
    
    self.yearLab = [self inintWithLabFrame:CGRectMake(10, picHeight+180, 90, 25) Color:RGBColor(181, 181, 181) Font:14];
    
    [self.FirScrollview addSubview:self.iv];

    [self.FirScrollview addSubview:self.strHpTitleLab];
    [self.FirScrollview addSubview:self.AuthorLab];
    [self.FirScrollview addSubview:self.dayLab];
    [self.FirScrollview addSubview:self.yearLab];
    [self.iv addSubview:self.contentLab];

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
