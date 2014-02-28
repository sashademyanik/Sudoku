//
//  SudokuViewController.m
//  Sudoku
//
//  Created by Alexander Paul Demyanik on 2/20/14.
//  Copyright (c) 2014 WSUV. All rights reserved.
//

#import "SudokuViewController.h"
#import "SudokuBoard.h"
#import "MenuButtonView.h"

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
    const CGPoint origin = CGPointMake(myBounds.origin.x, myBounds.origin.y + [UIApplication sharedApplication].statusBarFrame.size.height);
    //const CGPoint origin = CGPointMake(myCenter.x - size/2, myCenter.y - size/2);

    SudokuBoard *sudokuBoardView = [[SudokuBoard alloc] initWithFrame:CGRectMake(origin.x, origin.y, size, size)];
    sudokuBoardView.backgroundColor = [UIColor whiteColor];
    sudokuBoardView.contentMode = UIViewContentModeRedraw;
    
    
    const CGRect sudokuBounds = sudokuBoardView.bounds;
    MenuButtonView *menuButtonView = [[MenuButtonView alloc] initWithFrame:CGRectMake(sudokuBounds.origin.x, sudokuBounds.origin.y + sudokuBounds.size.height, myBounds.size.width, myBounds.size.height - (sudokuBounds.origin.y + sudokuBounds.size.height) )];
    menuButtonView.backgroundColor = [UIColor greenColor];
    
    
    
    [self.view addSubview:sudokuBoardView];
    [self.view addSubview:menuButtonView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
