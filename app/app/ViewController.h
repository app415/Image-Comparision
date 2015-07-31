//
//  ViewController.h
//  app
//
//  Created by subahan on 24/07/15.
//  Copyright (c) 2015 appface. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoCameraController.h"

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,VideoCameraControllerDelegate>
{
    UIImage* images;
    VideoCameraController * videoCamera;
}


@property (weak, nonatomic) IBOutlet UIButton *load;

@property (weak, nonatomic) IBOutlet UIButton *compare;
@property (weak, nonatomic) IBOutlet UIButton *camerabutton;
@property (weak, nonatomic) IBOutlet UIImageView *basicImage;
@property (weak, nonatomic) IBOutlet UIImageView *referenceImage;
- (IBAction)loadImage:(id)sender;
- (IBAction)compareImages:(id)sender;
- (IBAction)camera:(id)sender;

@end

