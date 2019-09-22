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
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"analyze1"]) {
        // Get reference to the destination view controller
        AnalyzeViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.text = self.textView.text;
    }
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
