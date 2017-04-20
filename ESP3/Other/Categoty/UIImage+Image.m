
#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (UIImage *)imageNameWithOriginalMode:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)xmg_circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] xmg_circleImage];
}

- (instancetype)xmg_circleImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    [clipPath addClip];
    
    [self drawAtPoint:CGPointZero];
    
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return circleImage;
}
@end
