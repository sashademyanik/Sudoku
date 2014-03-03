//
//  SudokuBoard.m
//  Sudoku
//
//  Created by Alexander Paul Demyanik on 2/20/14.
//  Copyright (c) 2014 WSUV. All rights reserved.
//

#import "SudokuBoard.h"

@implementation SudokuBoard

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"ChessBoardView:initWithFrame:");
        _selectedRow = _selectedColumn = -1;
    }
    return self;
}

-(IBAction)handleTap:(UITapGestureRecognizer*)sender{
    NSLog(@"handleTap");
    const CGRect square = [self boardSquare];
    const CGPoint tapPoint = [sender locationInView:self];
    const CGFloat squareSize = square.size.width/9;
    const int col = floor((tapPoint.x - square.origin.x)/squareSize);
    const int row = floor((tapPoint.y - square.origin.y)/squareSize);
    if (col != self.selectedColumn || row != self.selectedRow) {
        NSLog(@"tapped square at row %d, col %d",row,col);
        _selectedColumn = col;
        _selectedRow = row;
        [self setNeedsDisplay];
    }
}
/*
-(void)handleFingerTap:(UIGestureRecognizer*)sender {
    const CGPoint tapPoint = [sender locationInView:sender.view];
    const CGRect square = [self boardSquare];
    const CGFloat delta = square.size.height/3;
    const CGFloat d = delta/3;
    
    const int col = (int)((tapPoint.x - square.origin.x)/d);
    const int row = (int)((tapPoint.y - square.origin.y)/d);
    if (0 <= row && row < 9 && 0 <= col && col < 9)
        if (row != _selectedRow || col != _selectedColumn)
            //if (self != nil && ![self numberIsFixedAtRow:row Column:col]) {
                _selectedRow = row;
                _selectedColumn = col;
                [self setNeedsDisplay];
            //}
}*/

-(CGRect)boardSquare {
    const CGRect myBounds = self.bounds;
    const CGFloat size = (myBounds.size.width < myBounds.size.height) ? myBounds.size.width : myBounds.size.height - 5;
    const CGPoint myCenter = CGPointMake(myBounds.size.width/2, myBounds.size.height/2);
    const CGPoint origin = CGPointMake(myCenter.x - size/2, myCenter.y - size/2);
    const CGRect boardSquare = CGRectMake(origin.x, origin.y, size, size);
    return boardSquare;
}

- (void)drawRect:(CGRect)rect{
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    const CGRect boardSquare = [self boardSquare];
    const CGFloat size = boardSquare.size.width;
    //CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextSetLineWidth(context, 5);
    CGContextStrokeRect(context, boardSquare);
    const CGFloat squareSize = size/9;
    int gridSize = 9;
    
    CGContextSetRGBFillColor(context, 1, 1, 1, 0.5);
    for (int row = 0 ; row < gridSize; row++) {
        for (int col = 0; col < gridSize; col++) {
            //Set boxes for every box of 3
            if (row % 3 == 0 && col % 3 == 0) {
                CGContextStrokeRectWithWidth(context, CGRectMake(boardSquare.origin.x + row* squareSize, boardSquare.origin.y + col * squareSize,
                                                                 squareSize * 3, squareSize * 3), 5.0);
            }
            CGContextStrokeRectWithWidth(context, CGRectMake(boardSquare.origin.x + col *squareSize ,
                                                             boardSquare.origin.y + row *squareSize,
                                                             squareSize-1, squareSize-1), 1.0);
            
        }
    }
    
    if (self.selectedRow >= 0 && self.selectedColumn >= 0) {
        CGContextSetRGBFillColor(context, 0, 0.6, 0, 0.3);
        //[[UIColor blueColor] setFill];
        CGContextFillRect(context, CGRectMake(boardSquare.origin.x + self.selectedColumn*squareSize, boardSquare.origin.y + self.selectedRow*squareSize, squareSize, squareSize));
    }
   
    
}


@end
