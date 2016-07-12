//
//  ColorSelectView.m
//  画板
//
//  Created by Netho on 16/6/21.
//  Copyright © 2016年 whq. All rights reserved.
//

#import "ColorSelectView.h"

typedef void(^Color)(UIButton *);

@interface ColorSelectView ()

@property (nonatomic,copy) Color color;
@property (nonatomic,strong) void(^Undo)(UIButton *);
@property (nonatomic,strong) void(^Redo)(UIButton *);

@end

@implementation ColorSelectView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [ self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    CGFloat width = self.bounds.size.width / 10 ;
    
    for (int i = 0; i < 7; i++)
    {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn.tag = 100 +i;
        [self addSubview:btn];
        btn.frame = CGRectMake( 10 + (10 + width) * i, 10, width, width);
        [btn addTarget:self action:@selector(selectColor:) forControlEvents:(UIControlEventTouchUpInside)
        ];
        switch (i) {
            case 0:
            {
                btn.backgroundColor =[UIColor redColor];
            }
                break;
            case 1:
            {
                btn.backgroundColor =[UIColor orangeColor];
            }
                break;
            case 2:
            {
                btn.backgroundColor =[UIColor yellowColor];
            }
                break;
            case 3:
            {
                btn.backgroundColor =[UIColor greenColor];
            }
                break;
            case 4:
            {
                btn.backgroundColor =[UIColor cyanColor];
            }
                break;
            case 5:
            {
                btn.backgroundColor =[UIColor blueColor];
            }
                break;
            case 6:
            {
                btn.backgroundColor =[UIColor purpleColor];
            }
                break;
                
            default:
                break;
        }
    }
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn .frame  = CGRectMake(self.center.x - 50, self.bounds.size.height - 30, 50, 30);
    [btn addTarget:self action:@selector(undo:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:btn];
    [btn setTitle:@"撤销" forState:(UIControlStateNormal)];
    
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn1 .frame  = CGRectMake(self.center.x + 50, self.bounds.size.height - 30, 50, 30);
    [btn1 addTarget:self action:@selector(redo:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:btn1];
    [btn1 setTitle:@"恢复" forState:(UIControlStateNormal)];
    
}

- (void)undoAction:(void(^)(UIButton *btn))Action
{
    self.Undo = Action;
}
- (void)redoAction:(void(^)(UIButton *btn))Action
{
    self.Redo = Action;
}


- (void)undo:(UIButton *)btn
{
    self.Undo(btn);
}

- (void)redo:(UIButton *)btn
{
    self.Redo(btn);
}
//    [self.redBtn addTarget:self action:@selector(selectColor:) forControlEvents:(UIControlEventTouchUpInside)];

- (void)selectColorWithBltn:(void(^)(UIButton *btn))blcok
{
    self.color = blcok;
}

- (void)selectColor:(UIButton *)btn
{
        self.color(btn);
}






@end
