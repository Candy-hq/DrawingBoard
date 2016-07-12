//
//  Line.h
//  画板
//
//  Created by Netho on 16/6/21.
//  Copyright © 2016年 whq. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


@interface Line : NSObject

@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;
@property (nonatomic,) UIColor *color;

@end
