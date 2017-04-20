

#import "UIView+Xib.h"

@implementation UIView (Xib)
+ (instancetype)viewForXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}
@end
