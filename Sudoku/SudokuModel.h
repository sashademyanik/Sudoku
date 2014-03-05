//
//  SudokuModel.h
//  Sudoku
//
//  Created by Alexander Paul Demyanik on 3/1/14.
//  Copyright (c) 2014 WSUV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SudokuModel : NSObject
    

-(id)init;
-(int)getGameIndexRow:(int)row Column:(int)col;
-(int)getFixedIndexRow:(int)row Column:(int)col;
-(int)getPencilRow:(int)row Column:(int)col PRow:(int)pRow PCol:(int)pCol;
-(void)freshGame:(NSString*)boardString;
-(int)numberAtRow:(int)r Column:(int)c;
-(void)setNumber:(int)n AtRow:(int)r Column:(int)c;
-(BOOL)numberIsFixedAtRow:(int)r Column:(int)c;
-(BOOL)isConflictingEntryAtRow:(int)r Column:(int)c;
-(BOOL)anyPencilsSetAtRow:(int)r Column:(int)c;
-(int)numberOfPencilsSetAtRow:(int)r Column:(int)c;
-(BOOL)isSetPencil:(int)n AtRow:(int)r Column:(int)c;
-(void)setPencil:(int)n AtRow:(int)r Column:(int)c;
-(void)clearPencil:(int)n AtRow:(int)r Column:(int)c;
-(void)clearAllPencilsAtRow:(int)r Column:(int)c;
-(void)setConflictRow:(int)row Column:(int)col Num:(int)n;
-(int)getConflictRow:(int)row Column:(int)col;
-(BOOL)isWon;

@end
