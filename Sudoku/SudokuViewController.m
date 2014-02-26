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
    const CGRect myBounds = self.view.bounds;
    const CGFloat size = (myBounds.size.width < myBounds.size.height) ? myBounds.size.width : myBounds.size.height - 5;
    const CGPoint myCenter = CGPointMake(myBounds.size.width/2, myBounds.size.height/2);
    const CGPoint origin = CGPointMake(myCenter.x - size/2, myCenter.y - size/2);

    SudokuBoard *sudokuBoardView = [[SudokuBoard alloc] initWithFrame:CGRectMake(origin.x, origin.y, size, size)];
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
