//
//  POSPaintViewController.m
//  POSPay
//
//  Created by mq on 15/2/9.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//
#define kPaletteHeight			30
#define kPaletteSize			5
#define kMinEraseInterval		0.5

// Padding for margins
#define kLeftMargin				10.0
#define kTopMargin				10.0
#define kRightMargin			10.0

//FUNCTIONS:
/*
 HSL2RGB Converts hue, saturation, luminance values to the equivalent red, green and blue values.
 For details on this conversion, see Fundamentals of Interactive Computer Graphics by Foley and van Dam (1982, Addison and Wesley)
 You can also find HSL to RGB conversion algorithms by searching the Internet.
 See also http://en.wikipedia.org/wiki/HSV_color_space for a theoretical explanation
 */
static void HSL2RGB(float h, float s, float l, float* outR, float* outG, float* outB)
{
    float			temp1,
    temp2;
    float			temp[3];
    int				i;
    
    // Check for saturation. If there isn't any just return the luminance value for each, which results in gray.
    if(s == 0.0) {
        if(outR)
            *outR = l;
        if(outG)
            *outG = l;
        if(outB)
            *outB = l;
        return;
    }
    
    // Test for luminance and compute temporary values based on luminance and saturation
    if(l < 0.5)
        temp2 = l * (1.0 + s);
    else
        temp2 = l + s - l * s;
    temp1 = 2.0 * l - temp2;
    
    // Compute intermediate values based on hue
    temp[0] = h + 1.0 / 3.0;
    temp[1] = h;
    temp[2] = h - 1.0 / 3.0;
    
    for(i = 0; i < 3; ++i) {
        
        // Adjust the range
        if(temp[i] < 0.0)
            temp[i] += 1.0;
        if(temp[i] > 1.0)
            temp[i] -= 1.0;
        
        
        if(6.0 * temp[i] < 1.0)
            temp[i] = temp1 + (temp2 - temp1) * 6.0 * temp[i];
        else {
            if(2.0 * temp[i] < 1.0)
                temp[i] = temp2;
            else {
                if(3.0 * temp[i] < 2.0)
                    temp[i] = temp1 + (temp2 - temp1) * ((2.0 / 3.0) - temp[i]) * 6.0;
                else
                    temp[i] = temp1;
            }
        }
    }
    
    // Assign temporary values to R, G, B
    if(outR)
        *outR = temp[0];
    if(outG)
        *outG = temp[1];
    if(outB)
        *outB = temp[2];
}



#import "POSPaintViewController.h"

@interface POSPaintViewController ()

@end

@implementation POSPaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat	components[3];
    
    HSL2RGB((CGFloat) 2.0 / (CGFloat)kPaletteSize, kSaturation, kLuminosity, &components[0], &components[1], &components[2]);
    // Defer to the OpenGL view to set the brush color
    [_drawingView setBrushColorWithRed:0.5f green:1.0f  blue:0.7f];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) eraseView
{
    if(CFAbsoluteTimeGetCurrent() > lastTime + kMinEraseInterval) {
        
        [_drawingView erase];
        lastTime = CFAbsoluteTimeGetCurrent();
    }
}

-(UIImage *)getASignScreenShot{
    
     CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions) {
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    }
    else
    {
        UIGraphicsBeginImageContext(imageSize);
    }
    [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  newImage;
    
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
