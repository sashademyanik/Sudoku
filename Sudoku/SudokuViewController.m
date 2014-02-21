//
//  SudokuViewController.m
//  Sudoku
//
//  Created by Alexander Paul Demyanik on 2/20/14.
//  Copyright (c) 2014 WSUV. All rights reserved.
//

#import "SudokuViewController.h"
#import "SudokuBoard.h"

@interface SudokuViewController ()

@end

@implementation SudokuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    SudokuBoard *sudokuBoardView = [[SudokuBoard alloc] initWithFrame:CGRectMake(10, 10, 130, 130)];
    sudokuBoardView.backgroundColor = [UIColor whiteColor];
    sudokuBoardView.contentMode = UIViewContentModeRedraw;
    [self.view addSubview:sudokuBoardView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
