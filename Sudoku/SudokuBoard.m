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

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        NSLog(@"ChessBoardView:initWithCoder:");
        _selectedRow = _selectedColumn = -1;
        // NO TOUCHY [self addTapGestureRecognizer];
    }
    return self;
}

-(CGRect)boardSquare {
    const CGRect myBounds = self.bounds;
    const CGFloat size = (myBounds.size.width < myBounds.size.height) ? myBounds.size.width : myBounds.size.height - 5;
    const CGPoint myCenter = CGPointMake(myBounds.size.width/2, myBounds.size.height/2);
    const CGPoint origin = CGPointMake(myCenter.x - size/2, myCenter.y - size/2);
    const CGRect boardSquare = CGRectMake(origin.x, origin.y, size, size);
    return boardSquare;
}

- (void)drawRect:(CGRect)rect{
    //NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:30], NSForegroundColorAttributeName: [UIColor blackColor] };
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    const CGRect boardSquare = [self boardSquare];
    
    const CGFloat size = boardSquare.size.width;
    
    //CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextSetLineWidth(context, 5);
    CGContextStrokeRect(context, boardSquare);
    
    const CGFloat squareSize = size/9;
    //CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    for (int row = 0 ; row < 9; row++) {
        for (int col = 0; col < 9; col++) {
            if ((col + row) % 2 == 1){
                /*CGContextFillRect(context,
                                  CGRectMake(boardSquare.origin.x + col *squareSize ,
                                             boardSquare.origin.y + row *squareSize,
                                             squareSize, squareSize));*/
            }
        }
    }
    
    if (self.selectedRow >= 0 && self.selectedColumn >= 0) {
        //CGContextSetRGBFillColor(context, 0, 0, 0, 0.7);
        //[[UIColor blueColor] setFill];
        CGContextFillRect(context, CGRectMake(boardSquare.origin.x + self.selectedColumn*squareSize, boardSquare.origin.y + self.selectedRow*squareSize, squareSize, squareSize));
    }

    
    
    
    
    //const NSString *text = [NSString stringWithFormat:@"%d", number];
    //const CGSize textSize = [text sizeWithAttributes:attributes];
    //const CGFloat x = gridOrigin.x + col*d + 0.5*(d - textSize.width);
    //const CGFloat y = gridOrigin.y + row*d + 0.5*(d - textSize.height);
    //const CGRect textRect = CGRectMake(x, y, textSize.width, textSize.height);
    //[text drawInRect:textRect withAttributes:attributes];
    
}


@end
