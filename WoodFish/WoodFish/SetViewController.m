//
//  SetViewController.m
//  WoodFish
//
//  Created by Yangjiakui on 2023/5/17.
//

#import "SetViewController.h"
#import <Masonry/Masonry.h>
#import "UserInfo.h"
#import "WebViewController.h"

@interface SetViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UILabel *textLabel;
@property (nonatomic, strong)UILabel *autoLabel;
@property (nonatomic, strong)NSMutableArray *colorViewArray;
@end

@implementation SetViewController
- (NSMutableArray *)colorViewArray {
    if(!_colorViewArray) {
        _colorViewArray = [NSMutableArray new];
        
    }
    return _colorViewArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Set";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(50);
        make.size.mas_equalTo(40);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.text = @"Set";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(backBtn);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
        make.left.right.bottom.mas_equalTo(0);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}
- (void)viewWillAppear:(BOOL)animated {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        for (UIButton *button in self.colorViewArray) {
            if(button.tag == [UserInfo sharedInstance].selectColorIndex.intValue) {
                button.layer.borderColor = [UIColor systemGreenColor].CGColor;
                button.layer.borderWidth = 5;
            }else {
                button.layer.borderColor = [UIColor clearColor].CGColor;
                button.layer.borderWidth = 5;
            }
        }
    });
}
- (void)backClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 6:3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0) {
        
        if(indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.textLabel.text = @"Chanting content";
            
            self.textLabel = [UILabel new];
            self.textLabel.textAlignment = NSTextAlignmentRight;
            self.textLabel.textColor = [UIColor orangeColor];
            self.textLabel.font = [UIFont boldSystemFontOfSize:14];
            self.textLabel.text = [UserInfo sharedInstance].chantingString ? [UserInfo sharedInstance].chantingString:@"पुण्यप्रमाण +1";
            NSLog(@"----%@", [UserInfo sharedInstance].chantingString);
            [cell.contentView addSubview:self.textLabel];
            [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell);
                make.right.mas_equalTo(-14);
                
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 1) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.textLabel.text = @"Display Chanting content";
            
            UISwitch *swich = [[UISwitch alloc]init];
            swich.on = [[UserInfo sharedInstance].isDisplayChantingString isEqualToString :@"no"];
            swich.tag = 1;
            [swich addTarget:self action:@selector(swichChanged:) forControlEvents:UIControlEventValueChanged];
            swich.onTintColor = [UIColor orangeColor];
            [cell.contentView addSubview:swich];
            [swich mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell);
                make.right.mas_equalTo(-14);
            }];cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 2) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.textLabel.text = @"Display count";
            UISwitch *swich = [[UISwitch alloc]init];
            swich.on = [[UserInfo sharedInstance].isDisplayCount isEqualToString :@"no"];
            swich.tag = 2;
            [swich addTarget:self action:@selector(swichChanged:) forControlEvents:UIControlEventValueChanged];
            swich.onTintColor = [UIColor orangeColor];
            [cell.contentView addSubview:swich];
            [swich mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell);
                make.right.mas_equalTo(-14);
            }];cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 3) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.textLabel.text = @"Knock pattern";
            UISwitch *swich = [[UISwitch alloc]init];
            swich.on = [[UserInfo sharedInstance].knockPattern isEqualToString :@"no"];
            swich.tag = 3;
            [swich addTarget:self action:@selector(swichChanged:) forControlEvents:UIControlEventValueChanged];
            swich.onTintColor = [UIColor orangeColor];
            [cell.contentView addSubview:swich];
            [swich mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell);
                make.right.mas_equalTo(-14);
            }];
            
            self.autoLabel = [UILabel new];
            self.autoLabel.textColor = [UIColor orangeColor];
            self.autoLabel.font = [UIFont boldSystemFontOfSize:14];
            self.autoLabel.text = [[UserInfo sharedInstance].knockPattern isEqualToString :@"no"] ? @"Automatic":@"Manual";
            [cell.contentView addSubview:self.autoLabel];
            [self.autoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(swich.mas_left).offset(-10);
                make.centerY.mas_equalTo(cell);
            }];cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 4) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.textLabel.text = @"Vibrational touch";
            UISwitch *swich = [[UISwitch alloc]init];
            swich.on = [[UserInfo sharedInstance].vibTouch isEqualToString :@"no"];
            swich.tag = 4;
            [swich addTarget:self action:@selector(swichChanged:) forControlEvents:UIControlEventValueChanged];
            swich.onTintColor = [UIColor orangeColor];
            [cell.contentView addSubview:swich];
            [swich mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell);
                make.right.mas_equalTo(-14);
            }];cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.textLabel.text = @"Woodfish color";
            
            NSArray *colors = @[[UIColor redColor], [UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor cyanColor],[UIColor blueColor],[UIColor purpleColor]];
            for (int i = 0; i<2; i++) {
                for (int j = 0; j<4; j++) {
                    UIButton *imageV = [UIButton buttonWithType:UIButtonTypeCustom];
                    [imageV addTarget:self action:@selector(selectColor:) forControlEvents:UIControlEventTouchUpInside];
                    imageV.layer.masksToBounds = YES;
                    imageV.layer.cornerRadius = 5;
                    imageV.tag = j+i*4;
                    [cell.contentView addSubview:imageV];
                    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(160+45*j);
                        make.top.mas_equalTo(20+40*i);
                        make.size.mas_equalTo(30);
                    }];
                    
                    if(j+i*4 == 0) {
                        [imageV setImage:[UIImage imageNamed:@"muyu"] forState:UIControlStateNormal];
                        imageV.layer.borderColor = [UIColor systemGreenColor].CGColor;
                        imageV.layer.borderWidth = 5;
                    }else {
                        imageV.backgroundColor = colors[j+i*4-1];
                        imageV.layer.borderColor = [UIColor clearColor].CGColor;
                        imageV.layer.borderWidth = 5;
                    }
                    [self.colorViewArray addObject:imageV];
                }
            }cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else {
        if(indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.textLabel.text = @"Share with friends";
            cell.imageView.image = [UIImage imageNamed:@"share"];
            //                    UILabel *contentLabel = [UILabel new];
            //                    contentLabel.textAlignment = NSTextAlignmentRight;
            //                    contentLabel.textColor = [UIColor orangeColor];
            //                    contentLabel.font = [UIFont boldSystemFontOfSize:14];
            //                    contentLabel.text = @"पुण्यप्रमाण +1";
            //                    [cell.contentView addSubview:contentLabel];
            //                    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            //                        make.centerY.mas_equalTo(cell);
            //                        make.right.mas_equalTo(-14);
            //
            //                    }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if(indexPath.row == 1){
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.textLabel.text = @"Version number";
            cell.imageView.image = [UIImage imageNamed:@"version"];
            UILabel *contentLabel = [UILabel new];
            contentLabel.textAlignment = NSTextAlignmentRight;
            contentLabel.textColor = [UIColor grayColor];
            contentLabel.font = [UIFont boldSystemFontOfSize:14];
            contentLabel.text = @"1.1.0";
            [cell.contentView addSubview:contentLabel];
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell);
                make.right.mas_equalTo(-14);
                
            }];cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.imageView.image = [UIImage imageNamed:@"contact"];
            cell.textLabel.text = @"Contact us";
            
            UILabel *contentLabel = [UILabel new];
            contentLabel.textAlignment = NSTextAlignmentRight;
            contentLabel.textColor = [UIColor grayColor];
            contentLabel.font = [UIFont boldSystemFontOfSize:14];
            contentLabel.text = @"792172201@qq.com";
            [cell.contentView addSubview:contentLabel];
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell);
                make.right.mas_equalTo(-14);
                
            }];cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}
