//
//  ViewController.m
//  app
//
//  Created by subahan on 24/07/15.
//  Copyright (c) 2015 appface. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize basicImage;
@synthesize referenceImage;
@synthesize load;
@synthesize compare;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    videoCamera = [[VideoCameraController alloc] init];
    videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    videoCamera.defaultFPS = 15;
    videoCamera.delegate = self;
    [videoCamera start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadImage:(id)sender {
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.delegate=self;
    picker.allowsEditing=YES;
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        return;
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
   
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSLog(@"%@",chosenImage);
    basicImage.image = chosenImage;
     [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)compareImages:(id)sender {
    NSLog(@"compaing");
    CGFloat width =150.0f;
    
    CGFloat height=100.0f;
    
    
    CGSize newSize1 = CGSizeMake(150,100); //(width, height); //whaterver size
    
    UIGraphicsBeginImageContext(newSize1);
    
    [[UIImage imageNamed:@"positive2.jpg" ] drawInRect:CGRectMake(0, 0, newSize1.width, newSize1.height)];
    
    UIImage *newImage1 = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
   
    
    
    
    
    CGSize newSize2 = CGSizeMake(150,100);//(width, height); //whaterver size
    
    UIGraphicsBeginImageContext(newSize2);
    
    [[UIImage imageNamed:@"neagative.jpg"] drawInRect:CGRectMake(0, 0, newSize2.width, newSize2.height)];
    
    UIImage *newImage2 = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
   
    
    //  UIImage* photo=self->resultView.image;//self.imageView.image;
  //  UIImageView *imageview_camera=(UIImageView *)[self.view viewWithTag:-3];
   // NSLog(@"%@",photoCamera);
    // UIImageView *image=(UIImageView*)photoCamera;
    //UIImage *photo= UIImageView* [self.imageView.image];
   
    CGSize newSize3 = CGSizeMake(150,100);//(width, height); //whaterver size
    
    UIGraphicsBeginImageContext(newSize3);
    
   [basicImage.image  drawInRect:CGRectMake(0, 0, newSize3.width, newSize3.height)];
    
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
    
    self.referenceImage.image=newImage1;
    
    if (percentage_similar>=20.0f)
        
    {
        
        str=[[NSString alloc]initWithString:[NSString stringWithFormat:@"%i%@ Identical", (int)((numDifferences*100)/totalCompares),@"%"]];
        
        NSLog(@"%@",str);
        
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"i-App" message:[NSString stringWithFormat:@" Images are same"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alertview show];
        
        
        
    }
    
    else
        
    {
        
        str=[[NSString alloc]initWithString:[NSString stringWithFormat:@"Result: %i%@ Identical",(int)((numDifferences*100)/totalCompares),@"%"]];
        
         NSLog(@"%@",str);
        
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"i-App" message:[NSString stringWithFormat:@" Images are not same"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertview show];
        
    }
    
}

- (IBAction)camera:(id)sender {
    
}


- (void)processImage:(const vImage_Buffer)imagebuf withRenderContext: (CGContextRef)contextOverlay {
//    cv::Mat gray((int)imagebuf.height, (int)imagebuf.width,
   //              CV_8U, imagebuf.data, imagebuf.rowBytes);
   // cv::GaussianBlur(gray, gray, cv::Size(5, 5), 1.2, 1.2);
   // cv::Canny(gray, gray, 0, 30);
}
- (void)videoCameraViewController: (VideoCameraController*)videoCameraViewController capturedImage:(UIImage *)result {
    [self.basicImage setImage:result];}

- (void)videoCameraViewControllerDone:
(VideoCameraController*)videoCameraViewController {}
//- (BOOL)allowMultipleImages { return YES; }
//- (BOOL)allowPreviewLayer { return NO; }
//- (UIView*)getPreviewView { return UIImageView; }

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
    
    unsigned long byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;
    
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




@end
