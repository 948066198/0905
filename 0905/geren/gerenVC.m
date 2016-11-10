//
//  gerenVC.m
//  0905
//
//  Created by spp on 16/9/6.
//  Copyright © 2016年 spp. All rights reserved.
//

#import "gerenVC.h"

#import "UIImageView+WebCache.h"

#define firHeight kWidth*47/75

@interface gerenVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;

@end

@implementation gerenVC
{
    NSArray *_imgArr;
    NSArray *_titleArr;
    NSMutableArray *_userArr;
    
    UIImageView *_iconiv;
    UILabel *_lab;
    UILabel *_jianjieLab;
    UIButton *_gobackBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userArr = [NSMutableArray array];
    
    _imgArr = @[@"p_notLogin",@"setting"];
    
    _titleArr = @[@"夜间模式",@"设置"];
    
    [self createUI];
    
    [self panduan];
    
    
    
}

-(void)panduan{
    //判断是否授权
   if ([ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo])
   {
       [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
           if (result) {
               
               NSLog(@"%@\n%@\n%@",userInfo.uid,userInfo.nickname,userInfo.profileImage);
               
               [_iconiv sd_setImageWithURL:[NSURL URLWithString:userInfo.profileImage] placeholderImage:[UIImage imageNamed:@"1231"]];
               _lab.text = userInfo.nickname;
               _jianjieLab.text = [NSString stringWithFormat:@"简介:%@",userInfo.aboutMe];
               _gobackBtn.hidden = NO;
           }else
           {
               
           }
           
       }];
   }else{
       _gobackBtn.hidden = YES;
   }
    
        
        
        
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)createUI
{
//    collectionHeadBg@2x
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, firHeight)];
    iv.userInteractionEnabled = YES;
    iv.image = [UIImage imageNamed:@"collectionHeadBg"];
    [self.view addSubview:iv];
    
    _iconiv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    _iconiv.userInteractionEnabled = YES;
    _iconiv.center = iv.center;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(login:)];
    [_iconiv addGestureRecognizer:tap];
    _iconiv.image = [UIImage imageNamed:@"1231"];
    _iconiv.layer.cornerRadius = 40;
    
    
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(0, iv.frame.size.height/2+40, kWidth, 30)];
    _lab.textAlignment = NSTextAlignmentCenter;
    _lab.text = @"未登录";
    _lab.textColor = [UIColor whiteColor];
    
    
    _jianjieLab = [self inintWithLabFrame:CGRectMake(0, iv.frame.size.height/2+70, kWidth, iv.frame.size.height/2-70) withTitle:@"" Color:[UIColor whiteColor] Font:15];
    _jianjieLab.textAlignment = NSTextAlignmentCenter;
    _jianjieLab.numberOfLines = 0;
    
    [iv addSubview:_iconiv];
    [iv addSubview:_lab];
    [iv addSubview:_jianjieLab];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, firHeight, kWidth, 140)];
    self.tableview.scrollEnabled = NO;
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.rowHeight = 50;
    [self.view addSubview:self.tableview];
    
    _gobackBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kHeight-109, kWidth-40, 44)];
    [_gobackBtn setBackgroundImage:[UIImage imageNamed:@"followUsBtn"] forState:UIControlStateNormal];
    [_gobackBtn addTarget:self action:@selector(tuichu) forControlEvents:UIControlEventTouchUpInside];
    [_gobackBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [_gobackBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_gobackBtn];
}

-(void)tuichu
{
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    _iconiv.image = [UIImage imageNamed:@"1231"];
    _lab.text = @"未登录";
    _jianjieLab.text = @"";
    _gobackBtn.hidden = YES;
    
}

-(void)login:(UITapGestureRecognizer *)sender
{
    if ([ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo])
    {
        
    }
    else{
        [self authWithAuthOptions];
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:_imgArr[indexPath.row]];
        cell.textLabel.text = _titleArr[indexPath.row];
        
        
    }
    if (indexPath.row == 0) {
        UISwitch *switchView = [[UISwitch alloc] init];
        [switchView setOn:NO];
        cell.accessoryView = switchView;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    headView.backgroundColor = RGBColor(248, 248, 248);
    UILabel *lab = [self inintWithLabFrame:CGRectMake(18, 10, 50, 20) withTitle:@"设置" Color:RGBColor(160, 160, 160) Font:13];
    [headView addSubview:lab];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
    }
}
-(void)authWithAuthOptions
{
    //关注新浪微博目前只有在安装了客户端下有效
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                                scopes:@{@(ShareTypeSinaWeibo): @[@"follow_app_official_microblog"]}
                                                         powerByHidden:YES
                                                        followAccounts:nil
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    [ShareSDK authWithType:ShareTypeSinaWeibo
                   options:authOptions
                    result:^(SSAuthState state, id<ICMErrorInfo> error) {
                        switch (state)
                        {
                            case SSAuthStateBegan:
                                NSLog(@"begin to auth");
                                break;
                            case SSAuthStateSuccess:
                            {
                                [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                                    if (result) {
                                    
                                        NSLog(@"%@\n%@\n%@",userInfo.uid,userInfo.nickname,userInfo.profileImage);
                                     
                                        [_iconiv sd_setImageWithURL:[NSURL URLWithString:userInfo.profileImage] placeholderImage:[UIImage imageNamed:@"1231"]];
                                        _lab.text = userInfo.nickname;
                                        _jianjieLab.text = [NSString stringWithFormat:@"简介:%@",userInfo.aboutMe];
                                        _gobackBtn.hidden = NO;
                                    }
                                }];
                            }
                                break;
                            case SSAuthStateCancel:
                            {
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cancel"
                                                                                message:nil
                                                                               delegate:self
                                                                      cancelButtonTitle:@"OK"
                                                                      otherButtonTitles:nil, nil];
                                [alert show];
                            }
                                break;
                            case SSAuthStateFail:
                            {
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed"
                                                                                message:[NSString stringWithFormat:@"error code: %zi,error description: %@",[error errorCode],[error errorDescription]]
                                                                               delegate:self
                                                                      cancelButtonTitle:@"OK"
                                                                      otherButtonTitles:nil, nil];
                                [alert show];
                            }
                                break;
                            default:
                                break;
                        }
                    }];
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
