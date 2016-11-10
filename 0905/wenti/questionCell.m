//
//  questionCell.m
//  0905
//
//  Created by spp on 16/9/8.
//  Copyright © 2016年 spp. All rights reserved.
//

#import "questionCell.h"

@implementation questionCell

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
    self.lineLab.backgroundColor = nil;
    self.questionIv.image = nil;
    self.answerIv.image = nil;
    self.questiontitleLab.attributedText = nil;
    self.questioncontentLab.attributedText = nil;
    self.answertitleLab.attributedText = nil;
    self.answercontentLab.attributedText = nil;
    self.line1Lab.backgroundColor = nil;
    [super prepareForReuse];
}

-(void)setup{
    self.myscrollvew = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-113)];
    self.myscrollvew.backgroundColor = RGBColor(244, 245, 246);
    [self addSubview:self.myscrollvew];
    
    self.dateLab = [self inintWithLabFrame:CGRectMake(10, 10, kWidth-20, 30) Color:RGBColor(107, 107, 107) Font:13];
    
    self.lineLab = [self inintWithLabFrame:CGRectMake(10, 38, kWidth-20, 1) Color: RGBColor(107, 107, 107) Font:12];
    self.line1Lab = [[UILabel alloc]init];
    
    self.questionIv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 50, 38, 38)];
    
    self.questiontitleLab = [[UILabel alloc]init];
    
    self.questioncontentLab = [[UILabel alloc]init];
    
    self.answerIv = [[UIImageView alloc]init];
    
    self.answertitleLab = [[UILabel alloc]init];
    
    self.answercontentLab = [[UILabel alloc]init];
    
    [self addSubview:self.myscrollvew];
    [self.myscrollvew addSubview:self.dateLab];
    [self.myscrollvew addSubview:self.lineLab];
    [self.myscrollvew addSubview:self.questionIv];
    [self.myscrollvew addSubview:self.questiontitleLab];
    [self.myscrollvew addSubview:self.questioncontentLab];
    [self.myscrollvew addSubview:self.line1Lab];
    [self.myscrollvew addSubview:self.answerIv];
    [self.myscrollvew addSubview:self.answertitleLab];
    [self.myscrollvew addSubview:self.answercontentLab];
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
