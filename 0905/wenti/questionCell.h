//
//  questionCell.h
//  0905
//
//  Created by spp on 16/9/8.
//  Copyright © 2016年 spp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface questionCell : UICollectionViewCell

@property(nonatomic,strong)UIScrollView *myscrollvew;

@property(nonatomic,strong)UILabel *dateLab;

@property(nonatomic,strong)UILabel *lineLab;

@property(nonatomic,strong)UIImageView *questionIv;

@property(nonatomic,strong)UILabel *questiontitleLab;

@property(nonatomic,strong)UILabel *questioncontentLab;

@property(nonatomic,strong)UILabel *line1Lab;

@property(nonatomic,strong)UIImageView *answerIv;

@property(nonatomic,strong)UILabel *answertitleLab;

@property(nonatomic,strong)UILabel *answercontentLab;

@end
