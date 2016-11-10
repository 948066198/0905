//
//  BaseVC.h
//  0905
//
//  Created by spp on 16/9/6.
//  Copyright © 2016年 spp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController

-(UILabel *)inintWithLabFrame:(CGRect)rect withTitle:(NSString *)title Color:(UIColor *)color Font:(CGFloat)font;

-(void)backBtn;

- (void)setRightBtnSecolor:(SEL)sel;

@end
