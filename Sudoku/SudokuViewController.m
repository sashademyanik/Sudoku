//
//  SudokuViewController.m
//  Sudoku
//
//  Created by Alexander Paul Demyanik on 2/20/14.
//  Copyright (c) 2014 WSUV. All rights reserved.
//

#import "SudokuViewController.h"


@interface SudokuViewController ()

@end

@implementation SudokuViewController{
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.sudokuModel = [[SudokuModel alloc] init];
    _selectedRow = _selectedColumn = -1;
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)handleTap:(UITapGestureRecognizer*)sender{
    NSLog(@"handleTap");
    const CGRect square = [self.BoardView boardSquare];
    const CGPoint tapPoint = [sender locationInView:_BoardView];
    const CGFloat squareSize = square.size.width/9;
    const int col = floor((tapPoint.x - square.origin.x)/squareSize);
    const int row = floor((tapPoint.y - square.origin.y)/squareSize);
    [self.BoardView setRow:self.selectedRow Col:self.selectedColumn];
    if (col != self.selectedColumn || row != self.selectedRow) {
        NSLog(@"tapped square at row %d, col %d",row,col);
        _selectedColumn = col;
        _selectedRow = row;
        [self.BoardView setNeedsDisplay];
    }
}

- (IBAction)buttonPressed:(id)sender {
    
}




-(void)viewWillLayoutSubviews {
    
    const CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    const CGRect viewBounds = self.view.bounds;
    const bool isPortrait = viewBounds.size.height >= viewBounds.size.width;
    
    if(isPortrait) {
        const CGFloat statusBarHeight = statusBarFrame.size.height;
        const float boardSize = viewBounds.size.width;
        const float buttonHeight = viewBounds.size.height - boardSize - statusBarHeight;
        _BoardView.frame = CGRectMake(0, statusBarHeight, boardSize, boardSize);
        _ButtonView.frame = CGRectMake(0, boardSize + statusBarHeight, boardSize, buttonHeight);
    }else {
        const CGFloat statusBarHeight = statusBarFrame.size.width;
        const float boardSize = viewBounds.size.height - statusBarHeight;
        const float buttonsWidth = viewBounds.size.width - boardSize;
        _BoardView.frame = CGRectMake(0, statusBarHeight, boardSize, boardSize);
        _ButtonView.frame = CGRectMake(boardSize, statusBarHeight, buttonsWidth, boardSize);
    }
   
}


@end
