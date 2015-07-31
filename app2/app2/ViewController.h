//
//  ViewController.h
//  app2
//
//  Created by subahan on 27/07/15.
//  Copyright (c) 2015 appface. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <opencv2/opencv.hpp>
#import <opencv2/videoio/cap_ios.h>


@interface ViewController : UIViewController<CvPhotoCameraDelegate>
{
    CvPhotoCamera* photoCamera;
    UIImageView* view;
    
}




@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *toolbar;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *referenceImage;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *start;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *take;
@property (weak, nonatomic) IBOutlet UIButton *compare;


- (IBAction)startbutton:(id)sender;
- (IBAction)takebutton:(id)sender;
- (IBAction)comparebutton:(id)sender;

@end