- (void)selectColor: (UIButton *)sender {
    [UserInfo sharedInstance].selectColorIndex = [NSString stringWithFormat:@"%ld", sender.tag];
    for (UIButton *button in self.colorViewArray) {
        if(button.tag == sender.tag) {
            button.layer.borderColor = [UIColor systemGreenColor].CGColor;
            button.layer.borderWidth = 5;
        }else {
            button.layer.borderColor = [UIColor clearColor].CGColor;
            button.layer.borderWidth = 5;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if(indexPath.row == 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Chanting content" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = @"Enter Chanting content";
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                UITextField *textField = alertController.textFields.firstObject;
                //                    textField.text = @"पुण्यप्रमाण +1";
                NSString *text = textField.text;
                NSLog(@"Entered Text: %@", text);
                if(text.length > 0) {
                    [UserInfo sharedInstance].chantingString = text;
                    self.textLabel.text = text;
                    [self.tableView reloadData];
                }
                
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:confirmAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }else if (indexPath.section == 1) {
        if(indexPath.row == 0) {
            
            // 创建要分享的内容
            NSString *text = @"WoodFish";
            UIImage *image = [UIImage imageNamed:@"muyu"];
            NSURL *url = [NSURL URLWithString:@"https://www.apple.com/app-store/"];
            NSArray *activityItems = @[text,image, url];
            
            // 创建UIActivityViewController
            UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
            
            // 可选：设置排除的分享选项
            activityViewController.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeAirDrop,UIActivityTypePostToWeibo,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToVimeo,UIActivityTypeOpenInIBooks];
            
            // 可选：自定义UIActivityViewController的外观
            activityViewController.completionWithItemsHandler = ^(UIActivityType activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
                // 分享操作完成后的处理
                if (completed) {
                    NSLog(@"success");
                } else {
                    NSLog(@"falure");
                }
            };
            
            // 在当前视图控制器中呈现UIActivityViewController
            [self presentViewController:activityViewController animated:YES completion:nil];
            
        }else if(indexPath.row == 1) {
            WebViewController *webVC = [WebViewController new];
            webVC.modalPresentationStyle = UIModalPresentationFullScreen;
            webVC.urlString = @"http://192.168.3.5:8080/";
            [self presentViewController:webVC animated:YES completion:nil];
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0) {
        if(indexPath.row == 5) {
            return 100;
        }
    }
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (void)swichChanged: (UISwitch *)swich {
    if(swich.tag == 1) {
        [UserInfo sharedInstance].isDisplayChantingString = swich.isOn ? @"no":@"yes";
    }else if (swich.tag == 2) {
        [UserInfo sharedInstance].isDisplayCount = swich.isOn ? @"no":@"yes";
    }else if (swich.tag == 3) {
        self.autoLabel.text = swich.isOn ? @"Automatic":@"Manual";
        [UserInfo sharedInstance].knockPattern = swich.isOn ? @"no":@"yes";
    }else if (swich.tag == 4) {
        [UserInfo sharedInstance].vibTouch = swich.isOn ? @"no":@"yes";
    }
}
@end
