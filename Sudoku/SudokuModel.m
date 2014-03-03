//
//  SudokuModel.m
//  Sudoku
//
//  Created by Alexander Paul Demyanik on 3/1/14.
//  Copyright (c) 2014 WSUV. All rights reserved.
//

#import "SudokuModel.h"

@implementation SudokuModel{
    unsigned int SudokuBoard_game[9][9];
    unsigned int SudokuBoard_fixed[9][9];
    unsigned int SudokuBoard_pencil[9][9][3][3];
    int arraySize;
    int penSize;
    
}
-(id)init{
    arraySize = 9;
    penSize = 3;
    
    for (int i = 0; i < arraySize; i ++) {
        for (int j = 0; j < arraySize; j++){
            SudokuBoard_game[i][j] = 0;
            SudokuBoard_fixed[i][j] = 0;
            for (int k = 0; k < penSize; k ++) {
                for (int l = 0; l < penSize ; l++) {
                    SudokuBoard_pencil[i][j][k][l] = 0;
                }
            }
            
        }
    }
    
    return self;
}

-(void)freshGame:(NSString*)boardString{
    //If number at row col in SudokuBoard_game != 0 then row col in SudokuBoard_fixed = 1 for true
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
    BOOL conflict = NO;
    int boxRow = r - r%penSize;
    int boxCol = c - c%penSize;
    int num = SudokuBoard_game[r][c];
    
    for (int i = 0; i < arraySize; i++) {
        if (SudokuBoard_game[r][i] == num && i != c) {
            conflict = YES;// Row conflict
            return conflict;
        }
        if (SudokuBoard_game[i][c] == num && i != r) {
            conflict = YES;//Column conflict
            return conflict;
        }
    }
    
    //Boxrow and col is the starting point for the 3x3 square in which r,c is located
    for (int i = 0; i < penSize; i++) {
        for (int j = 0; j < penSize; j++) {
            if (SudokuBoard_game[i + boxRow][j + boxCol] == num && (i+boxRow != r && j+boxCol != c)) {
                conflict = YES;
                return conflict;
            }
        }
    }
    
    return conflict;
}

-(BOOL)anyPencilsSetAtRow:(int)r Column:(int)c{
    BOOL isPencil = NO;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            if (SudokuBoard_pencil[r][c][i][j] != 0) {
                isPencil = YES;
                return isPencil;
            }
        }
    }
    
    
    return isPencil;
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
