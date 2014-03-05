//
//  SudokuBoard.m
//  Sudoku
//
//  Created by Alexander Paul Demyanik on 2/20/14.
//  Copyright (c) 2014 WSUV. All rights reserved.
//

#import "SudokuBoard.h"
#import "SudokuModel.h"

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
        _square = [self boardSquare];
        _delta = self.square.size.height/3;
        _d = self.delta/3;
        _s = self.d/3;
    }
    return self;
}

-(void)setRow:(int)row Col:(int)col {
    _selectedRow = row;
    _selectedColumn = col;
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
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            int num = [self.model getGameIndexRow:i Column:j];
            if (num != 0) {
                [self drawNumAtRow:i Column:j Number:num];
            }
            for (int k = 0; k < 3; k++) {
                for (int l = 0; l < 3; l++) {
                    int num = [self.model getPencilRow:i Column:j PRow:k PCol:l];
                    if (num != 0 ) {
                        [self drawPencilAtRow:i Column:j PRow:k PCol:l Number:num];
                    }
                }
            }
        }
    }
    [self setNeedsDisplay];
   
    
}

-(void)drawNumAtRow:(int)row Column:(int)col Number:(NSInteger)n{
    NSDictionary *attributes;
    if ([self.model getConflictRow:row Column:col] == 1 && [self.model getFixedIndexRow:row Column:col] == 0) {
        attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:30], NSForegroundColorAttributeName: [UIColor redColor] };
    }
    
    else if ([self.model numberIsFixedAtRow:row Column:col]) {
        attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:30], NSForegroundColorAttributeName: [UIColor blackColor] };
    }else{
        attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:30], NSForegroundColorAttributeName: [UIColor blueColor] };
    }
    
    const NSString *text = [NSString stringWithFormat:@"%d", n];
    const CGSize textSize = [text sizeWithAttributes:attributes];
    const CGFloat x = self.square.origin.x + col*self.d + 0.5*(self.d - textSize.width);
    const CGFloat y = self.square.origin.y + row*self.d + 0.5*(self.d - textSize.height);
    const CGRect textRect = CGRectMake(x, y, textSize.width, textSize.height);
    [text drawInRect:textRect withAttributes:attributes];
    [self setNeedsDisplay];
}

-(void)drawPencilAtRow:(int)row Column: (int)col PRow:(int)k PCol:(int)l Number:(NSInteger)n{
    NSDictionary *attributesPen = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:10], NSForegroundColorAttributeName: [UIColor blackColor] };
    NSLog(@"row: %d, col: %d, k: %d, l: %d",row,col,k,l);
    const NSString *pencilText = [NSString stringWithFormat:@"%d",n];
    const CGSize penTextSize = [pencilText sizeWithAttributes:attributesPen];
    const CGFloat penX = self.square.origin.x + col * self.d + 0.5 * (self.d - penTextSize.width) + (l-1)*self.s;
    const CGFloat penY = self.square.origin.y + row * self.d + 0.5 * (self.d - penTextSize.height) + (k-1) *self.s;
    const CGRect penText = CGRectMake(penX,penY, penTextSize.width, penTextSize.height);
    [pencilText drawInRect: penText withAttributes: attributesPen];
}


@end
