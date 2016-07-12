//
//  ColorSelectView.h
//  画板
//
//  Created by Netho on 16/6/21.
//  Copyright © 2016年 whq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorSelectView : UIView

- (void)selectColorWithBltn:(void(^)(UIButton *btn))blcok;

- (void)undoAction:(void(^)(UIButton *btn))Action;
- (void)redoAction:(void(^)(UIButton *btn))Action;
@end
