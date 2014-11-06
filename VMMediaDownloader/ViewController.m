//
//  ViewController.m
//  VMMediaDownloader
//
//  Created by Sun Peng on 11/6/14.
//  Copyright (c) 2014 Peng Sun. All rights reserved.
//

#import "ViewController.h"
#import "M3U8Handler.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *urlField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.urlField.text = @"http://pl.youku.com/playlist/m3u8?vid=118402875&type=mp4&ts=1415233731&keyframe=0&ep=diaVH0uOVckD5SPeiT8bMX3jdSUIXP8L%2FhuFg9plBdQmSuG9&sid=441523373001112fa11b7&token=2292&ctype=12&ev=1&oip=2081459012";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downloadVideo:(id)sender {
    M3U8Handler *handler = [[M3U8Handler alloc] init];
    [handler praseUrl:self.urlField.text];
    handler.playlist.uuid = @"movie1";
    _downloader = [[VideoDownloader alloc] initWithM3U8List:handler.playlist];
    _downloader.delegate = self;

    [_downloader startDownloadVideo];
}

-(void)videoDownloaderFinished:(VideoDownloader*)request
{
    [request createLocalM3U8file];
}

- (void)videoDownloaderFailed:(VideoDownloader *)request {
    NSLog(@"Video Download Failed..");
}

- (IBAction)playLocal:(id)sender {
    MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://127.0.0.1:12345/movie1/movie.m3u8"]];
    [self presentMoviePlayerViewControllerAnimated:playerViewController];
}

@end
