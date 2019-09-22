//
//  textViewController.m
//  TechJam
//
//  Created by Rahil Ali on 2019-09-22.
//  Copyright © 2019 Rahil Ali. All rights reserved.
//

#import "textViewController.h"
#import "AnalyzeViewController.h"

@interface textViewController ()

@end

@implementation textViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textView.delegate = self;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"analyze1"]) {
        // Get reference to the destination view controller
        AnalyzeViewController *vc = [segue destinationViewController];
        
        if ([self.textView.text characterAtIndex:self.textView.text.length -1] != '.') {
            self.textView.text = [self.textView.text stringByAppendingString:@"."];
        }
        
        // Pass any objects to the view controller here, like...
        vc.text = self.textView.text;
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textViewShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

    [self.view endEditing:YES];
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    CGRect frame = self.analyzeButton.frame;
    
    // Assign new frame to your view
    [self.analyzeButton setFrame:CGRectMake(frame.origin.x,400,frame.size.width,frame.size.height)]; //here taken -110 for example i.e. your view will be scrolled to -110. change its value according to your requirement.

}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [self.analyzeButton setFrame:CGRectMake(0,0,320,460)];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
