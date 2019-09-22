//
//  sentenceViewController.h
//  TechJam
//
//  Created by Rahil Ali on 2019-09-22.
//  Copyright © 2019 Rahil Ali. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface sentenceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) NSString *text;
@property (nonatomic) NSMutableArray *sentences;

@end

NS_ASSUME_NONNULL_END
