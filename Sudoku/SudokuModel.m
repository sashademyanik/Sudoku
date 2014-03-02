//
//  SudokuModel.m
//  Sudoku
//
//  Created by Alexander Paul Demyanik on 3/1/14.
//  Copyright (c) 2014 WSUV. All rights reserved.
//

#import "SudokuModel.h"

@implementation SudokuModel

-(void)freshGame:(NSString*)boardString{
    
}

-(int)numberAtRow:(int)r Column:(int)c{
    return 0;
    
}

-(void)setNumber:(int)n AtRow:(int)r Column:(int)c{
    
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
