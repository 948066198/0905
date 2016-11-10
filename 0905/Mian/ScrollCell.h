//
//  ScrollCell.h
//  0905
//
//  Created by spp on 16/9/7.
//  Copyright © 2016年 spp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollCell : UICollectionViewCell

@property(nonatomic,strong)UIScrollView *FirScrollview;

@property(nonatomic,strong)UIImageView *iv;

@property(nonatomic,strong)UIImageView *imgiv;

@property(nonatomic,strong)UILabel *contentLab;

@property(nonatomic,strong)UILabel *yearLab;

@property(nonatomic,strong)UILabel *strHpTitleLab;

@property(nonatomic,strong)UILabel *AuthorLab;

@property(nonatomic,strong)UILabel *dayLab;

@end
