//
//  TouchDrawView.m
//  画板
//
//  Created by Netho on 16/6/21.
//  Copyright © 2016年 whq. All rights reserved.
//

#import "TouchDrawView.h"
#import "Line.h"

@interface TouchDrawView ()
{
    BOOL _iseraser;
}

@end

@implementation TouchDrawView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.lines = [NSMutableArray array];
        [self setMultipleTouchEnabled:YES];
        self.drawColor = [UIColor blackColor];
        [self becomeFirstResponder];
    }
    return self;
}

- (void)undo
{
    if ([self.undoManager canUndo]) {
        [self.undoManager undo];
    }
}

- (void)redo
{
    if ([self.undoManager canRedo]) {
        [self.undoManager redo];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    for (Line *line in self.lines)
    {
        [line.color set];
        CGContextMoveToPoint(context, line.begin.x, line.begin.y);
        CGContextAddLineToPoint(context, line.end.x, line.end.y);
        CGContextStrokePath(context);
    }
}

- (void)didMoveToWindow
{
    [self becomeFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.undoManager beginUndoGrouping];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView:self];
        Line *new = [[Line alloc]init];
        [new setBegin:location];
        [new setEnd:location];
        [new setColor:_drawColor];
        self.currentLine = new;
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_isCleared) {
        for (UITouch *touch in touches)
        {
            [self.currentLine setColor:_drawColor];
            CGPoint location = [touch locationInView:self];
            self.currentLine.end = location;
            
            if (self.currentLine)
            {
                if ([self color:_drawColor isEqualToColor:[UIColor clearColor]])
                {
                    _iseraser = YES;
                }else
                {
                    _iseraser = NO;
                    [self addline:_currentLine];
                }
            }
            Line *newLine = [[Line alloc]init];
            newLine.begin = location;
            newLine.end = location;
            newLine.color = _drawColor;
            self.currentLine = newLine;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
    [self.undoManager endUndoGrouping];
}

- (void)addline:(Line *)line
{
    [[self.undoManager prepareWithInvocationTarget:self] removeLine:line];
    [self.lines addObject:line];
    [self setNeedsDisplay];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)removeLine:(Line *)line
{
    if ([self.lines containsObject:line]) {
        [[self.undoManager prepareWithInvocationTarget:self] addline:line];
        [self.lines removeObject:line];
        [self setNeedsDisplay];
    }
}


- (void)removeLineByEndPoint:(CGPoint)point
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        Line *evaluatedLine = (Line *)evaluatedObject;
        return (evaluatedLine.end.x <= point.x-1 || evaluatedLine.end.x > point.x+1) &&
        (evaluatedLine.end.y <= point.y-1 || evaluatedLine.end.y > point.y+1);
    }];
    NSArray *reslut = [self.lines filteredArrayUsingPredicate:predicate];
    if (reslut.count > 0) {
        [self.lines removeObject:reslut[0]];
    }
}

- (void)endTouches:(NSSet *)touches
{
    if (!_isCleared) {
        [self setNeedsDisplay];
    }else
    {
        _isCleared = NO;
    }
}



#pragma mark -
- (BOOL)color:(UIColor *)color1 isEqualToColor:(UIColor *)color2
{
    CGFloat r1 ,g1, b1, a1, a2,r2 ,g2 ,b2;
    [color1 getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [color2 getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    
    return r1 == r2 && g1 == g2 && b1 == b2 &&a1 == a2;
}
@end
