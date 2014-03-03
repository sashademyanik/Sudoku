//
//  SudokuModel.m
//  Sudoku
//
//  Created by Alexander Paul Demyanik on 3/1/14.
//  Copyright (c) 2014 WSUV. All rights reserved.
//

#import "SudokuModel.h"

@implementation SudokuModel{
    const int SudokuBoard_game[9][9];
    const int SudokuBoard_fixed[9][9];
    const int SudokuBoard_pencil[9][9][3][3];
    
    
    
    /*
     const CGFloat delta = boardSquare.size.height/3;
     const CGFloat d = delta/3;
     const CGFloat s = d/3;
     NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:30], NSForegroundColorAttributeName: [UIColor blackColor] };
     
     const NSString *text = [NSString stringWithFormat:@"%d", 8];
     const CGSize textSize = [text sizeWithAttributes:attributes];
     const CGFloat x = boardSquare.origin.x + 0*d + 0.5*(d - textSize.width);
     const CGFloat y = boardSquare.origin.y + 0*d + 0.5*(d - textSize.height);
     const CGRect textRect = CGRectMake(x, y, textSize.width, textSize.height);
     [text drawInRect:textRect withAttributes:attributes];
     
     NSDictionary *attributesPen = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:10], NSForegroundColorAttributeName: [UIColor blackColor] };
     const NSString *pencilText = [NSString stringWithFormat:@"%d",2];
     const CGSize penTextSize = [text sizeWithAttributes:attributesPen];
     const CGFloat penX = boardSquare.origin.x + 0 + 0.5 * (s- penTextSize.width);
     const CGFloat penY = boardSquare.origin.y + 0 + 0.5 * (s - penTextSize.height);
     const CGRect penText = CGRectMake(penX,penY, penTextSize.width, penTextSize.height);
     [pencilText drawInRect: penText withAttributes: attributesPen]; */
}
-(id)init{
    
    
    return self;
}

-(void)freshGame:(NSString*)boardString{
    
}

-(int)numberAtRow:(int)r Column:(int)c{
    return SudokuBoard_game[r][c];
    
}

-(void)setNumber:(int)n AtRow:(int)r Column:(int)c{
    //SudokuBoard_game[r][c] = n;
}

-(BOOL)numberIsFixedAtRow:(int)r Column:(int)c{
    return NO;
}

-(BOOL)isConflictingEntryAtRow:(int)r Column:(int)c{
    return YES;
}

-(BOOL)anyPencilsSetAtRow:(int)r Column:(int)c{
    return YES;
}

-(int)numberOfPencilsSetAtRow:(int)r Column:(int)c{
    return 0;
}

-(BOOL)isSetPencil:(int)n AtRow:(int)r Column:(int)c{
    return YES;
}

-(void)setPencil:(int)n AtRow:(int)r Column:(int)c{
    
}

-(void)clearPencil:(int)n AtRow:(int)r Column:(int)c{
    
}

-(void)clearAllPencilsAtRow:(int)r Column:(int)c{
    
}

@end
