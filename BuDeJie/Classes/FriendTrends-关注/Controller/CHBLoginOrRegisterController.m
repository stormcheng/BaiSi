//
//  CHBLoginOrRegisterController.m
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/21.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBLoginOrRegisterController.h"
#import "CHBLoginTextField.h"
@interface CHBLoginOrRegisterController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;
@property (weak, nonatomic) IBOutlet CHBLoginTextFiled *cellNumTextFiled;
@property (weak, nonatomic) IBOutlet CHBLoginTextFiled *registerCellNum;

@end

@implementation CHBLoginOrRegisterController
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 返回
- (IBAction)goBack:(UIButton *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 取消编辑
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark - 切换登录和注册
- (IBAction)LoginOrRegister:(UIButton *)sender {
    if (self.leadingConstraint.constant == 0 ) {
        self.leadingConstraint.constant = - self.view.chb_width;
        [self.registerCellNum becomeFirstResponder];
    }else{
        self.leadingConstraint.constant = 0;
        [self.cellNumTextFiled becomeFirstResponder];
    }
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:5 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
