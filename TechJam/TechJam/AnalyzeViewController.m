//
//  AnalyzeViewController.m
//  TechJam
//
//  Created by Rahil Ali on 2019-09-21.
//  Copyright © 2019 Rahil Ali. All rights reserved.
//

#import "AnalyzeViewController.h"
#import "sentenceViewController.h"

@interface AnalyzeViewController ()
@property(nonatomic) NSArray *textArray;
@property(nonatomic) NSMutableArray *emotions;

@property(nonatomic) NSNumber *overAllScore;
@property(nonatomic) NSString *overAllTone;

@property(nonatomic) NSMutableArray<NSNumber *> *individialScore;
@property(nonatomic) NSMutableArray<NSString *> *individialTone;
@property(nonatomic) NSMutableArray<NSDictionary *> *sentences;

@property(nonatomic) NSMutableArray<NSNumber *> *AngerSentences;
@property(nonatomic) NSMutableArray<NSNumber *> *FearSentences;
@property(nonatomic) NSMutableArray<NSNumber *> *JoySentences;
@property(nonatomic) NSMutableArray<NSNumber *> *SadnessSentences;
@property(nonatomic) NSMutableArray<NSNumber *> *AnalyticalSentences;
@property(nonatomic) NSMutableArray<NSNumber *> *ConfidentSentences;
@property(nonatomic) NSMutableArray<NSNumber *> *TentativeSentences;


@property(nonatomic) NSInteger AngerCount;
@property(nonatomic) NSInteger FearCount;
@property(nonatomic) NSInteger JoyCount;
@property(nonatomic) NSInteger SadnessCount;
@property(nonatomic) NSInteger AnalyticalCount;
@property(nonatomic) NSInteger ConfidentCount;
@property(nonatomic) NSInteger TentativeCount;

@end

@implementation AnalyzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"MyAudioMemo.m4a",
                               nil];
    self.filePath = [NSURL fileURLWithPathComponents:pathComponents];
    
   // self.textArray = [self.text componentsSeparatedByString:@" "];
    self.ConfidentCount = 0;
    self.AnalyticalCount = 0;
    self.TentativeCount = 0;
    self.AngerCount = 0;
    self.SadnessCount = 0;
    self.JoyCount = 0;
    self.FearCount = 0;
    
    self.individialTone = [NSMutableArray array];
    self.sentences = [NSMutableArray array];
    
    self.ConfidentSentences = [NSMutableArray array];
    self.AnalyticalSentences = [NSMutableArray array];
    self.TentativeSentences = [NSMutableArray array];
    self.AngerSentences = [NSMutableArray array];
    self.SadnessSentences = [NSMutableArray array];
    self.JoySentences = [NSMutableArray array];
    self.FearSentences = [NSMutableArray array];
    
    [self postJsonWithString:self.text];
}



