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
    unsigned int SudokuBoard_conflict[9][9];
    int arraySize;
    int penSize;
	NSArray *simple;
	NSArray *hard;
    
}
-(id)init{
    arraySize = 9;
    penSize = 3;
    for (int i = 0; i < arraySize; i ++) {
        for (int j = 0; j < arraySize; j++){
            SudokuBoard_game[i][j] = 0;
            SudokuBoard_fixed[i][j] = 0;
            SudokuBoard_conflict[i][j] = 0;
            for (int k = 0; k < penSize; k ++) {
                for (int l = 0; l < penSize ; l++) {
                    SudokuBoard_pencil[i][j][k][l] = 0;
                }
            }
            
        }
    }
    
    return self;
}

-(BOOL)isWon{
    BOOL won = YES;
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            if (SudokuBoard_game[i][j] == 0 || SudokuBoard_conflict[i][j] != 0) {
                won = NO;
            }
        }
    }
    return won;
}

-(int)getGameIndexRow:(int)row Column:(int)col{
    return SudokuBoard_game[row][col];
}
-(int)getFixedIndexRow:(int)row Column:(int)col{
    return SudokuBoard_fixed[row][col];
}
-(int)getPencilRow:(int)row Column:(int)col PRow:(int)pRow PCol:(int)pCol{
    return SudokuBoard_pencil[row][col][pRow][pCol];
}

-(void)setConflictRow:(int)row Column:(int)col Num:(int)n{
    SudokuBoard_conflict[row][col] = n;
}
-(int)getConflictRow:(int)row Column:(int)col{
    return SudokuBoard_conflict[row][col];
}

-(void)freshGame:(NSString*)boardString{
    //If number at row col in SudokuBoard_game != 0 then row col in SudokuBoard_fixed = 1 for true
    for (int i = 0; i < arraySize; i ++) {
        for (int j = 0; j < arraySize; j++){
            SudokuBoard_game[i][j] = 0;
            SudokuBoard_fixed[i][j] = 0;
            SudokuBoard_conflict[i][j] = 0;
            for (int k = 0; k < penSize; k ++) {
                for (int l = 0; l < penSize ; l++) {
                    SudokuBoard_pencil[i][j][k][l] = 0;
                }
            }
            
        }
    }
	int i = 0;
	for(int j = 0; j < arraySize; j++){
		for(int k = 0; k < arraySize; k++){
			NSString *c = [boardString substringWithRange:NSMakeRange(i,1)];
			if ( ![c isEqualToString: @"."] ){
				int intVal = [c intValue];
				SudokuBoard_game[j][k] = intVal;
				SudokuBoard_fixed[j][k] = 1;
			}
			i++;
		}
	}
}


-(int)numberAtRow:(int)r Column:(int)c{
    return SudokuBoard_game[r][c];
    
}

-(void)setNumber:(int)n AtRow:(int)r Column:(int)c{
    SudokuBoard_game[r][c] = n;
}

-(BOOL)numberIsFixedAtRow:(int)r Column:(int)c{
	BOOL fixed = NO;
	if (SudokuBoard_fixed[r][c] != 0){
		fixed = YES;
	}
    return fixed;
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
	int count = 0;
	for (int i = 0; i < penSize; i++){
		for (int j = 0; j < penSize; j++){
			if (SudokuBoard_pencil[r][c][i][j] != 0){
				count++;
			}
		}
	}
    return count;
}

-(BOOL)isSetPencil:(int)n AtRow:(int)r Column:(int)c{
	BOOL isSet = NO;
	for (int i = 0; i < penSize; i++){
		for (int j = 0; j < penSize; j++){
			if (SudokuBoard_pencil[r][c][i][j] == n){
				isSet = YES;
				return isSet;
			}
		}
	}
	
    return isSet;
}

-(void)setPencil:(int)n AtRow:(int)r Column:(int)c{
    if( n <= 3 && n >= 1){
		SudokuBoard_pencil[r][c][0][n%3] = n;
	}else if( n >= 4 && n <= 6){
		SudokuBoard_pencil[r][c][1][n%3] = n;
	}else if( n >=7 && n <= 9){
		SudokuBoard_pencil[r][c][2][n%3] = n;
	}
}

-(void)clearPencil:(int)n AtRow:(int)r Column:(int)c{
	BOOL done = NO;
    for (int i = 0; i < penSize; i++){
		for (int j = 0; j < penSize; j++){
			if (SudokuBoard_pencil[r][c][i][j] == n){
				SudokuBoard_pencil[r][c][i][j] = 0;
				done = YES;
				break;
			}
		}
		if (done) {break;}
	}
}

-(void)clearAllPencilsAtRow:(int)r Column:(int)c{
    for (int i = 0; i < penSize; i++){
		for (int j = 0; j < penSize; j++){
			SudokuBoard_pencil[r][c][i][j] = 0;
		}
	}
}

@end
