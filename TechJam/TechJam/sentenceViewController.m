//
//  sentenceViewController.m
//  TechJam
//
//  Created by Rahil Ali on 2019-09-22.
//  Copyright © 2019 Rahil Ali. All rights reserved.
//

#import "sentenceViewController.h"

@interface sentenceViewController ()

@end

@implementation sentenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.textView.text = self.text;
    
    NSRange range1 = [self.text rangeOfString:self.text];

    NSMutableAttributedString* myMutableString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [myMutableString addAttribute:NSForegroundColorAttributeName
    value:[UIColor whiteColor]
    range:range1];
    
    [myMutableString addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:18.0f]
       range:range1];
      
    
    for (NSString *sentence in self.sentences) {
        NSRange range = [self.text rangeOfString:sentence];
        [myMutableString addAttribute:NSForegroundColorAttributeName
                     value:self.color
                     range:range];
    }
    
    [self.textView setAttributedText:myMutableString];
    
  
    // Do any additional setup after loading the view.
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