- (void)postJsonWithString:(NSString *)string {
    string = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];

    
    NSString *username = @"apikey";
    NSString * password = @"D2aXKAtLoToNB2m04JCf5pe3ztkeoRwEoGJUUYZEqsyt";
    
    
   // SMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://whatever.com"]];
    
    NSString *authStr = @"apikey:D2aXKAtLoToNB2m04JCf5pe3ztkeoRwEoGJUUYZEqsyt";
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
   // [request setValue:authValue forHTTPHeaderField:@"Authorization"];

    
    
    NSString *loginString = [NSString stringWithFormat:@"%@:%@", username, password];
    NSData *loginData = [loginString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64LoginString = [loginData base64EncodedStringWithOptions:0];

    
    NSString *urlString = [NSString stringWithFormat:@"https://gateway-syd.watsonplatform.net/tone-analyzer/api/v3/tone?version=2017-09-21&text=%@", string];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    //create the Method "GET" or "POST"
    [urlRequest setHTTPMethod:@"GET"];
 //   [urlRequest setValue:base64LoginString forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:authValue forHTTPHeaderField:@"Authorization"];

    //Apply the data to the body
  //  [urlRequest setHTTPBody:data1];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSLog(@"The response is - %@",responseDictionary);
            NSInteger success = [[responseDictionary objectForKey:@"success"] integerValue];
            
            NSDictionary *documentTone = [responseDictionary objectForKey:@"document_tone"];
            NSArray *tones = [documentTone objectForKey:@"tones"];
            for(NSDictionary *tone in tones) {
                NSNumber *overAllScore1 = [tone objectForKey:@"score"];
                if (overAllScore1.floatValue > self.overAllScore.floatValue) {
                    self.overAllScore = overAllScore1;
                    self.overAllTone = [tone objectForKey:@"tone_name"];
                }
            }
            
            NSArray *sentenceTone = [responseDictionary objectForKey:@"sentences_tone"];

            for(NSDictionary *tone in sentenceTone) {
                [self.sentences addObject:tone];
                NSString *text = [tone objectForKey:@"text"];
                
                NSArray *tones1 = [tone objectForKey:@"tones"];
                for(NSDictionary *tone in tones1) {
                    //NSNumber *overAllScore = [tone objectForKey:@"score"];
                    //if (overAllScore > self.overAllScore) {
                        NSString *toneName = [tone objectForKey:@"tone_name"];
                        if ([toneName isEqualToString:@"Tentative"]) {
                            [self.TentativeSentences addObject:text];
                            self.TentativeCount++;
                        } else if ([toneName isEqualToString:@"Anger"]) {
                            self.AngerCount++;
                            [self.AngerSentences addObject:text];

                        } else if ([toneName isEqualToString:@"Fear"]) {
                            self.FearCount++;
                            [self.FearSentences addObject:text];

                        } else if ([toneName isEqualToString:@"Joy"]) {
                            self.JoyCount++;
                            [self.JoySentences addObject:text];

                        } else if ([toneName isEqualToString:@"Sadness"]) {
                            self.SadnessCount++;
                            [self.SadnessSentences addObject:text];

                        } else if ([toneName isEqualToString:@"Analytical"]) {
                            self.AnalyticalCount++;
                            [self.AnalyticalSentences addObject:text];

                        } else if ([toneName isEqualToString:@"Confident"]) {
                            self.ConfidentCount++;
                            [self.ConfidentSentences addObject:text];
                        }
                   // }
                }
                
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.overalltone.text = self.overAllTone;
                self.overallscore.text = [NSString stringWithFormat:@"%f", self.overAllScore.floatValue];
                
                self.angerLabel.text = [NSString stringWithFormat:@"%ld", (long)self.AngerCount];
                self.fearLabel.text = [NSString stringWithFormat:@"%ld", (long)self.FearCount];
                self.joyLabel.text = [NSString stringWithFormat:@"%ld", (long)self.JoyCount];
                self.sadnessLabel.text = [NSString stringWithFormat:@"%ld", (long)self.SadnessCount];
                self.analytialLabel.text = [NSString stringWithFormat:@"%ld", (long)self.AnalyticalCount];
                self.confidnetLabel.text = [NSString stringWithFormat:@"%ld", (long)self.ConfidentCount];
                self.tentativeLabel.text = [NSString stringWithFormat:@"%ld", (long)self.TentativeCount];
                
                
                if ([self.overAllTone isEqualToString:@"Tentative"] || [self.overAllTone isEqualToString:@"Anger"] || [self.overAllTone isEqualToString:@"Fear"] || [self.overAllTone isEqualToString:@"Sadness"]) {
                    self.background.backgroundColor = [UIColor colorWithRed:204/255.0 green:0 blue:0 alpha:1];
                } else
                    self.background.backgroundColor = [UIColor colorWithRed:0 green:153/255.0 blue:0 alpha:1];
            });
        }
        else
        {
            NSLog(@"Error");
        }
    }];
    [dataTask resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                   @"Main" bundle:[NSBundle mainBundle]];
    sentenceViewController *vc  = [storyboard instantiateViewControllerWithIdentifier:@"sentence"];    
    UIColor *redcolor = [UIColor colorWithRed:204/255.0 green:0 blue:0 alpha:1];;
    vc.color = [UIColor colorWithRed:0 green:153/255.0 blue:0 alpha:1];
    vc.text = self.text;
    
    if (indexPath.row == 0) {
        vc.sentences = self.AngerSentences;
        vc.color = redcolor;
    }
    
    if (indexPath.row == 1) {
        vc.sentences = self.ConfidentSentences;
    }
    
    if (indexPath.row == 2) {
        vc.sentences = self.SadnessSentences;
        vc.color = redcolor;
    }
    
    if (indexPath.row == 3) {
        vc.sentences = self.JoySentences;
    }
    
    if (indexPath.row == 4) {
        vc.sentences = self.FearSentences;
        vc.color = redcolor;
    }
    
    if (indexPath.row == 5) {
        vc.sentences = self.TentativeSentences;
        vc.color = redcolor;
    }
    
    if (indexPath.row == 6) {
        vc.sentences = self.AnalyticalSentences;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
