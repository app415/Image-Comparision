//
//  ViewController.m
//  app2
//
//  Created by subahan on 27/07/15.
//  Copyright (c) 2015 appface. All rights reserved.
//

#import "ViewController.h"
#import <opencv2/opencv.hpp>


@interface ViewController ()

@end

@implementation ViewController

@synthesize imageView;
@synthesize imageView2;
@synthesize toolbar;
@synthesize take;
@synthesize start;
@synthesize compare;
//@synthesize photoCamera;
@synthesize view;




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    photoCamera=[[CvPhotoCamera alloc]initWithParentView:imageView];
    photoCamera.delegate=self;
    photoCamera.defaultAVCaptureDevicePosition=AVCaptureDevicePositionBack;
    photoCamera.defaultAVCaptureSessionPreset=AVCaptureSessionPresetPhoto;
    photoCamera.defaultAVCaptureVideoOrientation=AVCaptureVideoOrientationPortrait;
    
    [take setEnabled:YES];
    
}


- (NSUInteger)supportedInterfaceOrientations
{
    // Only portrait orientation
    return UIInterfaceOrientationMaskPortrait;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startbutton:(id)sender {
    [photoCamera start];
    [self.view addSubview:imageView];
    [take setEnabled:YES];
    [compare setEnabled:NO];
    
}

- (IBAction)takebutton:(id)sender {
    [photoCamera takePicture];
}

- (IBAction)comparebutton:(id)sender {
    [compare setEnabled:YES];
    CGFloat width =100.0f;
    
    CGFloat height=100.0f;
    
    //    UIImage* a=self.first.image;
    //    UIImage* b=self.second.image;
    
    CGSize newSize1 = CGSizeMake(100,100); //(width, height); //whaterver size
    
    UIGraphicsBeginImageContext(newSize1);
    
    [[UIImage imageNamed:@"positive2.jpg" ] drawInRect:CGRectMake(0, 0, newSize1.width, newSize1.height)];
    
    UIImage *newImage1 = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //self.first.image=newImage1;
    
    
    
    
    CGSize newSize2 = CGSizeMake(100,100);//(width, height); //whaterver size
    
    UIGraphicsBeginImageContext(newSize2);
    
    [[UIImage imageNamed:@"neagative.jpg"] drawInRect:CGRectMake(0, 0, newSize2.width, newSize2.height)];
    
    UIImage *newImage2 = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //   self.second.image=newImage2;
    
    //  UIImage* photo=self->resultView.image;//self.imageView.image;
    // UIImageView *imageview_camera=(UIImageView *)[self.view viewWithTag:-3];
    NSLog(@"%@",photoCamera);
    // UIImageView *image=(UIImageView*)photoCamera;
    //UIImage *photo= UIImageView* [self.imageView.image];
    
    
    CGSize newSize3 = CGSizeMake(100,100);//(width, height); //whaterver size
    
    UIGraphicsBeginImageContext(newSize3);
    
    //   [[imageview_camera image ] drawInRect:CGRectMake(0, 0, newSize3.width, newSize3.height)];
    
    UIImage *newImage3 = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    float numDifferences = 0.0f;
    
    float totalCompares = width * height;
    
    
    
    NSArray *img1RGB=[[NSArray alloc]init];
    
    NSArray *img2RGB=[[NSArray alloc]init];
    
    NSArray *img3RGB=[[NSArray alloc]init];
    
    
    
    for (int yCoord = 0; yCoord < height; yCoord += 1)
        
    {
        
        for (int xCoord = 0; xCoord < width; xCoord += 1)
            
        {
            
            img1RGB = [self getRGBAsFromImage:newImage1 atX:xCoord andY:yCoord];
            
            img2RGB = [self getRGBAsFromImage:newImage2 atX:xCoord andY:yCoord];
            
            img3RGB = [self getRGBAsFromImage:newImage3 atX:xCoord andY:yCoord];
            
            
            
            
            
            if (([[img1RGB objectAtIndex:0]floatValue] - [[img3RGB objectAtIndex:0]floatValue]) == 0 || ([[img1RGB objectAtIndex:1]floatValue] - [[img3RGB objectAtIndex:1]floatValue]) == 0 || ([[img1RGB objectAtIndex:2]floatValue] - [[img3RGB objectAtIndex:2]floatValue]) == 0)
                
            {
                
                //one or more pixel components differs by 10% or more
                
                numDifferences++;
                
            }
            
        }
        
    }
    
    
    
    // It will show result in percentage at last
    
    CGFloat percentage_similar=((numDifferences*100)/totalCompares);
    
    NSString *str=NULL;
    
    
    
    if (percentage_similar>=50.0f)
        
    {
        
        str=[[NSString alloc]initWithString:[NSString stringWithFormat:@"%i%@ Identical", (int)((numDifferences*100)/totalCompares),@"%"]];
        
        
        
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"i-App" message:[NSString stringWithFormat:@"%@ Images are same",str] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alertview show];
        
        
        
    }
    
    else
        
    {
        
        str=[[NSString alloc]initWithString:[NSString stringWithFormat:@"Result: %i%@ Identical",(int)((numDifferences*100)/totalCompares),@"%"]];
        
        
        
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"i-App" message:[NSString stringWithFormat:@"%@ Images are not same",str] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertview show];
        
    }
    
}




-(NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy

{
    
    //NSArray *result = [[NSArray alloc]init];
    
    // First get the image into your data buffer
    
    CGImageRef imageRef = [image CGImage];
    
    NSUInteger width = CGImageGetWidth(imageRef);
    
    NSUInteger height = CGImageGetHeight(imageRef);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    
    NSUInteger bytesPerPixel = 4;
    
    NSUInteger bytesPerRow = bytesPerPixel * width;
    
    NSUInteger bitsPerComponent = 8;
    
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGColorSpaceRelease(colorSpace);
    
    
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    
    CGContextRelease(context);
    
    
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    
    int byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;
    
    //    for (int ii = 0 ; ii < count ; ++ii)
    
    //    {
    
    CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
    
    CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
    
    CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
    
    //CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
    
    byteIndex += 4;
    
    
    
    // UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    
    
    //}
    
    free(rawData);
    
    
    
    NSArray *result = [NSArray arrayWithObjects:
                       
                       [NSNumber numberWithFloat:red],
                       
                       [NSNumber numberWithFloat:green],
                       
                       [NSNumber numberWithFloat:blue],nil];
    
    
    
    return result;
    
}

- (void)photoCamera:(CvPhotoCamera*)camera
      capturedImage:(UIImage *)image;
{
    [camera stop];
    view = [[UIImageView alloc]
                  initWithFrame:imageView.bounds];
    
    //UIImage* result = [self applyEffect:image];
    
    // [resultView setImage:result];
    [self.view addSubview:view];
    
    [take setEnabled:NO];
    [start setEnabled:YES];
    //[compareButton setEnabled:YES];
}

- (void)photoCameraCancel:(CvPhotoCamera*)camera;
{
}

- (void)viewDidDisappear:(BOOL)animated
{
    [photoCamera stop];
}


- (void)dealloc
{
    photoCamera.delegate = nil;
}

@end
