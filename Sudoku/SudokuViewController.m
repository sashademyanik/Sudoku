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

@implementation SudokuViewController{
    SudokuBoard *boardView;
    MenuButtonView *buttonsView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    const CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    const CGRect viewBounds = self.view.bounds;
    
    const CGFloat statusBarHeight = statusBarFrame.size.height;
    const float boardSize = viewBounds.size.width;
    const float buttonHeight = viewBounds.size.height - boardSize - statusBarHeight;

    boardView = [[SudokuBoard alloc] initWithFrame:CGRectMake(0, statusBarHeight, boardSize, boardSize)];
    boardView.backgroundColor = [UIColor whiteColor];
    boardView.contentMode = UIViewContentModeRedraw;
    
    buttonsView = [[MenuButtonView alloc] initWithFrame:CGRectMake(0, boardSize + statusBarHeight, boardSize, buttonHeight)];
    buttonsView.backgroundColor = [UIColor colorWithRed:0.2 green:1 blue:0.6 alpha:0.1];
    
    [self.view addSubview:boardView];
    [self.view addSubview:buttonsView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews {
    
    const CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    const CGRect viewBounds = self.view.bounds;
    const bool isPortrait = viewBounds.size.height >= viewBounds.size.width;
    
    if(isPortrait) {
        const CGFloat statusBarHeight = statusBarFrame.size.height;
        const float boardSize = viewBounds.size.width;
        const float buttonHeight = viewBounds.size.height - boardSize - statusBarHeight;
        boardView.frame = CGRectMake(0, statusBarHeight, boardSize, boardSize);
        buttonsView.frame = CGRectMake(0, boardSize + statusBarHeight, boardSize, buttonHeight);
    }else {
        const CGFloat statusBarHeight = statusBarFrame.size.width;
        const float boardSize = viewBounds.size.height - statusBarHeight;
        const float buttonsWidth = viewBounds.size.width - boardSize;
        boardView.frame = CGRectMake(0, statusBarHeight, boardSize, boardSize);
        buttonsView.frame = CGRectMake(boardSize, statusBarHeight, buttonsWidth, boardSize);
    }
   
}

-(void)layoutSubviews {

}

@end
