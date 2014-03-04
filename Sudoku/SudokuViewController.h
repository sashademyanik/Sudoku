//
//  SudokuViewController.h
//  Sudoku
//
//  Created by Alexander Paul Demyanik on 2/20/14.
//  Copyright (c) 2014 WSUV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SudokuBoard.h"
#import "MenuButtonView.h"
#import "SudokuModel.h"

@interface SudokuViewController : UIViewController
@property (weak, nonatomic) IBOutlet SudokuBoard *BoardView;
@property (weak, nonatomic) IBOutlet MenuButtonView *ButtonView;
@property (readonly, assign, nonatomic) NSInteger selectedRow;
@property (readonly, assign, nonatomic) NSInteger selectedColumn;
@property SudokuModel *sudokuModel;

@end
