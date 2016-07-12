//
//  TouchDrawView.h
//  画板
//
//  Created by Netho on 16/6/21.
//  Copyright © 2016年 whq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Line;

@interface TouchDrawView : UIView
{
    BOOL _isCleared;
}
@property (nonatomic,strong) Line *currentLine;
@property (nonatomic,strong) NSMutableArray *lines;
@property (nonatomic,strong) UIColor *drawColor;


- (void)undo;
- (void)redo;



@end
