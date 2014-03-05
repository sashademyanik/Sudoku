//
//  SudokuBoard.h
//  Sudoku
//
//  Created by Alexander Paul Demyanik on 2/20/14.
//  Copyright (c) 2014 WSUV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SudokuModel.h"

@interface SudokuBoard : UIView

@property (readonly, assign, nonatomic) NSInteger selectedRow;
@property (readonly, assign, nonatomic) NSInteger selectedColumn;
@property SudokuModel *model;
@property (readonly, assign) CGRect square;
@property (readonly, assign) CGFloat delta;
@property (readonly, assign) CGFloat d;
@property (readonly, assign) CGFloat s;

-(CGRect)boardSquare;
-(void)setRow:(int)row Col:(int)col;
-(void)drawNumAtRow:(int)row Column:(int)col Number:(NSInteger)n;
-(void)drawPencilAtRow:(int)row Column: (int)col Number:(NSInteger)n;
@end
