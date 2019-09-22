//
//  AnalyzeViewController.h
//  TechJam
//
//  Created by Rahil Ali on 2019-09-21.
//  Copyright © 2019 Rahil Ali. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnalyzeViewController : UITableViewController
@property(nonatomic) NSURL *filePath;
@property(nonatomic) NSString* text;
@property (weak, nonatomic) IBOutlet UILabel *lebel;
@property (weak, nonatomic) IBOutlet UILabel *overalltone;
@property (weak, nonatomic) IBOutlet UILabel *overallscore;
@property (weak, nonatomic) IBOutlet UILabel *angerLabel;
@property (weak, nonatomic) IBOutlet UILabel *fearLabel;
@property (weak, nonatomic) IBOutlet UILabel *joyLabel;
@property (weak, nonatomic) IBOutlet UILabel *sadnessLabel;
@property (weak, nonatomic) IBOutlet UILabel *analytialLabel;
@property (weak, nonatomic) IBOutlet UILabel *confidnetLabel;
@property (weak, nonatomic) IBOutlet UILabel *tentativeLabel;
@property (weak, nonatomic) IBOutlet UIView *background;

@end

NS_ASSUME_NONNULL_END
