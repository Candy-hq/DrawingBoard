//
//  ViewController.m
//  画板
//
//  Created by Netho on 16/6/21.
//  Copyright © 2016年 whq. All rights reserved.
//

#import "ViewController.h"
#import "TouchDrawView.h"
#import "ColorSelectView.h"

@interface ViewController ()

@property (nonatomic,strong) TouchDrawView *drawView;

@property (nonatomic,strong) ColorSelectView *colorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorView = [[ColorSelectView alloc]initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, 100))];

    [self.colorView selectColorWithBltn:^(UIButton *btn) {
        self.drawView.drawColor = btn.backgroundColor;
    }];

    [self.colorView undoAction:^(UIButton *btn) {
        [self.drawView undo];
    }];
    
    [self.colorView redoAction:^(UIButton *btn) {
        [self.drawView redo];

    }];
    
    [self.view addSubview:self.colorView];
    
    self.drawView = [[TouchDrawView alloc]init];
    self.drawView.backgroundColor = [UIColor whiteColor];
    self.drawView.frame = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height - 100);
    [self.view addSubview:self.drawView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
